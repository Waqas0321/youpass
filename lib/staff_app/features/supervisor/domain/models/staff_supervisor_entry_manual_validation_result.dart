import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_manual_validation_result.dart';

enum StaffSupervisorEntryManualValidationAction {
  authorizeEntry,
  generateTemporaryQr,
  rejectAccess,
}

extension StaffSupervisorEntryManualValidationActionApi
    on StaffSupervisorEntryManualValidationAction {
  String get apiValue {
    return switch (this) {
      StaffSupervisorEntryManualValidationAction.authorizeEntry => 'authorize_entry',
      StaffSupervisorEntryManualValidationAction.generateTemporaryQr =>
        'generate_temporary_qr',
      StaffSupervisorEntryManualValidationAction.rejectAccess => 'reject_access',
    };
  }
}

enum StaffSupervisorEntryManualValidationSystemStatus {
  pending,
  authorized,
  rejected,
}

extension StaffSupervisorEntryManualReasonApi on StaffSupervisorEntryManualReason {
  String get apiValue {
    return switch (this) {
      StaffSupervisorEntryManualReason.phoneBattery => 'phone_battery',
      StaffSupervisorEntryManualReason.noConnection => 'no_connection',
      StaffSupervisorEntryManualReason.damagedQr => 'damaged_qr',
      StaffSupervisorEntryManualReason.brokenScreen => 'broken_screen',
      StaffSupervisorEntryManualReason.other => 'other',
    };
  }
}

class StaffSupervisorEntryManualValidationContext {
  const StaffSupervisorEntryManualValidationContext({
    required this.ticketId,
    required this.invitationId,
    required this.guestName,
    required this.initials,
    required this.eventName,
    required this.ticketTypeLabel,
    required this.accessLabel,
    required this.qrId,
    required this.guestPhone,
    required this.phoneLastDigits,
    required this.isDocumentConfirmed,
    required this.isQrUnavailable,
    required this.entryStatus,
    required this.systemStatus,
    required this.systemRecordTimeLabel,
    required this.canAuthorize,
  });

  final String ticketId;
  final String invitationId;
  final String guestName;
  final String initials;
  final String eventName;
  final String ticketTypeLabel;
  final String accessLabel;
  final String qrId;
  final String guestPhone;
  final String phoneLastDigits;
  final bool isDocumentConfirmed;
  final bool isQrUnavailable;
  final String entryStatus;
  final StaffSupervisorEntryManualValidationSystemStatus systemStatus;
  final String systemRecordTimeLabel;
  final bool canAuthorize;

  bool get isPending =>
      systemStatus == StaffSupervisorEntryManualValidationSystemStatus.pending;

  StaffSupervisorEntryManualValidationResult get result =>
      StaffSupervisorEntryManualValidationResult(
        guestName: guestName,
        initials: initials,
        eventName: eventName,
        ticketTypeLabel: ticketTypeLabel,
        accessLabel: accessLabel,
        phoneLastDigits: phoneLastDigits,
        isDocumentConfirmed: isDocumentConfirmed,
        isQrUnavailable: isQrUnavailable,
      );

  factory StaffSupervisorEntryManualValidationContext.fromJson(
    Map<String, dynamic> json,
  ) {
    final data = json['context'] as Map<String, dynamic>? ?? json;

    return StaffSupervisorEntryManualValidationContext(
      ticketId: data['ticket_id'] as String? ?? '',
      invitationId: data['invitation_id'] as String? ?? '',
      guestName: data['guest_name'] as String? ?? '',
      initials: data['initials'] as String? ?? '',
      eventName: data['event_name'] as String? ?? '',
      ticketTypeLabel: data['ticket_type_label'] as String? ?? '',
      accessLabel: data['access_label'] as String? ?? '',
      qrId: data['qr_id'] as String? ?? '',
      guestPhone: data['guest_phone'] as String? ?? '',
      phoneLastDigits: data['phone_last_digits'] as String? ?? '',
      isDocumentConfirmed: data['is_document_confirmed'] as bool? ?? false,
      isQrUnavailable: data['is_qr_unavailable'] as bool? ?? true,
      entryStatus: data['entry_status'] as String? ?? 'pending',
      systemStatus: _parseSystemStatus(data['system_status'] as String?),
      systemRecordTimeLabel: data['system_record_time_label'] as String? ?? '--',
      canAuthorize: data['can_authorize'] as bool? ?? false,
    );
  }

