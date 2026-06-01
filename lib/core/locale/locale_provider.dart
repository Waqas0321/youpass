import 'package:flutter/material.dart';
import 'package:youpass/core/locale/app_locale.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = AppLocale.defaultLocale;

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) {
      return;
    }

    _locale = locale;
    notifyListeners();
  }

  void setEnglish() => setLocale(AppLocale.english);

  void setSpanish() => setLocale(AppLocale.spanish);
}
