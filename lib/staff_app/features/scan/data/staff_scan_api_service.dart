import 'package:youpass/core/security/device_id_service.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/core/network/base_api_service.dart';
import 'package:youpass/staff_app/core/network/staff_api_endpoints.dart';
import 'package:youpass/staff_app/core/storage/staff_token_store.dart';
import 'package:youpass/staff_app/core/utils/app_logger.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_scan_entry.dart';
import 'package:youpass/staff_app/features/scan/data/staff_offline_scan_queue.dart';
import 'package:youpass/staff_app/features/scan/data/staff_recent_scans_cache.dart';
import 'package:youpass/staff_app/features/scan/domain/models/staff_qr_scan_result.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';

class StaffScanApiService extends BaseApiService {
  StaffScanApiService(
    super.apiClient, {
    StaffOfflineScanQueue? offlineQueue,
    StaffTokenStore? tokenStore,
    DeviceIdService? deviceIdService,
    StaffRecentScansCache? recentScansCache,
  }) : _offlineQueue = offlineQueue ?? StaffOfflineScanQueue(),
       _tokenStore = tokenStore ?? StaffTokenStore(),
       _deviceIdService = deviceIdService ?? DeviceIdService(),
       _recentScansCache = recentScansCache ?? StaffRecentScansCache();

  final StaffOfflineScanQueue _offlineQueue;
  final StaffTokenStore _tokenStore;
  final DeviceIdService _deviceIdService;
  final StaffRecentScansCache _recentScansCache;

  Future<StaffQrScanResult> scanEntry({required String qrPayload}) {
    return _scan(
      endpoint: StaffApiEndpoints.scanEntry,
      qrPayload: qrPayload,
      purpose: StaffQrScanPurpose.entry,
    );
  }

  Future<StaffQrScanResult> scanProduct({required String qrPayload}) {
    return _scan(
      endpoint: StaffApiEndpoints.scanProduct,
      qrPayload: qrPayload,
      purpose: StaffQrScanPurpose.product,
    );
  }

  Future<StaffRecentScansResponse> fetchRecentEntryScans({int limit = 10}) {
    return _fetchRecentScans(purpose: StaffQrScanPurpose.entry, limit: limit);
  }

  Future<StaffRecentScansResponse> fetchRecentProductScans({int limit = 10}) {
    return _fetchRecentScans(purpose: StaffQrScanPurpose.product, limit: limit);
  }

  Future<StaffRecentScansResponse> _fetchRecentScans({
    required StaffQrScanPurpose purpose,
    required int limit,
  }) async {
    final scanType = purpose == StaffQrScanPurpose.entry ? 'entry' : 'product';

    // Always try the server first: connectivity_plus can report "none" while requests
    // succeed (seen on iOS), which used to show stale cached scans.
    {
      try {
        final response = await getModel(
          '${StaffApiEndpoints.scanRecent}?scan_type=$scanType&limit=$limit',
          authenticated: true,
          fromJson: StaffRecentScansResponse.fromJson,
        );
        await _recentScansCache.write(purpose, response.scans);
        final merged = await _mergeWithPendingOffline(
          purpose: purpose,
          serverScans: response.scans,
          limit: limit,
        );
        return StaffRecentScansResponse(scans: merged);
      } catch (_) {
        // Fall through to local cache when network fails.
      }
    }

    final cached = await _recentScansCache.read(purpose);
    final merged = await _mergeWithPendingOffline(
      purpose: purpose,
      serverScans: cached,
      limit: limit,
    );
    return StaffRecentScansResponse(scans: merged);
  }

