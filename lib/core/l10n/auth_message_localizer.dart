import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youpass/l10n/app_localizations.dart';

class AuthMessageLocalizer {
  AuthMessageLocalizer._();

  static final AppLocalizations _englishL10n =
      lookupAppLocalizations(const Locale('en'));

  /// English text for debug console logs (API/Auth/UI logger).
  static String forDebugLog({
    String? code,
    String? fallbackMessage,
    int? retryAfterSeconds,
    int? remainingAttempts,
  }) {
    return fromApiError(
      _englishL10n,
      code: code,
      fallbackMessage: fallbackMessage,
      retryAfterSeconds: retryAfterSeconds,
      remainingAttempts: remainingAttempts,
    );
  }

  /// Rewrites `error.message` in API JSON bodies to English before logging.
  static String localizeResponseBodyForLog(String rawBody) {
    if (rawBody.isEmpty) {
      return rawBody;
    }

    try {
      final decoded = jsonDecode(rawBody);
      if (decoded is! Map<String, dynamic>) {
        return rawBody;
      }

      final error = decoded['error'];
      if (error is! Map<String, dynamic>) {
        return rawBody;
      }

      final code = error['code'] as String?;
      final retryAfterSeconds = _retryAfterSecondsFromError(error);

      final localized = Map<String, dynamic>.from(error);
      localized['message'] = forDebugLog(
        code: code,
        fallbackMessage: error['message'] as String?,
        retryAfterSeconds: retryAfterSeconds,
      );

      return jsonEncode({...decoded, 'error': localized});
    } catch (_) {
      return rawBody;
    }
  }

  static int? _retryAfterSecondsFromError(Map<String, dynamic> error) {
    final details = error['details'];
    if (details is! Map<String, dynamic>) {
      return null;
    }

    final retryValue = details['retry_after_seconds'];
    if (retryValue is int) {
      return retryValue;
    }
    if (retryValue is num) {
      return retryValue.toInt();
    }

    return null;
  }

  static String fromApiError(
    AppLocalizations l10n, {
    String? code,
    String? fallbackMessage,
    int? retryAfterSeconds,
    int? remainingAttempts,
  }) {
    switch (code) {
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
        if (remainingAttempts != null && remainingAttempts > 0) {
          return l10n.errorIncorrectCodeRemaining(remainingAttempts);
        }
        return l10n.errorIncorrectCode;
      case 'RECAPTCHA_REQUIRED':
      case 'RECAPTCHA_FAILED':
        return l10n.errorRecaptchaFailed;
      case 'CARD_TOKENIZATION_REQUIRED':
        return l10n.errorCardTokenizationRequired;
      case 'CODE_EXPIRED':
        return l10n.errorCodeExpired;
      case 'USER_NOT_FOUND':
        return l10n.errorUserNotFound;
      case 'USER_EXISTS':
        return l10n.errorUserExists;
      case 'UNDERAGE':
      case 'INVALID_BIRTHDATE':
        return fallbackMessage?.isNotEmpty == true
            ? fallbackMessage!
            : l10n.errorValidation;
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
      case 'UNKNOWN_ERROR':
      case 'REQUEST_FAILED':
        return l10n.errorGeneric;
      case 'MISSING_ACCESS_TOKEN':
        return l10n.errorMissingAccessToken;
      case 'UNAUTHORIZED':
      case 'SESSION_INVALID':
      case 'AUTHENTICATION_REQUIRED':
        return l10n.errorAuthenticationRequired;
    }

    if (_isIncorrectCodeMessage(fallbackMessage)) {
      return l10n.errorIncorrectCode;
    }

    if (_isCodeExpiredMessage(fallbackMessage)) {
      return l10n.errorCodeExpired;
    }

    if (fallbackMessage != null && fallbackMessage.isNotEmpty) {
      return fallbackMessage;
    }

    return l10n.errorGeneric;
  }

  static bool _isIncorrectCodeMessage(String? message) {
    if (message == null) {
      return false;
    }

    final normalized = message.toLowerCase();
    return normalized.contains('incorrecto') ||
        normalized.contains('incorrect');
  }

  static bool _isCodeExpiredMessage(String? message) {
    if (message == null) {
      return false;
    }

    final normalized = message.toLowerCase();
    return normalized.contains('expir') ||
        normalized.contains('caduc') ||
        normalized.contains('vencid');
  }
}
