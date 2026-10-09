import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:youpass/staff_app/features/home/domain/models/staff_scan_entry.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';

/// Local cache of recent staff scans so the list still shows offline.
class StaffRecentScansCache {
  StaffRecentScansCache();

  static const _entryKey = 'staff_recent_entry_scans_v1';
  static const _productKey = 'staff_recent_product_scans_v1';

  Future<List<StaffScanEntry>> read(StaffQrScanPurpose purpose) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyFor(purpose));
    if (raw == null || raw.isEmpty) {
      return const [];
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return const [];
      }
      return decoded
          .whereType<Map>()
          .map(
            (item) =>
                StaffScanEntry.fromApiJson(Map<String, dynamic>.from(item)),
          )
          .toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> write(
    StaffQrScanPurpose purpose,
    List<StaffScanEntry> scans,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final payload = jsonEncode(
      scans.take(50).map((scan) => scan.toCacheJson()).toList(),
    );
    await prefs.setString(_keyFor(purpose), payload);
  }

  Future<void> prepend(StaffQrScanPurpose purpose, StaffScanEntry entry) async {
    final current = await read(purpose);
    final withoutDup = current
        .where(
          (scan) =>
              scan.transactionId != entry.transactionId ||
              entry.transactionId == null ||
              entry.transactionId!.isEmpty,
        )
        .toList();
    await write(purpose, [entry, ...withoutDup]);
  }

  /// Called on logout: the cache is device-wide, so the next staff member must not
  /// see the previous one's scans.
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_entryKey);
    await prefs.remove(_productKey);
  }

  String _keyFor(StaffQrScanPurpose purpose) {
    return purpose == StaffQrScanPurpose.entry ? _entryKey : _productKey;
  }
}