  Future<List<StaffScanEntry>> _mergeWithPendingOffline({
    required StaffQrScanPurpose purpose,
    required List<StaffScanEntry> serverScans,
    required int limit,
  }) async {
    final scanType = purpose == StaffQrScanPurpose.entry ? 'entry' : 'product';
    final pending =
        (await _offlineQueue.list())
            .where((item) => item.scanType == scanType)
            .toList()
          ..sort((a, b) => b.scannedAt.compareTo(a.scannedAt));

    final pendingEntries = pending
        .map(
          (item) => StaffScanEntry.fromOfflineQueueItem(
            scanType: item.scanType,
            qrPayload: item.qrPayload,
            clientScanId: item.clientScanId,
            scannedAt: item.scannedAt,
          ),
        )
        .toList();

    final pendingIds = pendingEntries
        .map((e) => e.transactionId)
        .whereType<String>()
        .toSet();
    final serverWithoutDup = serverScans.where((scan) {
      final id = scan.transactionId;
      return id == null || id.isEmpty || !pendingIds.contains(id);
    });

    return [...pendingEntries, ...serverWithoutDup].take(limit).toList();
  }

  Future<int> pendingOfflineCount() => _offlineQueue.pendingCount();

  /// Drain local offline queue via HMAC-signed batch sync.
  Future<int> syncOfflineQueue() async {
    await _offlineQueue.dedupeByPayload();
    final pending = await _offlineQueue.list();
    if (pending.isEmpty) {
      return 0;
    }

    // HMAC includes device_id — must match the id used when each item was signed.
    final deviceId = pending.first.deviceId.isNotEmpty
        ? pending.first.deviceId
        : await _deviceIdService.getId();

    final response = await postModel(
      StaffApiEndpoints.scanSync,
      authenticated: true,
      body: {
        'device_id': deviceId,
        'scans': pending.map((item) => item.toSyncJson()).toList(),
      },
      fromJson: (json) => json,
    );

    final results = response['results'];
    final doneIds = <String>[];
    if (results is List) {
      for (final raw in results) {
        if (raw is! Map) {
          continue;
        }
        final map = Map<String, dynamic>.from(raw);
        final id = map['client_scan_id'] as String? ?? '';
        final status = map['status'] as String? ?? '';
        if (id.isEmpty) {
          continue;
        }
        // Keep rejected HMAC items for retry after re-login; drop applied ones.
        if (status == 'applied' ||
            status == 'already_used' ||
            status == 'duplicate_client_id') {
          doneIds.add(id);
        } else if (status == 'rejected' &&
            (map['error_code'] as String?) != 'HMAC_INVALID') {
          doneIds.add(id);
        }
      }
    }

    await _offlineQueue.removeByIds(doneIds);
    AppLogger.debug(
      'Offline sync finished: ${doneIds.length}/${pending.length} settled',
      tag: 'StaffScan',
    );
    return doneIds.length;
  }

  Future<StaffQrScanResult> _scan({
    required String endpoint,
    required String qrPayload,
    required StaffQrScanPurpose purpose,
  }) async {
    // Always ask the server first; real network failures are caught below and queued.
    // A connectivity pre-check misfired on iOS (reported "none" while online), which
    // validated door scans locally instead of against the server.
    try {
      return await postModel(
        endpoint,
        body: {'qr_payload': qrPayload},
        authenticated: true,
        fromJson: (json) => StaffQrScanResult.fromApiJson(
          json,
          purpose: purpose,
          qrPayload: qrPayload,
        ),
      );
    } on ApiException catch (error) {
      if (error.code == 'NETWORK_ERROR') {
        return _queueOfflineOrThrow(qrPayload: qrPayload, purpose: purpose);
      }
      rethrow;
    } catch (error) {
      // iOS sometimes surfaces timeouts / socket failures outside ApiException.
      final message = error.toString().toLowerCase();
      final looksNetwork =
          message.contains('timeout') ||
          message.contains('socket') ||
          message.contains('network') ||
          message.contains('connection') ||
          message.contains('failed host lookup') ||
          message.contains('unreachable');
      if (looksNetwork) {
        return _queueOfflineOrThrow(qrPayload: qrPayload, purpose: purpose);
      }
      rethrow;
    }
  }

