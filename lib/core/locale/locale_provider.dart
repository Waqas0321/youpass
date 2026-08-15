import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/locale/country_locale_mapper.dart';
import 'package:youpass/core/locale/domain/repositories/locale_preference_repository.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(this._localePreferenceRepository) {
    _locale = _resolveInitialLocale();
    _localePreferenceRepository.saveLanguageCode(_locale.languageCode);
  }

  final LocalePreferenceRepository _localePreferenceRepository;

  late Locale _locale;

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    final resolved = AppLocale.resolveSupported(locale);
    if (_locale == resolved) {
      return;
    }

    _locale = resolved;
    _localePreferenceRepository.saveLanguageCode(resolved.languageCode);
    notifyListeners();
  }

  void setLocaleFromLanguageCode(String languageCode) {
    setLocale(CountryLocaleMapper.localeForLanguageCode(languageCode));
  }

  /// Phone / billing country must not change UI language.
  void setLocaleFromCountry(String isoCode) {}

  void setEnglish() => setLocale(AppLocale.english);

  void setSpanish() => setLocale(AppLocale.spanish);

  void setPortuguese() => setLocale(AppLocale.portuguese);

  Locale _resolveInitialLocale() {
    final saved = _localePreferenceRepository.loadLanguageCode()?.trim();
    if (saved != null && saved.isNotEmpty) {
      final fromSaved = AppLocale.fromLanguageCode(saved);
      if (fromSaved != null) {
        return fromSaved;
      }
    }

    // Honor the full preferred-languages list (e.g. en then es).
    for (final locale in PlatformDispatcher.instance.locales) {
      final matched = AppLocale.fromLanguageCode(locale.languageCode);
      if (matched != null) {
        return matched;
      }
    }

    return AppLocale.resolveSupported(PlatformDispatcher.instance.locale);
  }
}
