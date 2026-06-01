import 'package:youpass/l10n/app_localizations.dart';

class PhoneValidators {
  static const int chilePhoneLength = 9;

  static String? validateNationalNumber(
    AppLocalizations l10n,
    String value, {
    String isoCode = 'CL',
  }) {
    if (isoCode == 'CL') {
      return chileMobile(l10n, value);
    }

    if (isoCode == 'PK') {
      return pakistanMobile(l10n, value);
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

  static final RegExp _otpPattern = RegExp(r'^\d{6}$');

  static String? otpCode(AppLocalizations l10n, String? value) {
    if (value == null || value.isEmpty) {
      return l10n.otpRequired;
    }

    if (!_otpPattern.hasMatch(value)) {
      return l10n.otpInvalidLength;
    }

    return null;
  }
}
