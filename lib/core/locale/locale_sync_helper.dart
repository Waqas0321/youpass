import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';

class LocaleSyncHelper {
  LocaleSyncHelper._();

  static void applyCountry(BuildContext context, CountryCode country) {
    context.read<LocaleProvider>().setLocaleFromLanguageCode(country.defaultLanguage);
  }

  static void applyCountryIso(BuildContext context, String isoCode) {
    if (isoCode.trim().isEmpty) {
      return;
    }

    context.read<LocaleProvider>().setLocaleFromCountry(isoCode);
  }

  static void applyProfile(BuildContext context, UserProfileEntity profile) {
    final preferred = profile.preferredLanguage?.trim();
    if (preferred != null && preferred.isNotEmpty) {
      context.read<LocaleProvider>().setLocaleFromLanguageCode(preferred);
      return;
    }

    applyCountryIso(context, profile.countryCode);
  }
}
