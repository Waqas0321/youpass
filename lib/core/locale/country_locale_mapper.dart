import 'package:flutter/material.dart';
import 'package:youpass/core/constants/country_code_registry.dart';
import 'package:youpass/core/locale/app_locale.dart';

class CountryLocaleMapper {
  CountryLocaleMapper._();

  static Locale localeForCountry(String isoCode) {
    final country = CountryCodeRegistry.findByIsoCode(isoCode);
    return localeForLanguageCode(country.defaultLanguage);
  }

  static Locale localeForLanguageCode(String languageCode) {
    return AppLocale.fromLanguageCode(languageCode) ?? AppLocale.defaultLocale;
  }
}
