import 'package:flutter/material.dart';

class AppLocale {
  AppLocale._();

  static const Locale english = Locale('en');
  static const Locale spanish = Locale('es');
  static const Locale portuguese = Locale('pt');

  static const List<Locale> supported = [english, spanish, portuguese];

  /// Chile / LatAm default — Spanish unless the user explicitly chooses another.
  static const Locale defaultLocale = spanish;

  static Locale? fromLanguageCode(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'en':
        return english;
      case 'es':
        return spanish;
      case 'pt':
        return portuguese;
      default:
        return null;
    }
  }

  static Locale resolveSupported(Locale? locale) {
    if (locale == null) {
      return defaultLocale;
    }

    final supportedLocale = fromLanguageCode(locale.languageCode);
    return supportedLocale ?? defaultLocale;
  }
}