  static StaffSupervisorEntryManualValidationSystemStatus _parseSystemStatus(
    String? value,
  ) {
    switch (value) {
      case 'authorized':
        return StaffSupervisorEntryManualValidationSystemStatus.authorized;
      case 'rejected':
        return StaffSupervisorEntryManualValidationSystemStatus.rejected;
      default:
        return StaffSupervisorEntryManualValidationSystemStatus.pending;
    }
  }
}

class StaffSupervisorEntryManualValidationResult {
  const StaffSupervisorEntryManualValidationResult({
    required this.guestName,
    required this.initials,
    required this.eventName,
    required this.ticketTypeLabel,
    required this.accessLabel,
    required this.phoneLastDigits,
    required this.isDocumentConfirmed,
    required this.isQrUnavailable,
  });

  final String guestName;
  final String initials;
  final String eventName;
  final String ticketTypeLabel;
  final String accessLabel;
  final String phoneLastDigits;
  final bool isDocumentConfirmed;
  final bool isQrUnavailable;
}

typedef StaffSupervisorEntryManualReason = StaffSupervisorManualValidationReason;

class StaffSupervisorTemporaryQr {
  const StaffSupervisorTemporaryQr({
    required this.qrPayload,
    required this.entryCode,
    required this.guestName,
    required this.expiresAt,
    required this.validityMinutes,
  });

  final String qrPayload;
  final String entryCode;
  final String guestName;
  final DateTime expiresAt;
  final int validityMinutes;

  factory StaffSupervisorTemporaryQr.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorTemporaryQr(
      qrPayload: json['qr_payload'] as String? ?? '',
      entryCode: json['entry_code'] as String? ?? '',
      guestName: json['guest_name'] as String? ?? '',
      expiresAt: DateTime.tryParse(json['expires_at'] as String? ?? '') ??
          DateTime.now(),
      validityMinutes: json['validity_minutes'] as int? ?? 30,
    );
  }
}

class StaffSupervisorEntryManualValidationApplyResult {
  const StaffSupervisorEntryManualValidationApplyResult({
    required this.applied,
    required this.action,
    required this.context,
    this.temporaryQr,
  });

  final bool applied;
  final StaffSupervisorEntryManualValidationAction action;
  final StaffSupervisorEntryManualValidationContext context;
  final StaffSupervisorTemporaryQr? temporaryQr;

  factory StaffSupervisorEntryManualValidationApplyResult.fromJson(
    Map<String, dynamic> json,
  ) {
    final actionValue = json['action'] as String? ?? '';
    final temporaryQrJson = json['temporary_qr'] as Map<String, dynamic>?;

    return StaffSupervisorEntryManualValidationApplyResult(
      applied: json['applied'] as bool? ?? false,
      action: _parseAction(actionValue),
      context: StaffSupervisorEntryManualValidationContext.fromJson(json),
      temporaryQr: temporaryQrJson == null
          ? null
          : StaffSupervisorTemporaryQr.fromJson(temporaryQrJson),
    );
  }

  static StaffSupervisorEntryManualValidationAction _parseAction(String value) {
    switch (value) {
      case 'generate_temporary_qr':
        return StaffSupervisorEntryManualValidationAction.generateTemporaryQr;
      case 'reject_access':
        return StaffSupervisorEntryManualValidationAction.rejectAccess;
      case 'authorize_entry':
      default:
        return StaffSupervisorEntryManualValidationAction.authorizeEntry;
    }
  }
}
