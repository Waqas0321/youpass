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

  /// Chile (and other Spanish LatAm countries) use Spanish UI by default.
  void setLocaleFromCountry(String isoCode) {
    final code = isoCode.trim().toUpperCase();
    const spanishCountries = {
      'CL',
      'AR',
      'MX',
      'PE',
      'CO',
      'UY',
      'PY',
      'BO',
      'EC',
      'VE',
      'CR',
      'PA',
      'GT',
      'SV',
      'HN',
      'NI',
      'DO',
    };
    if (spanishCountries.contains(code)) {
      setSpanish();
      return;
    }
    if (code == 'BR') {
      setPortuguese();
    }
  }

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

    // Prefer Spanish when the device offers it (Chile / LatAm).
    for (final locale in PlatformDispatcher.instance.locales) {
      if (locale.languageCode.toLowerCase() == 'es') {
        return AppLocale.spanish;
      }
    }

    for (final locale in PlatformDispatcher.instance.locales) {
      final matched = AppLocale.fromLanguageCode(locale.languageCode);
      if (matched != null) {
        return matched;
      }
    }

    return AppLocale.defaultLocale;
  }
}
