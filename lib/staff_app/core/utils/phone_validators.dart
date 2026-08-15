import 'package:youpass/staff_app/core/config/otp_policy.dart';
import 'package:youpass/l10n/app_localizations.dart';

class PhoneValidators {
  static const int chilePhoneLength = 9;

  static String? validateNationalNumber(
    AppLocalizations l10n,
    String value, {
    String isoCode = 'CL',
  }) {
    switch (isoCode.toUpperCase()) {
      case 'CL':
        return chileMobile(l10n, value);
      case 'PK':
        return pakistanMobile(l10n, value);
      case 'AR':
        return argentinaMobile(l10n, value);
      case 'BR':
        return brazilMobile(l10n, value);
      case 'MX':
        return mexicoMobile(l10n, value);
      case 'CO':
        return colombiaMobile(l10n, value);
      case 'PE':
        return peruMobile(l10n, value);
      default:
        return genericMobile(l10n, value);
    }
  }

  static String? genericMobile(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.phoneRequired;
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 6) {
      return l10n.phoneInvalidGeneric;
    }

    return null;
  }

  static String? pakistanMobile(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.phoneRequired;
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 10) {
      return l10n.phoneInvalidGeneric;
    }

    if (!digits.startsWith('3')) {
      return l10n.phoneInvalidGeneric;
    }

    return null;
  }

  static String? chileMobile(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.phoneRequired;
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != chilePhoneLength) {
      return l10n.phoneInvalidLength;
    }

    if (!digits.startsWith('9')) {
      return l10n.phoneMustStartWithNine;
    }

    return null;
  }

  static String? argentinaMobile(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.phoneRequired;
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10 || digits.length > 11) {
      return l10n.phoneInvalidGeneric;
    }

    return null;
  }

  static String? brazilMobile(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.phoneRequired;
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10 || digits.length > 11) {
      return l10n.phoneInvalidGeneric;
    }

    return null;
  }

  static String? mexicoMobile(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.phoneRequired;
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 10) {
      return l10n.phoneInvalidGeneric;
    }

    return null;
  }

  static String? colombiaMobile(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.phoneRequired;
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 10) {
      return l10n.phoneInvalidGeneric;
    }

    return null;
  }

  static String? peruMobile(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.phoneRequired;
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 9) {
      return l10n.phoneInvalidGeneric;
    }

    return null;
  }

  static String? otpCode(AppLocalizations l10n, String? value) {
    if (value == null || value.isEmpty) {
      return l10n.otpRequired;
    }

    final length = OtpPolicy.codeLength;
    final pattern = RegExp('^\\d{$length}\$');
    if (!pattern.hasMatch(value)) {
      return l10n.otpInvalidLength;
    }

    return null;
  }
}
