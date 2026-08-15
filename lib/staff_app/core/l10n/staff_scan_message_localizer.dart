import 'package:youpass/l10n/app_localizations.dart';

import '../network/api_exception.dart';
import 'staff_auth_message_localizer.dart';

class StaffScanMessageLocalizer {
  StaffScanMessageLocalizer._();

  static String fromError(AppLocalizations l10n, Object error) {
    if (error is ApiException) {
      return fromApiError(
        l10n,
        code: error.code,
        fallbackMessage: error.message,
      );
    }

    return StaffAuthMessageLocalizer.fromNetworkError(l10n, error);
  }

  static String fromApiError(
    AppLocalizations l10n, {
    String? code,
    String? fallbackMessage,
  }) {
    switch (code) {
      case 'QR_NOT_FOUND':
      case 'DRINK_QR_NOT_FOUND':
        return l10n.staffScanErrorQrNotFound;
      case 'QR_INVALID':
      case 'DRINK_ORDER_NOT_REDEEMABLE':
        return l10n.staffScanErrorQrInvalid;
      case 'STAFF_PERMISSION_DENIED':
        return l10n.staffScanErrorPermissionDenied;
      case 'UNAUTHORIZED':
      case 'SESSION_INVALID':
        return l10n.staffScanErrorSessionExpired;
      case 'NETWORK_ERROR':
        return l10n.errorNetworkConnection;
    }

    if (fallbackMessage != null && fallbackMessage.isNotEmpty) {
      return fallbackMessage;
    }

    return l10n.errorGeneric;
  }
}
