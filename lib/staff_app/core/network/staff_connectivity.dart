import 'package:connectivity_plus/connectivity_plus.dart';

/// Shared network detection for staff offline scan / status UI.
///
/// Note: connectivity is link-level only (not true internet). We intentionally
/// ignore [ConnectivityResult.other] — on iOS it often appears in airplane mode
/// and caused scans to wait on a 30s timeout instead of queuing offline.
bool staffHasUsableNetwork(List<ConnectivityResult> results) {
  if (results.isEmpty) {
    return false;
  }
  return results.any(
    (result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.vpn,
  );
}

Future<bool> staffIsOnline([Connectivity? connectivity]) async {
  try {
    final results = await (connectivity ?? Connectivity()).checkConnectivity();
    return staffHasUsableNetwork(results);
  } catch (_) {
    // If the plugin fails, prefer attempting the request (fail open).
    return true;
  }
}
