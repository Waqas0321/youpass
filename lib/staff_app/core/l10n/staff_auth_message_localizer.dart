import 'package:youpass/l10n/app_localizations.dart';

import '../network/api_exception.dart';

class StaffAuthMessageLocalizer {
  StaffAuthMessageLocalizer._();

  static String fromError(AppLocalizations l10n, Object error) {
    if (error is ApiException) {
      return fromApiError(
        l10n,
        code: error.code,
        fallbackMessage: error.message,
        retryAfterSeconds: error.retryAfterSeconds,
      );
    }

    return fromNetworkError(l10n, error);
  }

  static String fromApiError(
    AppLocalizations l10n, {
    String? code,
    String? fallbackMessage,
    int? retryAfterSeconds,
  }) {
    switch (code) {
      case 'STAFF_NOT_FOUND':
        return l10n.errorStaffNotFound;
      case 'INVALID_PHONE':
      case 'PHONE_INVALID':
        return l10n.errorInvalidPhone;
      case 'UNSUPPORTED_COUNTRY':
      case 'PHONE_UNSUPPORTED_COUNTRY':
        return l10n.errorUnsupportedCountry;
      case 'OTP_DELIVERY_FAILED':
        return l10n.errorOtpDeliveryFailed;
      case 'WHATSAPP_NOT_AVAILABLE':
      case 'WHATSAPP_REQUIRED':
        return l10n.errorWhatsAppRequired;
      case 'INVALID_CODE':
        return l10n.errorIncorrectCode;
      case 'CODE_EXPIRED':
        return l10n.errorCodeExpired;
      case 'RESEND_COOLDOWN':
        return l10n.errorResendCooldown(retryAfterSeconds ?? 0);
      case 'BLOCKED':
        if (retryAfterSeconds != null && retryAfterSeconds > 0) {
          return l10n.errorBlockedCountdown(retryAfterSeconds);
        }
        return l10n.errorBlocked;
      case 'MAX_RESENDS':
        if (retryAfterSeconds != null && retryAfterSeconds > 0) {
          return l10n.errorMaxResendsCountdown(retryAfterSeconds);
        }
        return l10n.errorMaxResends;
      case 'VALIDATION_ERROR':
        return l10n.errorValidation;
      case 'NETWORK_ERROR':
        return l10n.errorNetworkConnection;
    }

    if (fallbackMessage != null && fallbackMessage.isNotEmpty) {
      return fallbackMessage;
    }

    return l10n.errorGeneric;
  }

  static String fromNetworkError(AppLocalizations l10n, Object error) {
    final message = error.toString().toLowerCase();

    if (message.contains('connection closed') ||
        message.contains('connection reset') ||
        message.contains('connection refused') ||
        message.contains('failed host lookup') ||
        message.contains('network is unreachable') ||
        message.contains('timed out') ||
        message.contains('timeout')) {
      return l10n.errorNetworkConnection;
    }

    return l10n.errorGeneric;
  }
}
