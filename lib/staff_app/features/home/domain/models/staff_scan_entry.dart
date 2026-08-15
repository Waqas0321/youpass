import 'package:intl/intl.dart';

import 'package:youpass/staff_app/features/scan/domain/models/staff_qr_scan_result.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';

enum StaffScanStatus { success, duplicate, error }

class StaffScanEntry {
  const StaffScanEntry({
    required this.itemName,
    required this.guestName,
    required this.timeLabel,
    required this.status,
    this.eventTitle,
    this.transactionId,
    this.entryId,
    this.qrPayload,
    this.accessLevel,
    this.barName,
    this.productQuantity,
    this.scannedAt,
    this.lastUsedAt,
    this.icon = StaffScanItemIcon.drink,
  });

  final String itemName;
  final String guestName;
  final String timeLabel;
  final StaffScanStatus status;
  final String? eventTitle;
  final String? transactionId;
  final String? entryId;
  final String? qrPayload;
  final String? accessLevel;
  final String? barName;
  final int? productQuantity;
  final DateTime? scannedAt;
  final DateTime? lastUsedAt;
  final StaffScanItemIcon icon;

  factory StaffScanEntry.fromApiJson(Map<String, dynamic> json) {
    final outcome = json['outcome'] as String? ?? 'valid';
    final itemName = json['item_name'] as String? ?? '';
    final scannedAt = _parseDate(json['scanned_at']);
    final lastUsedAt = _parseDate(json['last_used_at']);

    return StaffScanEntry(
      itemName: itemName,
      guestName: json['guest_name'] as String? ?? '',
      eventTitle: json['event_title'] as String?,
      transactionId: json['transaction_id'] as String?,
      entryId: json['entry_id'] as String?,
      qrPayload: json['qr_payload'] as String?,
      accessLevel: json['access_level'] as String?,
      barName: json['bar_name'] as String?,
      productQuantity: (json['product_quantity'] as num?)?.toInt(),
      scannedAt: scannedAt,
      lastUsedAt: lastUsedAt,
      timeLabel: scannedAt != null ? _formatTime(scannedAt) : '--:--',
      status: outcome == 'already_used'
          ? StaffScanStatus.duplicate
          : StaffScanStatus.success,
      icon: _iconForItemName(itemName),
    );
  }

  StaffQrScanResult toQrScanResult(StaffQrScanPurpose purpose) {
    final isDuplicate = status == StaffScanStatus.duplicate;
    final code = entryId ?? transactionId ?? '';
    final payload = (qrPayload != null && qrPayload!.isNotEmpty) ? qrPayload! : code;
    final lastUsed = lastUsedAt ?? (isDuplicate ? scannedAt : null);

    return StaffQrScanResult(
      outcome: isDuplicate
          ? StaffQrScanOutcome.alreadyUsed
          : StaffQrScanOutcome.valid,
      purpose: purpose,
      productName: itemName,
      productQuantity: productQuantity ?? 1,
      guestName: guestName,
      scanTimeLabel: timeLabel,
      transactionId: transactionId ?? code,
      qrPayload: payload,
      eventName: eventTitle,
      entryId: code.isNotEmpty ? code : null,
      accessLevel: accessLevel,
      barName: barName,
      lastUsedTimeLabel:
          lastUsed != null ? _formatTime(lastUsed) : (isDuplicate ? timeLabel : null),
      lastUsedDateLabel: lastUsed != null ? _formatDate(lastUsed) : null,
    );
  }

  static StaffScanItemIcon _iconForItemName(String itemName) {
    final normalized = itemName.toLowerCase();
    if (normalized.contains('beer') ||
        normalized.contains('cerveza') ||
        normalized.contains('corona') ||
        normalized.contains('budweiser')) {
      return StaffScanItemIcon.bottle;
    }
    return StaffScanItemIcon.drink;
  }

  static DateTime? _parseDate(Object? value) {
    if (value is! String || value.isEmpty) {
      return null;
    }
    return DateTime.tryParse(value)?.toLocal();
  }

  static String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static String _formatDate(DateTime dateTime) {
    return DateFormat('d MMM y').format(dateTime);
  }
}

enum StaffScanItemIcon { drink, bottle }

class StaffRecentScansResponse {
  const StaffRecentScansResponse({required this.scans});

  final List<StaffScanEntry> scans;

  factory StaffRecentScansResponse.fromJson(Map<String, dynamic> json) {
    final scansRaw = json['scans'];
    if (scansRaw is! List) {
      return const StaffRecentScansResponse(scans: []);
    }

    return StaffRecentScansResponse(
      scans: scansRaw
          .whereType<Map<String, dynamic>>()
          .map(StaffScanEntry.fromApiJson)
          .toList(),
    );
  }
}
