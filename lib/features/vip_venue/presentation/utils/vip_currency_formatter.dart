import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VipCurrencyFormatter {
  VipCurrencyFormatter._();

  static String formatClp(BuildContext context, int amount) {
    final formatted = _currencyFormatter(context).format(amount);
    return '${formatted.replaceAll(',00', '')} CLP';
  }

  static String formatClpCompact(BuildContext context, int amount) {
    return _currencyFormatter(context).format(amount).replaceAll(',00', '');
  }

  static NumberFormat _currencyFormatter(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final locale = languageCode == 'es' ? 'es_CL' : 'en';

    return NumberFormat.currency(
      locale: locale,
      symbol: r'$',
      decimalDigits: 0,
    );
  }
}
