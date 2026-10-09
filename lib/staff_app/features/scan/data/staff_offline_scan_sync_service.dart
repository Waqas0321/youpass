import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/staff_connectivity.dart';
import 'package:youpass/staff_app/core/utils/app_logger.dart';
import 'package:youpass/staff_app/features/scan/data/staff_scan_api_service.dart';

/// Listens for connectivity and drains the offline HMAC scan queue (M10).
class StaffOfflineScanSyncService {
  StaffOfflineScanSyncService({
    StaffScanApiService? scanApiService,
    Connectivity? connectivity,
  }) : _scanApiService = scanApiService ?? StaffScanApiService(ApiClient()),
       _connectivity = connectivity ?? Connectivity();

  final StaffScanApiService _scanApiService;
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _syncing = false;

  void start() {
    _subscription?.cancel();
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      if (staffHasUsableNetwork(results)) {
        unawaited(syncNow());
      }
    });
    unawaited(syncNow());
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  Future<int> syncNow() async {
    if (_syncing) {
      return 0;
    }
    _syncing = true;
    try {
      final results = await _connectivity.checkConnectivity();
      if (!staffHasUsableNetwork(results)) {
        return 0;
      }
      return await _scanApiService.syncOfflineQueue();
    } catch (error) {
      AppLogger.debug('Offline sync failed: $error', tag: 'StaffScan');
      return 0;
    } finally {
      _syncing = false;
    }
  }
}
