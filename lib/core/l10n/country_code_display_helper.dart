import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/l10n/app_localizations.dart';

class CountryCodeDisplayHelper {
  CountryCodeDisplayHelper._();

  static String localizedName(CountryCode country, AppLocalizations l10n) {
    switch (country.isoCode.toUpperCase()) {
      case 'CL':
        return l10n.categoryChile;
      default:
        return country.name;
    }
  }

  static String localizedPhoneHint(CountryCode country, AppLocalizations l10n) {
    if (country.phoneHint.trim().isNotEmpty) {
      return country.phoneHint;
    }

    switch (country.isoCode.toUpperCase()) {
      case 'CL':
        return AppStrings.phoneHintChile(l10n);
      case 'PK':
        return AppStrings.phoneHintPakistan(l10n);
      default:
        return AppStrings.phoneHintGeneric(l10n);
    }
  }
}
