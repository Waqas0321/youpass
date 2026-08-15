enum StaffSupervisorDuplicateReason {
  sharedScreenshot,
  resoldQr,
  validationError,
  authorizedReentry,
  other,
}

enum StaffSupervisorDuplicateAction {
  revalidateQr,
  releaseReentry,
  blockQr,
  escalateAlert,
}

enum StaffSupervisorDuplicateAlertStatus {
  pending,
  resolved,
}

enum StaffSupervisorDuplicateQrLogKind {
  validated,
  reentryRejected,
  supervisorPending,
  supervisorResolved,
}

class StaffSupervisorDuplicateAccessSnapshot {
  const StaffSupervisorDuplicateAccessSnapshot({
    required this.timeLabel,
    required this.accessLabel,
    required this.deviceLabel,
  });

  final String timeLabel;
  final String accessLabel;
  final String deviceLabel;

  factory StaffSupervisorDuplicateAccessSnapshot.fromJson(
    Map<String, dynamic> json,
  ) {
    return StaffSupervisorDuplicateAccessSnapshot(
      timeLabel: json['time_label'] as String? ?? '',
      accessLabel: json['access_label'] as String? ?? '',
      deviceLabel: json['device_label'] as String? ?? '',
    );
  }
}

class StaffSupervisorDuplicateQrLog {
  const StaffSupervisorDuplicateQrLog({
    required this.kind,
    required this.timeLabel,
    required this.detail,
  });

  final StaffSupervisorDuplicateQrLogKind kind;
  final String timeLabel;
  final String detail;

  bool get isSuccess => kind == StaffSupervisorDuplicateQrLogKind.validated;

  bool get isRejected =>
      kind == StaffSupervisorDuplicateQrLogKind.reentryRejected;

  bool get isPending =>
      kind == StaffSupervisorDuplicateQrLogKind.supervisorPending;

  bool get isResolved =>
      kind == StaffSupervisorDuplicateQrLogKind.supervisorResolved;

  factory StaffSupervisorDuplicateQrLog.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorDuplicateQrLog(
      kind: _parseKind(json['kind'] as String?),
      timeLabel: json['time_label'] as String? ?? '',
      detail: json['detail'] as String? ?? '',
    );
  }

  static StaffSupervisorDuplicateQrLogKind _parseKind(String? value) {
    switch (value) {
      case 'validated':
        return StaffSupervisorDuplicateQrLogKind.validated;
      case 'reentry_rejected':
        return StaffSupervisorDuplicateQrLogKind.reentryRejected;
      case 'supervisor_pending':
        return StaffSupervisorDuplicateQrLogKind.supervisorPending;
      case 'supervisor_resolved':
        return StaffSupervisorDuplicateQrLogKind.supervisorResolved;
      default:
        return StaffSupervisorDuplicateQrLogKind.reentryRejected;
    }
  }
}

class StaffSupervisorDuplicateAlert {
  const StaffSupervisorDuplicateAlert({
    required this.ticketId,
    required this.invitationId,
    required this.guestName,
    required this.eventName,
    required this.ticketTypeLabel,
    required this.qrId,
    required this.purchaseId,
    required this.isVip,
    required this.isPending,
    required this.status,
    required this.lastValidAccess,
    required this.newAttempt,
    required this.qrHistory,
  });

  final String ticketId;
  final String invitationId;
  final String guestName;
  final String eventName;
  final String ticketTypeLabel;
  final String qrId;
  final String purchaseId;
  final bool isVip;
  final bool isPending;
  final StaffSupervisorDuplicateAlertStatus status;
  final StaffSupervisorDuplicateAccessSnapshot lastValidAccess;
  final StaffSupervisorDuplicateAccessSnapshot newAttempt;
  final List<StaffSupervisorDuplicateQrLog> qrHistory;

  factory StaffSupervisorDuplicateAlert.fromJson(Map<String, dynamic> json) {
    final history = json['qr_history'] as List<dynamic>? ?? const [];
    final statusRaw = json['status'] as String? ?? 'pending';

    return StaffSupervisorDuplicateAlert(
      ticketId: json['ticket_id'] as String? ?? '',
      invitationId: json['invitation_id'] as String? ?? '',
      guestName: json['guest_name'] as String? ?? '',
      eventName: json['event_name'] as String? ?? '',
      ticketTypeLabel: json['ticket_type_label'] as String? ?? '',
      qrId: json['qr_id'] as String? ?? '',
      purchaseId: json['purchase_id'] as String? ?? '',
      isVip: json['is_vip'] as bool? ?? false,
      isPending: json['is_pending'] as bool? ??
          statusRaw != 'resolved',
      status: statusRaw == 'resolved'
          ? StaffSupervisorDuplicateAlertStatus.resolved
          : StaffSupervisorDuplicateAlertStatus.pending,
      lastValidAccess: StaffSupervisorDuplicateAccessSnapshot.fromJson(
        json['last_valid_access'] as Map<String, dynamic>? ?? const {},
      ),
      newAttempt: StaffSupervisorDuplicateAccessSnapshot.fromJson(
        json['new_attempt'] as Map<String, dynamic>? ?? const {},
      ),
      qrHistory: history
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorDuplicateQrLog.fromJson)
          .toList(growable: false),
    );
  }
}

extension StaffSupervisorDuplicateReasonApi on StaffSupervisorDuplicateReason {
  String get apiValue {
    switch (this) {
      case StaffSupervisorDuplicateReason.sharedScreenshot:
        return 'shared_screenshot';
      case StaffSupervisorDuplicateReason.resoldQr:
        return 'resold_qr';
      case StaffSupervisorDuplicateReason.validationError:
        return 'validation_error';
      case StaffSupervisorDuplicateReason.authorizedReentry:
        return 'authorized_reentry';
      case StaffSupervisorDuplicateReason.other:
        return 'other';
    }
  }
}

extension StaffSupervisorDuplicateActionApi on StaffSupervisorDuplicateAction {
  String get apiValue {
    switch (this) {
      case StaffSupervisorDuplicateAction.revalidateQr:
        return 'revalidate_qr';
      case StaffSupervisorDuplicateAction.releaseReentry:
        return 'release_reentry';
      case StaffSupervisorDuplicateAction.blockQr:
        return 'block_qr';
      case StaffSupervisorDuplicateAction.escalateAlert:
        return 'escalate_alert';
    }
  }
}
