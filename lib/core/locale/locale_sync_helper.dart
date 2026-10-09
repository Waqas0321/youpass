import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';

class LocaleSyncHelper {
  LocaleSyncHelper._();

  /// Chile / Spanish LatAm → Spanish UI. Brazil → Portuguese.
  static void applyCountry(BuildContext context, CountryCode country) {
    context.read<LocaleProvider>().setLocaleFromCountry(country.isoCode);
  }

  /// Chile / Spanish LatAm → Spanish UI. Brazil → Portuguese.
  static void applyCountryIso(BuildContext context, String isoCode) {
    context.read<LocaleProvider>().setLocaleFromCountry(isoCode);
  }

  /// Apply the user's explicit language preference from their profile.
  static void applyProfile(BuildContext context, UserProfileEntity profile) {
    final preferred = profile.preferredLanguage?.trim();
    if (preferred == null || preferred.isEmpty) {
      return;
    }

    context.read<LocaleProvider>().setLocaleFromLanguageCode(preferred);
  }
}
