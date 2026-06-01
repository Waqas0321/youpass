import 'package:flutter/material.dart';

class AppLocale {
  AppLocale._();

  static const Locale english = Locale('en');
  static const Locale spanish = Locale('es');

  static const List<Locale> supported = [english, spanish];

  static const Locale defaultLocale = english;
}
