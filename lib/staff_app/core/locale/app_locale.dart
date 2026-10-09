import 'package:flutter/material.dart';

abstract final class AppLocale {
  static const Locale english = Locale('en');
  static const Locale spanish = Locale('es');

  static const List<Locale> supported = [english, spanish];

  /// Chile / LatAm default — Spanish unless the user explicitly chooses another.
  static const Locale defaultLocale = spanish;

  static Locale? fromLanguageCode(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'en':
        return english;
      case 'es':
        return spanish;
      default:
        return null;
    }
  }

  static Locale resolveSupported(Locale? locale) {
    if (locale == null) {
      return defaultLocale;
    }

    return fromLanguageCode(locale.languageCode) ?? defaultLocale;
  }
}
