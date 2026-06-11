import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/network/models/config_country_model.dart';
import 'package:youpass/core/security/security_config_model.dart';
import 'package:youpass/core/utils/json_readers.dart';

class AppConfigModel {
  const AppConfigModel({
    required this.defaultCountryCode,
    required this.supportedLanguages,
    required this.countries,
    this.security,
  });

  final String defaultCountryCode;
  final List<String> supportedLanguages;
  final List<CountryCode> countries;
  final SecurityConfigModel? security;

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    final countriesRaw = json['countries'];
    final countries = countriesRaw is List
        ? ConfigCountryModel.listFromRawData(countriesRaw)
            .map((country) => country.toEntity())
            .toList()
        : <CountryCode>[];

    final languagesRaw = json['supported_languages'] ?? json['supportedLanguages'];
    final languages = languagesRaw is List
        ? languagesRaw.map((item) => item.toString()).toList()
        : const ['es', 'en'];

    final securityRaw = json['security'];
    final security = securityRaw is Map<String, dynamic>
        ? SecurityConfigModel.fromJson(securityRaw)
        : null;

    return AppConfigModel(
      defaultCountryCode: JsonReaders.string(json, 'default_country_code',
          fallback: JsonReaders.string(json, 'defaultCountryCode', fallback: 'CL')),
      supportedLanguages: languages,
      countries: countries,
      security: security,
    );
  }
}