  Future<StaffQrScanResult> _queueOfflineOrThrow({
    required String qrPayload,
    required StaffQrScanPurpose purpose,
  }) async {
    final normalizedPayload = qrPayload.trim();
    final secret = await _tokenStore.readOfflineSigningSecret();
    if (secret == null || secret.isEmpty) {
      throw ApiException(
        code: 'OFFLINE_SECRET_MISSING',
        message:
            'Offline scanning needs a fresh staff login. Connect and sign in again, then retry.',
      );
    }

    // Mirror online already_used: do not queue the same QR twice offline.
    final priorQueued = await _offlineQueue.findByPayload(
      purpose: purpose,
      qrPayload: normalizedPayload,
    );
    if (priorQueued != null) {
      AppLogger.debug(
        'Offline duplicate blocked (queue) ${priorQueued.clientScanId}',
        tag: 'StaffScan',
      );
      return _recordOfflineDuplicate(
        purpose: purpose,
        qrPayload: normalizedPayload,
        lastUsedAt: priorQueued.scannedAt,
        priorId: priorQueued.clientScanId,
      );
    }

    final priorCached = await _findCachedPriorScan(
      purpose: purpose,
      qrPayload: normalizedPayload,
    );
    if (priorCached != null) {
      AppLogger.debug(
        'Offline duplicate blocked (cache) ${priorCached.transactionId}',
        tag: 'StaffScan',
      );
      return _recordOfflineDuplicate(
        purpose: purpose,
        qrPayload: normalizedPayload,
        lastUsedAt:
            priorCached.scannedAt ?? priorCached.lastUsedAt ?? DateTime.now(),
        priorId: priorCached.transactionId ?? priorCached.entryId,
      );
    }

    try {
      final queued = await _offlineQueue.enqueue(
        purpose: purpose,
        qrPayload: normalizedPayload,
        signingSecret: secret,
      );

      await _recentScansCache.prepend(
        purpose,
        StaffScanEntry.fromOfflineQueueItem(
          scanType: queued.scanType,
          qrPayload: queued.qrPayload,
          clientScanId: queued.clientScanId,
          scannedAt: queued.scannedAt,
        ),
      );

      AppLogger.debug(
        'Queued offline ${queued.scanType} scan ${queued.clientScanId}',
        tag: 'StaffScan',
      );

      return StaffQrScanResult.pendingOffline(
        qrPayload: normalizedPayload,
        purpose: purpose,
        clientScanId: queued.clientScanId,
        scannedAt: queued.scannedAt.toLocal(),
      );
    } catch (error) {
      AppLogger.debug('Offline queue failed: $error', tag: 'StaffScan');
      throw ApiException(
        code: 'NETWORK_ERROR',
        message:
            'Could not save scan offline. Connect briefly, sign in again, then retry.',
      );
    }
  }

  Future<StaffScanEntry?> _findCachedPriorScan({
    required StaffQrScanPurpose purpose,
    required String qrPayload,
  }) async {
    final needle = qrPayload.trim();
    if (needle.isEmpty) {
      return null;
    }
    final cached = await _recentScansCache.read(purpose);
    for (final scan in cached) {
      final payload = scan.qrPayload?.trim();
      if (payload != null && payload == needle) {
        return scan;
      }
    }
    return null;
  }

  Future<StaffQrScanResult> _recordOfflineDuplicate({
    required StaffQrScanPurpose purpose,
    required String qrPayload,
    required DateTime lastUsedAt,
    String? priorId,
  }) async {
    final scanType = purpose == StaffQrScanPurpose.entry ? 'entry' : 'product';
    // Unique id so we don't overwrite the original pending/valid recent row.
    final attemptId =
        'offline-dup-${DateTime.now().toUtc().millisecondsSinceEpoch}';

    await _recentScansCache.prepend(
      purpose,
      StaffScanEntry.fromOfflineQueueItem(
        scanType: scanType,
        qrPayload: qrPayload,
        clientScanId: attemptId,
        scannedAt: DateTime.now().toUtc(),
        status: StaffScanStatus.duplicate,
        lastUsedAt: lastUsedAt,
      ),
    );

    return StaffQrScanResult.alreadyUsedOffline(
      qrPayload: qrPayload,
      purpose: purpose,
      lastUsedAt: lastUsedAt.toLocal(),
      priorId: priorId,
    );
  }
}
