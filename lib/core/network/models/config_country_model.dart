import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/utils/json_readers.dart';

class ConfigCountryModel {
  const ConfigCountryModel({
    required this.isoCode,
    required this.name,
    required this.dialCode,
    required this.flagEmoji,
    required this.phoneHint,
    required this.defaultLanguage,
    required this.defaultCurrency,
    required this.timezone,
    required this.paymentGateway,
    required this.currencyDecimals,
    required this.currencySymbol,
  });

  final String isoCode;
  final String name;
  final String dialCode;
  final String flagEmoji;
  final String phoneHint;
  final String defaultLanguage;
  final String defaultCurrency;
  final String timezone;
  final String paymentGateway;
  final int currencyDecimals;
  final String currencySymbol;

  factory ConfigCountryModel.fromJson(Map<String, dynamic> json) {
    final dialCodeRaw = JsonReaders.nullableString(json, 'dial_code') ??
        JsonReaders.nullableString(json, 'dialCode') ??
        '';
    final dialCode = dialCodeRaw.replaceAll(RegExp(r'\D'), '');
    final isoCode = JsonReaders.string(json, 'code');
    final apiPhoneHint = JsonReaders.nullableString(json, 'phone_hint') ??
        JsonReaders.nullableString(json, 'phoneHint');

    return ConfigCountryModel(
      isoCode: isoCode,
      name: JsonReaders.string(json, 'name'),
      dialCode: dialCode,
      flagEmoji: JsonReaders.string(json, 'flag_emoji',
          fallback: JsonReaders.string(json, 'flagEmoji')),
      phoneHint: apiPhoneHint ?? '',
      defaultLanguage: JsonReaders.string(json, 'default_language',
          fallback: JsonReaders.string(json, 'defaultLanguage', fallback: 'es')),
      defaultCurrency: JsonReaders.string(json, 'default_currency',
          fallback: JsonReaders.string(json, 'defaultCurrency', fallback: 'CLP')),
      timezone: JsonReaders.string(json, 'timezone', fallback: 'UTC'),
      paymentGateway: JsonReaders.string(json, 'payment_gateway',
          fallback: JsonReaders.string(json, 'paymentGateway', fallback: 'stripe')),
      currencyDecimals: JsonReaders.integer(json, 'currency_decimals',
          fallback: JsonReaders.integer(json, 'currencyDecimals')),
      currencySymbol: JsonReaders.string(json, 'currency_symbol',
          fallback: JsonReaders.string(json, 'currencySymbol', fallback: r'$')),
    );
  }

  static List<ConfigCountryModel> listFromRawData(Object? data) {
    if (data is! List) {
      return const [];
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(ConfigCountryModel.fromJson)
        .where((country) =>
            country.isoCode.isNotEmpty &&
            country.name.isNotEmpty &&
            country.dialCode.isNotEmpty)
        .toList();
  }

  CountryCode toEntity() {
    return CountryCode(
      name: name,
      isoCode: isoCode,
      dialCode: dialCode,
      flagEmoji: flagEmoji,
      phoneHint: phoneHint,
      defaultLanguage: defaultLanguage,
      defaultCurrency: defaultCurrency,
      timezone: timezone,
      paymentGateway: paymentGateway,
      currencyDecimals: currencyDecimals,
      currencySymbol: currencySymbol,
    );
  }
}
