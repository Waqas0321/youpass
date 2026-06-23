import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PartyDrinkPriceFormatter {
  PartyDrinkPriceFormatter._();

  static String format(BuildContext context, int amount) {
    if (amount <= 0) {
      final locale = Localizations.localeOf(context);
      return locale.languageCode == 'es' ? 'Gratis' : 'Free';
    }

    final locale = Localizations.localeOf(context);
    final patternLocale = locale.languageCode == 'es' ? 'es_CL' : 'en_US';
    final formatted = NumberFormat.decimalPattern(patternLocale).format(amount);
    return '\$$formatted';
  }
}
