import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youpass/core/locale/country_format_helper.dart';

class VipCurrencyFormatter {
  VipCurrencyFormatter._();

  static String formatAmount(
    BuildContext context,
    int amount, {
    required String currencyCode,
    String? countryIsoCode,
  }) {
    return _format(
      amount,
      currencyCode: currencyCode,
      countryIsoCode: countryIsoCode,
      includeCurrencyCode: true,
    );
  }

  static String formatAmountCompact(
    BuildContext context,
    int amount, {
    required String currencyCode,
    String? countryIsoCode,
  }) {
    return _format(
      amount,
      currencyCode: currencyCode,
      countryIsoCode: countryIsoCode,
      includeCurrencyCode: false,
    );
  }

  static String _format(
    int amount, {
    required String currencyCode,
    String? countryIsoCode,
    required bool includeCurrencyCode,
  }) {
    final country = CountryFormatHelper.countryFor(
      countryIsoCode: countryIsoCode,
      currencyCode: currencyCode,
    );
    final normalizedCurrency = currencyCode.toUpperCase();
    final locale = CountryFormatHelper.numberLocaleForCountry(country);
    final major = country.currencyDecimals == 0
        ? amount
        : amount / 100;

    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: country.currencySymbol,
      decimalDigits: country.currencyDecimals,
      name: normalizedCurrency,
    );

    var formatted = formatter.format(major);
    if (country.currencyDecimals == 0) {
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
}
