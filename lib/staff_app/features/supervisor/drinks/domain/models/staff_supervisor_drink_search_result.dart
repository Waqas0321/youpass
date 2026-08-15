enum StaffSupervisorDrinkStatus {
  validated,
  pending,
  cancelled,
  blocked,
  error,
}

enum StaffSupervisorDrinkQuickFilter {
  validated,
  pending,
  cancelled,
  duplicate,
}

enum StaffSupervisorDrinkEventKind {
  validated,
  duplicate,
  supervisor,
  unknown,
}

class StaffSupervisorDrinkEventLog {
  const StaffSupervisorDrinkEventLog({
    required this.timeLabel,
    required this.detail,
    required this.kind,
    this.occurredAt,
  });

  final String timeLabel;
  final String detail;
  final StaffSupervisorDrinkEventKind kind;
  final String? occurredAt;

  factory StaffSupervisorDrinkEventLog.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorDrinkEventLog(
      timeLabel: json['time_label'] as String? ?? '',
      detail: json['detail'] as String? ?? '',
      kind: _parseKind(json['kind'] as String?),
      occurredAt: json['occurred_at'] as String?,
    );
  }

  static StaffSupervisorDrinkEventKind _parseKind(String? value) {
    switch (value) {
      case 'validated':
        return StaffSupervisorDrinkEventKind.validated;
      case 'duplicate':
        return StaffSupervisorDrinkEventKind.duplicate;
      case 'supervisor':
        return StaffSupervisorDrinkEventKind.supervisor;
      default:
        return StaffSupervisorDrinkEventKind.unknown;
    }
  }
}

class StaffSupervisorDrinkSearchResult {
  const StaffSupervisorDrinkSearchResult({
    required this.redemptionId,
    required this.orderId,
    required this.lineId,
    required this.guestName,
    required this.guestPhone,
    required this.productName,
    required this.productQuantity,
    required this.qrId,
    required this.qrPayload,
    required this.orderCode,
    required this.consumptionId,
    required this.status,
    required this.validatedAtLabel,
    required this.barName,
    required this.scannerId,
    required this.isValidated,
    required this.isBlocked,
    required this.eventId,
    required this.eventTitle,
    required this.recentEvents,
  });

  final String redemptionId;
  final String orderId;
  final String lineId;
  final String guestName;
  final String? guestPhone;
  final String productName;
  final int productQuantity;
  final String qrId;
  final String qrPayload;
  final String orderCode;
  final String consumptionId;
  final StaffSupervisorDrinkStatus status;
  final String? validatedAtLabel;
  final String? barName;
  final String? scannerId;
  final bool isValidated;
  final bool isBlocked;
  final String eventId;
  final String eventTitle;
  final List<StaffSupervisorDrinkEventLog> recentEvents;

  factory StaffSupervisorDrinkSearchResult.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorDrinkSearchResult(
      redemptionId: json['redemption_id'] as String? ?? '',
      orderId: json['order_id'] as String? ?? '',
      lineId: json['line_id'] as String? ?? '',
      guestName: json['guest_name'] as String? ?? '',
      guestPhone: json['guest_phone'] as String?,
      productName: json['product_name'] as String? ?? '',
      productQuantity: _parseInt(json['product_quantity'], fallback: 1),
      qrId: json['qr_id'] as String? ?? '',
      qrPayload: json['qr_payload'] as String? ?? '',
      orderCode: json['order_code'] as String? ?? '',
      consumptionId: json['consumption_id'] as String? ?? '',
      status: _parseStatus(json['status'] as String?),
      validatedAtLabel: json['validated_at_label'] as String?,
      barName: json['bar_name'] as String?,
      scannerId: json['scanner_id'] as String?,
      isValidated: json['is_validated'] as bool? ?? false,
      isBlocked: json['is_blocked'] as bool? ?? false,
      eventId: json['event_id'] as String? ?? '',
      eventTitle: json['event_title'] as String? ?? '',
      recentEvents: (json['recent_events'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorDrinkEventLog.fromJson)
          .toList(),
    );
  }

