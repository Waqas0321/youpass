import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:youpass/staff_app/core/locale/locale_provider.dart';
import 'package:youpass/staff_app/core/models/country_code.dart';

abstract final class LocaleSyncHelper {
  static void applyCountry(BuildContext context, CountryCode country) {
    context.read<LocaleProvider>().setLocaleFromLanguageCode(country.defaultLanguage);
  }

  static void applyCountryIso(BuildContext context, String isoCode) {
    if (isoCode.trim().isEmpty) {
      return;
    }

    context.read<LocaleProvider>().setLocaleFromCountry(isoCode);
  }
}
