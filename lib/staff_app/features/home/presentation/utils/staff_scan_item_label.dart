import 'package:youpass/l10n/app_localizations.dart';

String formatStaffScanItemLabel(AppLocalizations l10n, String itemName) {
  if (itemName.startsWith('supervisor_drink_')) {
    return _formatDrinkSupervisorAction(l10n, itemName);
  }

  if (itemName.startsWith('supervisor_entry_manual_validation_')) {
    return _supervisorActionKindLabel(
      l10n,
      itemName.replaceFirst('supervisor_entry_manual_validation_', ''),
    );
  }

  if (itemName.startsWith('supervisor_entry_override_')) {
    return _supervisorActionKindLabel(
      l10n,
      itemName.replaceFirst('supervisor_entry_override_', ''),
    );
  }

  if (itemName.startsWith('supervisor_duplicate_')) {
    return _supervisorActionKindLabel(
      l10n,
      itemName.replaceFirst('supervisor_duplicate_', ''),
    );
  }

  return itemName;
}

String _formatDrinkSupervisorAction(AppLocalizations l10n, String itemName) {
  const prefix = 'supervisor_drink_';
  final rest = itemName.length > prefix.length
      ? itemName.substring(prefix.length)
      : '';
  final separatorIndex = rest.indexOf('_');
  if (separatorIndex <= 0) {
    return _humanize(rest);
  }

  final kind = rest.substring(separatorIndex + 1);
  return _supervisorActionKindLabel(l10n, kind);
}

String _supervisorActionKindLabel(AppLocalizations l10n, String kind) {
  return switch (kind) {
    'release_qr' => l10n.staffSupervisorActionHistoryKindReleaseQr,
    'revalidate_qr' => l10n.staffSupervisorActionHistoryKindRevalidateQr,
    'revert_validation' => l10n.staffSupervisorActionHistoryKindRevertValidation,
    'authorize_reentry' => l10n.staffSupervisorActionHistoryKindAuthorizeReentry,
    'temporary_unlock' => l10n.staffSupervisorActionHistoryKindTemporaryUnlock,
    'release_reentry' => l10n.staffSupervisorActionHistoryKindReleaseReentry,
    'block_qr' => l10n.staffSupervisorActionHistoryKindBlockQr,
    'escalate_alert' => l10n.staffSupervisorActionHistoryKindEscalateAlert,
    'authorize_entry' => l10n.staffSupervisorActionHistoryKindAuthorizeEntry,
    'generate_temporary_qr' =>
      l10n.staffSupervisorActionHistoryKindGenerateTemporaryQr,
    'reject_access' => l10n.staffSupervisorActionHistoryKindRejectAccess,
    'authorize_extra_guest' =>
      l10n.staffSupervisorActionHistoryKindAuthorizeExtraGuest,
    'change_access' => l10n.staffSupervisorActionHistoryKindChangeAccess,
    'move_guest' => l10n.staffSupervisorActionHistoryKindMoveGuest,
    'release_invitation' =>
      l10n.staffSupervisorActionHistoryKindReleaseInvitation,
    'offline_mode_enabled' =>
      l10n.staffSupervisorActionHistoryKindOfflineModeEnabled,
    'offline_mode_disabled' =>
      l10n.staffSupervisorActionHistoryKindOfflineModeDisabled,
    'validations_paused' =>
      l10n.staffSupervisorActionHistoryKindValidationsPaused,
    'validations_resumed' =>
      l10n.staffSupervisorActionHistoryKindValidationsResumed,
    'vip_access_blocked' =>
      l10n.staffSupervisorActionHistoryKindVipAccessBlocked,
    'vip_access_unblocked' =>
      l10n.staffSupervisorActionHistoryKindVipAccessUnblocked,
    'scanner_restarted' => l10n.staffSupervisorActionHistoryKindScannerRestarted,
    'staff_alert' => l10n.staffSupervisorActionHistoryKindStaffAlert,
    'cancel_consumption' => l10n.staffSupervisorCancelConsumption,
    'release_blocked_qr' => l10n.staffSupervisorReleaseBlockedQr,
    'authorize_consumption' => l10n.staffRecentScanActionAuthorizeConsumption,
    'reject_consumption' => l10n.staffRecentScanActionRejectConsumption,
    'authorize_reconsumption' =>
      l10n.staffSupervisorOverrideAuthorizeReconsumption,
    _ => _humanize(kind),
  };
}

String _humanize(String value) {
  if (value.isEmpty) {
    return value;
  }

  return value.replaceAll('_', ' ');
}
