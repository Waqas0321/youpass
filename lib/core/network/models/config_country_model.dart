import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/utils/json_readers.dart';

class ConfigCountryModel {
  const ConfigCountryModel({
    required this.isoCode,
    required this.name,
    required this.dialCode,
    required this.flagEmoji,
    required this.phoneHint,
  });

  final String isoCode;
  final String name;
  final String dialCode;
  final String flagEmoji;
  final String phoneHint;

  factory ConfigCountryModel.fromJson(Map<String, dynamic> json) {
    final dialCodeRaw = JsonReaders.string(json, 'dialCode');
    final dialCode = dialCodeRaw.replaceAll(RegExp(r'\D'), '');

    return ConfigCountryModel(
      isoCode: JsonReaders.string(json, 'code'),
      name: JsonReaders.string(json, 'name'),
      dialCode: dialCode,
      flagEmoji: JsonReaders.string(json, 'flagEmoji'),
      phoneHint: _phoneHintForIso(JsonReaders.string(json, 'code')),
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
    );
  }

  static String _phoneHintForIso(String isoCode) {
    switch (isoCode) {
      case 'CL':
        return '9 1234 5678';
      case 'PK':
        return '321 6548001';
      default:
        return '';
    }
  }
}
