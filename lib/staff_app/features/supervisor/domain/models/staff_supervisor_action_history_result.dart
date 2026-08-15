enum StaffSupervisorActionHistoryCategory {
  entryOverride,
  duplicate,
  manualValidation,
  vip,
  system,
}

class StaffSupervisorActionHistoryEntry {
  const StaffSupervisorActionHistoryEntry({
    required this.id,
    required this.category,
    required this.kind,
    required this.supervisorName,
    required this.timeLabel,
    required this.occurredAt,
    this.targetLabel,
    this.notes,
    this.ticketId,
    this.entryCode,
  });

  final String id;
  final StaffSupervisorActionHistoryCategory category;
  final String kind;
  final String supervisorName;
  final String timeLabel;
  final String occurredAt;
  final String? targetLabel;
  final String? notes;
  final String? ticketId;
  final String? entryCode;

  factory StaffSupervisorActionHistoryEntry.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorActionHistoryEntry(
      id: json['id'] as String? ?? '',
      category: _parseCategory(json['category'] as String?),
      kind: json['kind'] as String? ?? '',
      supervisorName: json['supervisor_name'] as String? ?? 'Supervisor',
      timeLabel: json['time_label'] as String? ?? '',
      occurredAt: json['occurred_at'] as String? ?? '',
      targetLabel: json['target_label'] as String?,
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
    'duplicate' => StaffSupervisorActionHistoryCategory.duplicate,
    'manual_validation' => StaffSupervisorActionHistoryCategory.manualValidation,
    'vip' => StaffSupervisorActionHistoryCategory.vip,
    'system' => StaffSupervisorActionHistoryCategory.system,
    _ => StaffSupervisorActionHistoryCategory.entryOverride,
  };
}
