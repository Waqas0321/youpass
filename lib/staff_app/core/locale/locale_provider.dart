import 'package:flutter/material.dart';
import 'package:youpass/staff_app/core/constants/country_code_list.dart';
import 'package:youpass/staff_app/core/locale/app_locale.dart';
import 'package:youpass/staff_app/core/locale/locale_preference_store.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider() {
    _locale = _resolveInitialLocale();
  }

  late Locale _locale;

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    final resolved = AppLocale.resolveSupported(locale);
    if (_locale == resolved) {
      return;
    }

    _locale = resolved;
    LocalePreferenceStore.saveLanguageCode(resolved.languageCode);
    notifyListeners();
  }

  void setLocaleFromLanguageCode(String languageCode) {
    setLocale(AppLocale.fromLanguageCode(languageCode) ?? AppLocale.defaultLocale);
  }

  void setLocaleFromCountry(String isoCode) {
    final country = CountryCodeList.findByIsoCode(isoCode);
    setLocaleFromLanguageCode(country.defaultLanguage);
  }

  void setEnglish() => setLocale(AppLocale.english);

  void setSpanish() => setLocale(AppLocale.spanish);

  Locale _resolveInitialLocale() {
    final savedCode = LocalePreferenceStore.languageCode;
    if (savedCode != null) {
      final savedLocale = AppLocale.fromLanguageCode(savedCode);
      if (savedLocale != null) {
        return savedLocale;
      }
    }

    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    return AppLocale.resolveSupported(deviceLocale);
  }
}
