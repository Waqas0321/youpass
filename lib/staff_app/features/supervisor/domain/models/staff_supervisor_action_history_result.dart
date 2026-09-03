enum StaffSupervisorActionHistoryCategory {
  access,
  entryOverride,
  duplicate,
  manualValidation,
  vip,
  system,
}

enum StaffSupervisorAccessResult {
  valid,
  reEntry,
  rejected,
  supervisor,
  unknown,
}

class StaffSupervisorActionHistoryEntry {
  const StaffSupervisorActionHistoryEntry({
    required this.id,
    required this.category,
    required this.kind,
    required this.supervisorName,
    required this.timeLabel,
    required this.occurredAt,
    this.result = StaffSupervisorAccessResult.unknown,
    this.targetLabel,
    this.guestName,
    this.ticketType,
    this.accessPoint,
    this.deviceLabel,
    this.notes,
    this.ticketId,
    this.entryCode,
  });

  final String id;
  final StaffSupervisorActionHistoryCategory category;
  final String kind;
  final StaffSupervisorAccessResult result;
  final String supervisorName;
  final String timeLabel;
  final String occurredAt;
  final String? targetLabel;
  final String? guestName;
  final String? ticketType;
  final String? accessPoint;
  final String? deviceLabel;
  final String? notes;
  final String? ticketId;
  final String? entryCode;

  factory StaffSupervisorActionHistoryEntry.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorActionHistoryEntry(
      id: json['id'] as String? ?? '',
      category: _parseCategory(json['category'] as String?),
      kind: json['kind'] as String? ?? '',
      result: _parseResult(json['result'] as String?),
      supervisorName:
          json['staff_name'] as String? ??
          json['supervisor_name'] as String? ??
          'Staff',
      timeLabel: json['time_label'] as String? ?? '',
      occurredAt: json['occurred_at'] as String? ?? '',
      targetLabel: json['target_label'] as String? ?? json['guest_name'] as String?,
      guestName: json['guest_name'] as String? ?? json['target_label'] as String?,
      ticketType: json['ticket_type'] as String?,
      accessPoint: json['access_point'] as String?,
      deviceLabel: json['device_label'] as String?,
      notes: json['notes'] as String?,
      ticketId: json['ticket_id'] as String?,
      entryCode: json['entry_code'] as String?,
    );
  }
}

class StaffSupervisorActionHistoryResult {
  const StaffSupervisorActionHistoryResult({
    required this.eventId,
    required this.eventTitle,
    required this.actions,
    required this.total,
  });

  final String eventId;
  final String eventTitle;
  final List<StaffSupervisorActionHistoryEntry> actions;
  final int total;

  factory StaffSupervisorActionHistoryResult.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorActionHistoryResult(
      eventId: json['event_id'] as String? ?? '',
      eventTitle: json['event_title'] as String? ?? '',
      actions: (json['actions'] as List<dynamic>? ?? const [])
          .map(
            (item) => StaffSupervisorActionHistoryEntry.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      total: json['total'] as int? ?? 0,
    );
  }
}

StaffSupervisorActionHistoryCategory _parseCategory(String? value) {
  return switch (value) {
    'access' => StaffSupervisorActionHistoryCategory.access,
    'duplicate' => StaffSupervisorActionHistoryCategory.duplicate,
    'manual_validation' => StaffSupervisorActionHistoryCategory.manualValidation,
    'vip' => StaffSupervisorActionHistoryCategory.vip,
    'system' => StaffSupervisorActionHistoryCategory.system,
    _ => StaffSupervisorActionHistoryCategory.entryOverride,
  };
}

StaffSupervisorAccessResult _parseResult(String? value) {
  return switch (value) {
    'VALID' => StaffSupervisorAccessResult.valid,
    'RE_ENTRY' => StaffSupervisorAccessResult.reEntry,
    'REJECTED' => StaffSupervisorAccessResult.rejected,
    'SUPERVISOR' => StaffSupervisorAccessResult.supervisor,
    _ => StaffSupervisorAccessResult.unknown,
  };
}
