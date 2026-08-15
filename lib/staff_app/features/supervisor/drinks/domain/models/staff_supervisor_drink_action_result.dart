import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_drink_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_consumption_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_manual_validation_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_qr_override_result.dart';

class StaffSupervisorDrinkActionApplyResult {
  const StaffSupervisorDrinkActionApplyResult({
    required this.applied,
    required this.action,
    required this.redemptionId,
    this.notes,
    this.detail,
    this.temporaryQr,
  });

  final bool applied;
  final String action;
  final String redemptionId;
  final String? notes;
  final StaffSupervisorDrinkSearchDetail? detail;
  final StaffSupervisorDrinkTemporaryQr? temporaryQr;

  factory StaffSupervisorDrinkActionApplyResult.fromJson(Map<String, dynamic> json) {
    final detailJson = json['detail'];
    final temporaryJson = json['temporary_qr'];

    return StaffSupervisorDrinkActionApplyResult(
      applied: json['applied'] as bool? ?? false,
      action: json['action'] as String? ?? '',
      redemptionId: json['redemption_id'] as String? ?? '',
      notes: json['notes'] as String?,
      detail: detailJson is Map<String, dynamic>
          ? StaffSupervisorDrinkSearchDetail.fromJson(detailJson)
          : null,
      temporaryQr: temporaryJson is Map<String, dynamic>
          ? StaffSupervisorDrinkTemporaryQr.fromJson(temporaryJson)
          : null,
    );
  }
}

class StaffSupervisorDrinkTemporaryQr {
  const StaffSupervisorDrinkTemporaryQr({
    required this.qrPayload,
    required this.consumptionId,
    required this.guestName,
    required this.validityMinutes,
  });

  final String qrPayload;
  final String consumptionId;
  final String guestName;
  final int validityMinutes;

  factory StaffSupervisorDrinkTemporaryQr.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorDrinkTemporaryQr(
      qrPayload: json['qr_payload'] as String? ?? '',
      consumptionId: json['consumption_id'] as String? ?? '',
      guestName: json['guest_name'] as String? ?? '',
      validityMinutes: json['validity_minutes'] as int? ?? 30,
    );
  }
}

extension StaffSupervisorCancellationActionApi on StaffSupervisorCancellationAction {
  String get apiValue {
    switch (this) {
      case StaffSupervisorCancellationAction.cancelConsumption:
        return 'cancel_consumption';
      case StaffSupervisorCancellationAction.revertValidation:
        return 'revert_validation';
      case StaffSupervisorCancellationAction.releaseBlockedQr:
        return 'release_blocked_qr';
    }
  }
}

extension StaffSupervisorQrOverrideActionApi on StaffSupervisorQrOverrideAction {
  String get apiValue {
    switch (this) {
      case StaffSupervisorQrOverrideAction.releaseQr:
        return 'release_qr';
      case StaffSupervisorQrOverrideAction.revalidateQr:
        return 'revalidate_qr';
      case StaffSupervisorQrOverrideAction.revertValidation:
        return 'revert_validation';
      case StaffSupervisorQrOverrideAction.authorizeReconsumption:
        return 'authorize_reconsumption';
      case StaffSupervisorQrOverrideAction.temporaryUnlock:
        return 'temporary_unlock';
    }
  }
}

extension StaffSupervisorManualValidationReasonApi
    on StaffSupervisorManualValidationReason {
  String get apiValue {
    switch (this) {
      case StaffSupervisorManualValidationReason.phoneBattery:
        return 'phone_battery';
      case StaffSupervisorManualValidationReason.noConnection:
        return 'no_connection';
      case StaffSupervisorManualValidationReason.damagedQr:
        return 'damaged_qr';
      case StaffSupervisorManualValidationReason.brokenScreen:
        return 'broken_screen';
      case StaffSupervisorManualValidationReason.other:
        return 'other';
    }
  }
}

enum StaffSupervisorBarManualValidationAction {
  authorizeConsumption,
  generateTemporaryQr,
  rejectConsumption,
}

extension StaffSupervisorBarManualValidationActionApi
    on StaffSupervisorBarManualValidationAction {
  String get apiValue {
    switch (this) {
      case StaffSupervisorBarManualValidationAction.authorizeConsumption:
        return 'authorize_consumption';
      case StaffSupervisorBarManualValidationAction.generateTemporaryQr:
        return 'generate_temporary_qr';
      case StaffSupervisorBarManualValidationAction.rejectConsumption:
        return 'reject_consumption';
    }
  }
}
