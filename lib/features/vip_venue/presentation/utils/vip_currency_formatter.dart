import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youpass/core/locale/country_format_helper.dart';

class VipTicketPriceDisplay {
  const VipTicketPriceDisplay({
    required this.amountLine,
    required this.currencyLine,
  });

  final String amountLine;
  final String currencyLine;
}

class VipCurrencyFormatter {
  VipCurrencyFormatter._();

  static String formatAmount(
    BuildContext context,
    int amount, {
    required String currencyCode,
    String? countryIsoCode,
    int? currencyDecimals,
  }) {
    return _format(
      amount,
      currencyCode: currencyCode,
      countryIsoCode: countryIsoCode,
      currencyDecimals: currencyDecimals,
      includeCurrencyCode: true,
    );
  }

  static String formatAmountCompact(
    BuildContext context,
    int amount, {
    required String currencyCode,
    String? countryIsoCode,
    int? currencyDecimals,
  }) {
    return _format(
      amount,
      currencyCode: currencyCode,
      countryIsoCode: countryIsoCode,
      currencyDecimals: currencyDecimals,
      includeCurrencyCode: false,
    );
  }

  static VipTicketPriceDisplay formatTicketCardPrice(
    BuildContext context,
    int amount, {
    required String currencyCode,
    String? countryIsoCode,
    int? currencyDecimals,
  }) {
    final normalizedCurrency = currencyCode.toUpperCase();
    return VipTicketPriceDisplay(
      amountLine: _format(
        amount,
        currencyCode: currencyCode,
        countryIsoCode: countryIsoCode,
        currencyDecimals: currencyDecimals,
        includeCurrencyCode: false,
      ),
      currencyLine: normalizedCurrency,
    );
  }

  static String _format(
    int amount, {
    required String currencyCode,
    String? countryIsoCode,
    int? currencyDecimals,
    required bool includeCurrencyCode,
  }) {
    final country = CountryFormatHelper.countryFor(
      countryIsoCode: countryIsoCode,
      currencyCode: currencyCode,
    );
    final normalizedCurrency = currencyCode.toUpperCase();
    final decimals = _resolveDecimals(
      countryIsoCode: countryIsoCode,
      currencyDecimals: currencyDecimals,
      countryDecimals: country.currencyDecimals,
    );
    final locale = CountryFormatHelper.numberLocaleForCountry(country);
    final major = decimals == 0 ? amount : amount / 100;

    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: country.currencySymbol,
      decimalDigits: decimals,
      name: normalizedCurrency,
    );

    var formatted = formatter.format(major);
    if (decimals == 0) {
      formatted = formatted.replaceAll(RegExp(r'[,.]00$'), '');
    }

    if (!includeCurrencyCode) {
      return formatted;
    }

    if (formatted.toUpperCase().contains(normalizedCurrency)) {
      return formatted;
    }

    return '$formatted $normalizedCurrency';
  }

  static int _resolveDecimals({
    String? countryIsoCode,
    int? currencyDecimals,
    required int countryDecimals,
  }) {
    if (countryIsoCode?.toUpperCase() == 'PK') {
      return 0;
    }

    return currencyDecimals ?? countryDecimals;
  }
}
