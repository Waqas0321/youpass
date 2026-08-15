import 'package:intl/intl.dart';

import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';

enum StaffQrScanOutcome {
  valid,
  alreadyUsed,
}

class StaffQrScanResult {
  const StaffQrScanResult({
    required this.outcome,
    required this.productName,
    required this.guestName,
    required this.scanTimeLabel,
    required this.transactionId,
    required this.qrPayload,
    this.purpose = StaffQrScanPurpose.product,
    this.productQuantity = 1,
    this.barName,
    this.eventName,
    this.entryId,
    this.accessLevel,
    this.lastUsedTimeLabel,
    this.lastUsedDateLabel,
  });

  final StaffQrScanOutcome outcome;
  final String productName;
  final int productQuantity;
  final String guestName;
  final String scanTimeLabel;
  final String? barName;
  final String? eventName;
  final String? entryId;
  final String? accessLevel;
  final String transactionId;
  final String qrPayload;
  final StaffQrScanPurpose purpose;
  final String? lastUsedTimeLabel;
  final String? lastUsedDateLabel;

  bool get isValid => outcome == StaffQrScanOutcome.valid;

  bool get isEntryScan => purpose == StaffQrScanPurpose.entry;

  factory StaffQrScanResult.fromApiJson(
    Map<String, dynamic> json, {
    required StaffQrScanPurpose purpose,
    required String qrPayload,
  }) {
    final outcomeRaw = json['outcome'] as String? ?? 'valid';
    final outcome = outcomeRaw == 'already_used'
        ? StaffQrScanOutcome.alreadyUsed
        : StaffQrScanOutcome.valid;

    final validatedAt = _parseDate(json['validated_at']);
    final lastUsedAt = _parseDate(json['last_used_at']);
    final displayTime = validatedAt ?? lastUsedAt ?? DateTime.now();

    return StaffQrScanResult(
      outcome: outcome,
      purpose: purpose,
      productName: (json['product_name'] ?? json['ticket_type'] ?? '') as String,
      productQuantity: (json['product_quantity'] as num?)?.toInt() ?? 1,
      guestName: json['guest_name'] as String? ?? '',
      scanTimeLabel: _formatTime(displayTime),
      transactionId: (json['transaction_id'] ?? json['entry_id'] ?? '') as String,
      qrPayload: qrPayload,
      eventName: json['event_title'] as String?,
      entryId: json['entry_id'] as String?,
      accessLevel: json['access_level'] as String?,
      barName: json['bar_name'] as String?,
      lastUsedTimeLabel: lastUsedAt != null ? _formatTime(lastUsedAt) : null,
      lastUsedDateLabel: lastUsedAt != null ? _formatDate(lastUsedAt) : null,
    );
  }

  /// Demo mapping for offline UI previews.
  factory StaffQrScanResult.demoFromPayload(
    String qrPayload, {
    StaffQrScanPurpose purpose = StaffQrScanPurpose.product,
  }) {
    final normalized = qrPayload.trim().toLowerCase();
    final isUsed = normalized.contains('used') ||
        normalized.contains('usado') ||
        normalized.endsWith('-dup');

    if (isUsed) {
      return StaffQrScanResult(
        outcome: StaffQrScanOutcome.alreadyUsed,
        purpose: purpose,
        productName: purpose == StaffQrScanPurpose.entry
            ? 'Entrada General'
            : 'Jager Bomb',
        guestName: 'Daniel Rojas',
        scanTimeLabel: '00:48',
        eventName:
            purpose == StaffQrScanPurpose.entry ? 'YouFest 2026' : null,
        entryId:
            purpose == StaffQrScanPurpose.entry ? 'YP-2026-VIP-01234' : null,
        accessLevel: purpose == StaffQrScanPurpose.entry ? 'VIP 1' : null,
        transactionId:
            purpose == StaffQrScanPurpose.entry ? 'YP-2026-VIP-01234' : '004892',
        qrPayload: qrPayload,
        lastUsedTimeLabel:
            purpose == StaffQrScanPurpose.entry ? '00:38 hrs' : '00:41',
        lastUsedDateLabel: purpose == StaffQrScanPurpose.entry
            ? '24 de mayo de 2026'
            : '24 de mayo de 2024',
      );
    }

    return StaffQrScanResult(
      outcome: StaffQrScanOutcome.valid,
      purpose: purpose,
      productName:
          purpose == StaffQrScanPurpose.entry ? 'VIP Mesa' : 'Jager Bomb',
      productQuantity: 1,
      guestName: 'Daniel Rojas',
      scanTimeLabel: '00:42',
      eventName: purpose == StaffQrScanPurpose.entry ? 'YouFest 2026' : null,
      entryId:
          purpose == StaffQrScanPurpose.entry ? 'YP-2026-VIP-01234' : null,
      accessLevel: purpose == StaffQrScanPurpose.entry ? 'VIP 1' : null,
      barName: purpose == StaffQrScanPurpose.entry ? null : 'Red Bull',
      transactionId:
          purpose == StaffQrScanPurpose.entry ? 'YP-2026-VIP-01234' : '004892',
      qrPayload: qrPayload,
    );
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
