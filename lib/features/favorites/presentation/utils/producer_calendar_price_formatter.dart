import 'package:intl/intl.dart';
import 'package:youpass/l10n/app_localizations.dart';

class ProducerCalendarPriceParts {
  const ProducerCalendarPriceParts({
    required this.prefix,
    required this.amount,
  });

  final String prefix;
  final String amount;
}

class ProducerCalendarPriceFormatter {
  ProducerCalendarPriceFormatter._();

  static ProducerCalendarPriceParts? parts({
    required AppLocalizations strings,
    required String localeName,
    double? minPrice,
    String? currencyCode,
  }) {
    if (minPrice == null || minPrice <= 0) {
      return null;
    }

    final currency = (currencyCode ?? 'CLP').toUpperCase();
    final amount = _formatAmount(
      amount: minPrice.round(),
      currency: currency,
      localeName: localeName,
    );

    return ProducerCalendarPriceParts(
      prefix: strings.producerEventFromPrice,
      amount: amount,
    );
  }

  static String? label({
    required AppLocalizations strings,
    required String localeName,
    double? minPrice,
    String? currencyCode,
  }) {
    final value = parts(
      strings: strings,
      localeName: localeName,
      minPrice: minPrice,
      currencyCode: currencyCode,
    );
    if (value == null) {
      return null;
    }
    return '${value.prefix} ${value.amount}';
  }

  static String _formatAmount({
    required int amount,
    required String currency,
    required String localeName,
  }) {
    if (currency == 'CLP') {
      final locale = localeName.startsWith('es') ? 'es_CL' : 'en_US';
      final formatted = NumberFormat.currency(
        locale: locale,
        symbol: r'$',
        decimalDigits: 0,
      ).format(amount);
      return '$formatted CLP';
    }

    final formattedAmount = NumberFormat.decimalPattern(localeName).format(amount);
    return '$formattedAmount $currency';
  }
}
