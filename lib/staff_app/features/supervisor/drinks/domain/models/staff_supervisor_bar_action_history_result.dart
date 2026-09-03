import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action.dart';

enum StaffSupervisorRedemptionResult {
  redeemed,
  restored,
  duplicateAttempt,
  supervisor,
  unknown,
}

class StaffSupervisorBarActionHistoryEntry {
  const StaffSupervisorBarActionHistoryEntry({
    required this.id,
    required this.scope,
    required this.kind,
    required this.dashboardType,
    required this.supervisorName,
    required this.guestName,
    required this.timeLabel,
    required this.occurredAt,
    required this.redemptionId,
    required this.entryId,
    this.result = StaffSupervisorRedemptionResult.unknown,
    this.productName,
    this.productQuantity,
    this.barName,
    this.orderId,
    this.manualCode,
    this.currentStatus,
  });

  final String id;
  final String scope;
  final String kind;
  final String dashboardType;
  final StaffSupervisorRedemptionResult result;
  final String supervisorName;
  final String guestName;
  final String timeLabel;
  final String occurredAt;
  final String? redemptionId;
  final String? entryId;
  final String? productName;
  final int? productQuantity;
  final String? barName;
  final String? orderId;
  final String? manualCode;
  final String? currentStatus;

  StaffSupervisorActionType get actionType {
    switch (result) {
      case StaffSupervisorRedemptionResult.restored:
        return StaffSupervisorActionType.qrReleased;
      case StaffSupervisorRedemptionResult.duplicateAttempt:
      case StaffSupervisorRedemptionResult.supervisor:
        return StaffSupervisorActionType.consumptionCancelled;
      case StaffSupervisorRedemptionResult.redeemed:
      case StaffSupervisorRedemptionResult.unknown:
        return StaffSupervisorActionType.manualValidation;
    }
  }

  factory StaffSupervisorBarActionHistoryEntry.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorBarActionHistoryEntry(
      id: json['id'] as String? ?? '',
      scope: json['scope'] as String? ?? '',
      kind: json['kind'] as String? ?? '',
      dashboardType: json['dashboard_type'] as String? ?? 'manual_validation',
      result: _parseResult(json['result'] as String?),
      supervisorName:
          json['staff_name'] as String? ??
          json['supervisor_name'] as String? ??
          '',
      guestName: json['guest_name'] as String? ?? '',
      timeLabel: json['time_label'] as String? ?? '',
      occurredAt: json['occurred_at'] as String? ?? '',
      redemptionId: json['redemption_id'] as String?,
      entryId: json['entry_id'] as String?,
      productName: json['product_name'] as String?,
      productQuantity: (json['product_quantity'] as num?)?.toInt(),
      barName: json['bar_name'] as String?,
      orderId: json['order_id'] as String?,
      manualCode: json['manual_code'] as String? ?? json['entry_id'] as String?,
      currentStatus: json['current_status'] as String?,
    );
  }
}

class StaffSupervisorBarActionHistoryResult {
  const StaffSupervisorBarActionHistoryResult({
    required this.eventId,
    required this.eventTitle,
    required this.actions,
    required this.total,
  });

  final String eventId;
  final String eventTitle;
  final List<StaffSupervisorBarActionHistoryEntry> actions;
  final int total;

  factory StaffSupervisorBarActionHistoryResult.fromJson(Map<String, dynamic> json) {
    final rawActions = json['actions'];
    final actionsList = rawActions is List<dynamic> ? rawActions : const [];

    return StaffSupervisorBarActionHistoryResult(
      eventId: json['event_id'] as String? ?? '',
      eventTitle: json['event_title'] as String? ?? '',
      actions: actionsList
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorBarActionHistoryEntry.fromJson)
          .toList(),
      total: json['total'] is int
          ? json['total'] as int
          : (json['total'] as num?)?.toInt() ?? actionsList.length,
    );
  }
}

StaffSupervisorRedemptionResult _parseResult(String? value) {
  return switch (value) {
    'REDEEMED' => StaffSupervisorRedemptionResult.redeemed,
    'RESTORED' => StaffSupervisorRedemptionResult.restored,
    'DUPLICATE_ATTEMPT' => StaffSupervisorRedemptionResult.duplicateAttempt,
    'SUPERVISOR' => StaffSupervisorRedemptionResult.supervisor,
    _ => StaffSupervisorRedemptionResult.unknown,
  };
}
