import 'package:flutter/material.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/locale/country_locale_mapper.dart';
import 'package:youpass/core/locale/domain/repositories/locale_preference_repository.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(this._localePreferenceRepository) {
    _locale = _resolveInitialLocale();
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

  void setLocaleFromCountry(String isoCode) {
    setLocale(CountryLocaleMapper.localeForCountry(isoCode));
  }

  void setEnglish() => setLocale(AppLocale.english);

  void setSpanish() => setLocale(AppLocale.spanish);

  void setPortuguese() => setLocale(AppLocale.portuguese);

  Locale _resolveInitialLocale() {
    final savedCode = _localePreferenceRepository.loadLanguageCode();
    if (savedCode != null) {
      final savedLocale = AppLocale.fromLanguageCode(savedCode);
      if (savedLocale != null) {
        return savedLocale;
      }
    }

    return AppLocale.defaultLocale;
  }
}