  static StaffSupervisorDrinkStatus _parseStatus(String? value) {
    switch (value) {
      case 'validated':
        return StaffSupervisorDrinkStatus.validated;
      case 'pending':
        return StaffSupervisorDrinkStatus.pending;
      case 'cancelled':
        return StaffSupervisorDrinkStatus.cancelled;
      case 'blocked':
        return StaffSupervisorDrinkStatus.blocked;
      case 'error':
        return StaffSupervisorDrinkStatus.error;
      default:
        return StaffSupervisorDrinkStatus.pending;
    }
  }

  static int _parseInt(Object? value, {required int fallback}) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return fallback;
  }
}

class StaffSupervisorDrinkSearchDetail extends StaffSupervisorDrinkSearchResult {
  const StaffSupervisorDrinkSearchDetail({
    required super.redemptionId,
    required super.orderId,
    required super.lineId,
    required super.guestName,
    required super.guestPhone,
    required super.productName,
    required super.productQuantity,
    required super.qrId,
    required super.qrPayload,
    required super.orderCode,
    required super.consumptionId,
    required super.status,
    required super.validatedAtLabel,
    required super.barName,
    required super.scannerId,
    required super.isValidated,
    required super.isBlocked,
    required super.eventId,
    required super.eventTitle,
    required super.recentEvents,
    required this.lastIdDigits,
    required this.isDocumentConfirmed,
    required this.isQrUnavailable,
    required this.lastUsedAtLabel,
  });

  final String lastIdDigits;
  final bool isDocumentConfirmed;
  final bool isQrUnavailable;
  final String? lastUsedAtLabel;

  factory StaffSupervisorDrinkSearchDetail.fromJson(Map<String, dynamic> json) {
    final summary = StaffSupervisorDrinkSearchResult.fromJson(json);
    return StaffSupervisorDrinkSearchDetail(
      redemptionId: summary.redemptionId,
      orderId: summary.orderId,
      lineId: summary.lineId,
      guestName: summary.guestName,
      guestPhone: summary.guestPhone,
      productName: summary.productName,
      productQuantity: summary.productQuantity,
      qrId: summary.qrId,
      qrPayload: summary.qrPayload,
      orderCode: summary.orderCode,
      consumptionId: summary.consumptionId,
      status: summary.status,
      validatedAtLabel: summary.validatedAtLabel,
      barName: summary.barName,
      scannerId: summary.scannerId,
      isValidated: summary.isValidated,
      isBlocked: summary.isBlocked,
      eventId: summary.eventId,
      eventTitle: summary.eventTitle,
      recentEvents: summary.recentEvents,
      lastIdDigits: json['last_id_digits'] as String? ?? '',
      isDocumentConfirmed: json['is_document_confirmed'] as bool? ?? false,
      isQrUnavailable: json['is_qr_unavailable'] as bool? ?? false,
      lastUsedAtLabel: json['last_used_at_label'] as String?,
    );
  }
}

class StaffSupervisorDrinkSearchResponse {
  const StaffSupervisorDrinkSearchResponse({
    required this.results,
    required this.total,
  });

  final List<StaffSupervisorDrinkSearchResult> results;
  final int total;

  factory StaffSupervisorDrinkSearchResponse.fromJson(Map<String, dynamic> json) {
    final rawResults = json['results'];
    final resultsList = rawResults is List<dynamic> ? rawResults : const [];

    return StaffSupervisorDrinkSearchResponse(
      results: resultsList
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorDrinkSearchResult.fromJson)
          .toList(),
      total: _parseTotal(json['total'], resultsList.length),
    );
  }

  static int _parseTotal(Object? value, int fallback) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return fallback;
  }
}

extension StaffSupervisorDrinkQuickFilterApi on StaffSupervisorDrinkQuickFilter {
  String get apiValue {
    switch (this) {
      case StaffSupervisorDrinkQuickFilter.validated:
        return 'validated';
      case StaffSupervisorDrinkQuickFilter.pending:
        return 'pending';
      case StaffSupervisorDrinkQuickFilter.cancelled:
        return 'cancelled';
      case StaffSupervisorDrinkQuickFilter.duplicate:
        return 'duplicate';
    }
  }
}
