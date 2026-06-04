import 'package:youpass/l10n/app_localizations.dart';

/// Maps UI gender labels to API values: male | female | other | prefer_not_to_say
class GenderApiMapper {
  GenderApiMapper._();

  static String toApiValue(String selectedLabel, AppLocalizations l10n) {
    if (selectedLabel == l10n.genderMale) {
      return 'male';
    }
    if (selectedLabel == l10n.genderFemale) {
      return 'female';
    }
    if (selectedLabel == l10n.genderOther) {
      return 'other';
    }
    if (selectedLabel == l10n.genderPreferNotToSay) {
      return 'prefer_not_to_say';
    }

    final normalized = selectedLabel.trim().toLowerCase();
    if (normalized == 'male' ||
        normalized == 'female' ||
        normalized == 'other' ||
        normalized == 'prefer_not_to_say') {
      return normalized;
    }

    return 'other';
  }

  static String toDisplayLabel(String apiValue, AppLocalizations l10n) {
    final normalized = apiValue.trim().toLowerCase();
    switch (normalized) {
      case 'male':
        return l10n.genderMale;
      case 'female':
        return l10n.genderFemale;
      case 'other':
        return l10n.genderOther;
      case 'prefer_not_to_say':
        return l10n.genderPreferNotToSay;
      default:
        return normalized.isEmpty ? '' : l10n.genderOther;
    }
  }
}
