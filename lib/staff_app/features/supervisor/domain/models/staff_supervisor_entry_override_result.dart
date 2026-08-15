enum StaffSupervisorEntryOverrideAction {
  releaseQr,
  revalidateQr,
  revertValidation,
  authorizeReentry,
  temporaryUnlock,
}

extension StaffSupervisorEntryOverrideActionApi on StaffSupervisorEntryOverrideAction {
  String get apiValue {
    return switch (this) {
      StaffSupervisorEntryOverrideAction.releaseQr => 'release_qr',
      StaffSupervisorEntryOverrideAction.revalidateQr => 'revalidate_qr',
      StaffSupervisorEntryOverrideAction.revertValidation => 'revert_validation',
      StaffSupervisorEntryOverrideAction.authorizeReentry => 'authorize_reentry',
      StaffSupervisorEntryOverrideAction.temporaryUnlock => 'temporary_unlock',
    };
  }
}

enum StaffSupervisorEntryOverrideLogKind {
  validated,
  blocked,
  supervisor,
  reentry,
  pending,
}

class StaffSupervisorEntryOverrideLog {
  const StaffSupervisorEntryOverrideLog({
    required this.timeLabel,
    required this.label,
    required this.kind,
  });

  final String timeLabel;
  final String label;
  final StaffSupervisorEntryOverrideLogKind kind;

  bool get isPending => kind == StaffSupervisorEntryOverrideLogKind.pending;

  factory StaffSupervisorEntryOverrideLog.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorEntryOverrideLog(
      timeLabel: json['time_label'] as String? ?? '',
      label: json['label'] as String? ?? '',
      kind: _parseKind(json['kind'] as String?),
    );
  }

  static StaffSupervisorEntryOverrideLogKind _parseKind(String? value) {
    switch (value) {
      case 'validated':
        return StaffSupervisorEntryOverrideLogKind.validated;
      case 'blocked':
        return StaffSupervisorEntryOverrideLogKind.blocked;
      case 'supervisor':
        return StaffSupervisorEntryOverrideLogKind.supervisor;
      case 'reentry':
        return StaffSupervisorEntryOverrideLogKind.reentry;
      case 'pending':
        return StaffSupervisorEntryOverrideLogKind.pending;
      default:
        return StaffSupervisorEntryOverrideLogKind.supervisor;
    }
  }
}

class StaffSupervisorEntryOverrideContext {
  const StaffSupervisorEntryOverrideContext({
    required this.ticketId,
    required this.invitationId,
    required this.guestName,
    required this.initials,
    required this.eventName,
    required this.ticketTypeLabel,
    required this.accessLabel,
    required this.qrId,
    required this.purchaseId,
    required this.isBlocked,
    required this.isValidated,
    required this.entryStatus,
    required this.lastUsedAtLabel,
    required this.scannerId,
    required this.logs,
  });

  final String ticketId;
  final String invitationId;
  final String guestName;
  final String initials;
  final String eventName;
  final String ticketTypeLabel;
  final String accessLabel;
  final String qrId;
  final String purchaseId;
  final bool isBlocked;
  final bool isValidated;
  final String entryStatus;
  final String lastUsedAtLabel;
  final String scannerId;
  final List<StaffSupervisorEntryOverrideLog> logs;

  StaffSupervisorEntryOverrideResult get result => StaffSupervisorEntryOverrideResult(
        guestName: guestName,
        initials: initials,
        eventName: eventName,
        ticketTypeLabel: ticketTypeLabel,
        accessLabel: accessLabel,
        qrId: qrId,
        lastUsedAtLabel: lastUsedAtLabel,
        scannerId: scannerId,
        isBlocked: isBlocked,
        isValidated: isValidated,
        entryStatus: entryStatus,
      );

  factory StaffSupervisorEntryOverrideContext.fromJson(Map<String, dynamic> json) {
    final logsJson = json['logs'] as List<dynamic>? ?? const [];

    return StaffSupervisorEntryOverrideContext(
      ticketId: json['ticket_id'] as String? ?? '',
      invitationId: json['invitation_id'] as String? ?? '',
      guestName: json['guest_name'] as String? ?? '',
      initials: json['initials'] as String? ?? '',
      eventName: json['event_name'] as String? ?? '',
      ticketTypeLabel: json['ticket_type_label'] as String? ?? '',
      accessLabel: json['access_label'] as String? ?? '',
      qrId: json['qr_id'] as String? ?? '',
      purchaseId: json['purchase_id'] as String? ?? '',
      isBlocked: json['is_blocked'] as bool? ?? false,
      isValidated: json['is_validated'] as bool? ?? false,
      entryStatus: json['entry_status'] as String? ?? 'pending',
      lastUsedAtLabel: json['last_used_at_label'] as String? ?? '--',
      scannerId: json['scanner_id'] as String? ?? '--',
      logs: logsJson
          .map(
            (item) => StaffSupervisorEntryOverrideLog.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}

class StaffSupervisorEntryOverrideResult {
  const StaffSupervisorEntryOverrideResult({
    required this.guestName,
    required this.initials,
    required this.eventName,
    required this.ticketTypeLabel,
    required this.accessLabel,
    required this.qrId,
    required this.lastUsedAtLabel,
    required this.scannerId,
    required this.isBlocked,
    required this.isValidated,
    required this.entryStatus,
  });

  final String guestName;
  final String initials;
  final String eventName;
  final String ticketTypeLabel;
  final String accessLabel;
  final String qrId;
  final String lastUsedAtLabel;
  final String scannerId;
  final bool isBlocked;
  final bool isValidated;
  final String entryStatus;
}
