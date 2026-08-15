import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';

class LocaleSyncHelper {
  LocaleSyncHelper._();

  /// Dial-code / country selection must not change app language.
  static void applyCountry(BuildContext context, CountryCode country) {}

  /// Dial-code / country selection must not change app language.
  static void applyCountryIso(BuildContext context, String isoCode) {}

  /// Apply the user's explicit language preference from their profile.
  static void applyProfile(BuildContext context, UserProfileEntity profile) {
    final preferred = profile.preferredLanguage?.trim();
    if (preferred == null || preferred.isEmpty) {
      return;
    }

    context.read<LocaleProvider>().setLocaleFromLanguageCode(preferred);
  }
}
