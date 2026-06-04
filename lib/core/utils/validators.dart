import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/l10n/app_localizations.dart';

class Validators {
  static String? email(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired(l10n);
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return AppStrings.emailInvalid(l10n);
    }
    return null;
  }

  static String? password(AppLocalizations l10n, String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired(l10n);
    }
    if (value.length < 6) {
      return AppStrings.passwordMinLength(l10n);
    }
    return null;
  }
}
