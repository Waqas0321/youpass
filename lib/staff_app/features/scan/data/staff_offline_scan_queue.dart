import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'package:youpass/core/security/device_id_service.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';

class StaffOfflineScanItem {
  const StaffOfflineScanItem({
    required this.clientScanId,
    required this.scanType,
    required this.qrPayload,
    required this.scannedAtIso,
    required this.deviceId,
    required this.hmac,
  });

  final String clientScanId;
  final String scanType;
  final String qrPayload;

  /// Exact ISO-8601 string used when computing HMAC (must round-trip unchanged).
  final String scannedAtIso;
  final String deviceId;
  final String hmac;

  DateTime get scannedAt =>
      DateTime.tryParse(scannedAtIso)?.toUtc() ?? DateTime.now().toUtc();

  Map<String, dynamic> toJson() => {
    'client_scan_id': clientScanId,
    'scan_type': scanType,
    'qr_payload': qrPayload,
    'scanned_at': scannedAtIso,
    'device_id': deviceId,
    'hmac': hmac,
  };

  /// Sync body item — device_id is sent once at the batch root.
  Map<String, dynamic> toSyncJson() => {
    'client_scan_id': clientScanId,
    'scan_type': scanType,
    'qr_payload': qrPayload,
    'scanned_at': scannedAtIso,
    'hmac': hmac,
  };

  factory StaffOfflineScanItem.fromJson(Map<String, dynamic> json) {
    return StaffOfflineScanItem(
      clientScanId: json['client_scan_id'] as String? ?? '',
      scanType: json['scan_type'] as String? ?? 'product',
      qrPayload: json['qr_payload'] as String? ?? '',
      scannedAtIso:
          json['scanned_at'] as String? ??
          DateTime.now().toUtc().toIso8601String(),
      deviceId: json['device_id'] as String? ?? '',
      hmac: json['hmac'] as String? ?? '',
    );
  }
}

class StaffOfflineScanQueue {
  StaffOfflineScanQueue({
    FlutterSecureStorage? storage,
    DeviceIdService? deviceIdService,
  }) : _storage = storage ?? const FlutterSecureStorage(),
       _deviceIdService = deviceIdService ?? DeviceIdService();

  static const _queueKey = 'staff_offline_scan_queue_v1';

  final FlutterSecureStorage _storage;
  final DeviceIdService _deviceIdService;
  final _uuid = const Uuid();

  Future<List<StaffOfflineScanItem>> list() async {
    final raw = await _storage.read(key: _queueKey);
    if (raw == null || raw.isEmpty) {
      return <StaffOfflineScanItem>[];
    }
    final decoded = jsonDecode(raw);
    if (decoded is! List) {
      return <StaffOfflineScanItem>[];
    }
    // Always growable — enqueue() mutates this list.
    return List<StaffOfflineScanItem>.of(
      decoded
          .whereType<Map>()
          .map(
            (item) =>
                StaffOfflineScanItem.fromJson(Map<String, dynamic>.from(item)),
          )
          .where((item) => item.clientScanId.isNotEmpty),
    );
  }

  Future<int> pendingCount() async => (await list()).length;

  /// Oldest pending item for this QR + scan type, if any.
  Future<StaffOfflineScanItem?> findByPayload({
    required StaffQrScanPurpose purpose,
    required String qrPayload,
  }) async {
    final scanType = purpose == StaffQrScanPurpose.entry ? 'entry' : 'product';
    final needle = qrPayload.trim();
    if (needle.isEmpty) {
      return null;
    }
    final matches =
        (await list())
            .where(
              (item) =>
                  item.scanType == scanType && item.qrPayload.trim() == needle,
            )
            .toList()
          ..sort((a, b) => a.scannedAt.compareTo(b.scannedAt));
    return matches.isEmpty ? null : matches.first;
  }

  /// Keep only the earliest pending scan per QR + scan type.
  Future<int> dedupeByPayload() async {
    final items = await list();
    if (items.length < 2) {
      return 0;
    }
    final kept = <String, StaffOfflineScanItem>{};
    final sorted = List<StaffOfflineScanItem>.of(items)
      ..sort((a, b) => a.scannedAt.compareTo(b.scannedAt));
    for (final item in sorted) {
      final key = '${item.scanType}|${item.qrPayload.trim()}';
      kept.putIfAbsent(key, () => item);
    }
    if (kept.length == items.length) {
      return 0;
    }
    final remaining = kept.values.toList()
      ..sort((a, b) => a.scannedAt.compareTo(b.scannedAt));
    await _persist(remaining);
    return items.length - remaining.length;
  }

  Future<StaffOfflineScanItem> enqueue({
    required StaffQrScanPurpose purpose,
    required String qrPayload,
    required String signingSecret,
  }) async {
    final deviceId = await _deviceIdService.getId();
    final scannedAtIso = DateTime.now().toUtc().toIso8601String();
    final clientScanId = _uuid.v4();
    final scanType = purpose == StaffQrScanPurpose.entry ? 'entry' : 'product';
    final hmac = signOfflineScan(
      signingSecret: signingSecret,
      clientScanId: clientScanId,
      scanType: scanType,
      qrPayload: qrPayload,
      scannedAtIso: scannedAtIso,
      deviceId: deviceId,
    );

    final item = StaffOfflineScanItem(
      clientScanId: clientScanId,
      scanType: scanType,
      qrPayload: qrPayload,
      scannedAtIso: scannedAtIso,
      deviceId: deviceId,
      hmac: hmac,
    );

    final current = List<StaffOfflineScanItem>.of(await list());
    current.add(item);
    await _persist(current);
    return item;
  }

  Future<void> removeByIds(Iterable<String> clientScanIds) async {
    final remove = clientScanIds.toSet();
    if (remove.isEmpty) {
      return;
    }
    final remaining = (await list()).where(
      (item) => !remove.contains(item.clientScanId),
    );
    await _persist(remaining.toList());
  }

  Future<void> clear() => _storage.delete(key: _queueKey);

  Future<void> _persist(List<StaffOfflineScanItem> items) {
    return _storage.write(
      key: _queueKey,
      value: jsonEncode(items.map((item) => item.toJson()).toList()),
    );
  }
}

/// Must match backend `buildOfflineScanCanonical` + `signOfflineScan`.
String signOfflineScan({
  required String signingSecret,
  required String clientScanId,
  required String scanType,
  required String qrPayload,
  required String scannedAtIso,
  required String deviceId,
}) {
  final canonical = [
    'v1',
    clientScanId,
    scanType,
    qrPayload,
    scannedAtIso,
    deviceId,
  ].join('|');
  final digest = Hmac(
    sha256,
    utf8.encode(signingSecret),
  ).convert(utf8.encode(canonical));
  return digest.toString();
}
