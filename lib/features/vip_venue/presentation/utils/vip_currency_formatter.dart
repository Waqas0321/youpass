import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youpass/core/locale/country_format_helper.dart';
import 'package:youpass/core/models/country_code.dart';

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
    final normalizedCurrency = currencyCode.toUpperCase();
    final country = CountryFormatHelper.countryFor(
      countryIsoCode: countryIsoCode,
      currencyCode: currencyCode,
    );
    final decimals = _resolveDecimals(
      currencyCode: normalizedCurrency,
      countryIsoCode: countryIsoCode,
      currencyDecimals: currencyDecimals,
      countryDecimals: country.currencyDecimals,
    );
    final major = decimals == 0 ? amount.toDouble() : amount / 100;
    final locale = _numberLocale(
      currencyCode: normalizedCurrency,
      countryIsoCode: countryIsoCode,
      country: country,
    );

    // Avoid NumberFormat.currency symbols like "$" wrongly paired with PKR.
    final formatter = NumberFormat.decimalPattern(locale)
      ..minimumFractionDigits = decimals
      ..maximumFractionDigits = decimals;
    final formatted = formatter.format(major);

    if (!includeCurrencyCode) {
      return formatted;
    }

    if (formatted.toUpperCase().contains(normalizedCurrency)) {
      return formatted;
    }

    return '$formatted $normalizedCurrency';
  }

  static String _numberLocale({
    required String currencyCode,
    String? countryIsoCode,
    required CountryCode country,
  }) {
    final iso = countryIsoCode?.toUpperCase();
    if (currencyCode == 'PKR' || iso == 'PK') {
      return 'en_US';
    }
    return CountryFormatHelper.numberLocaleForCountry(country);
  }

  static int _resolveDecimals({
    required String currencyCode,
    String? countryIsoCode,
    int? currencyDecimals,
    required int countryDecimals,
  }) {
    final iso = countryIsoCode?.toUpperCase();
    // Ticket prices for these markets are stored in major units.
    if (currencyCode == 'PKR' || iso == 'PK' || currencyCode == 'CLP' || iso == 'CL') {
      return 0;
    }

    return currencyDecimals ?? countryDecimals;
  }
}
