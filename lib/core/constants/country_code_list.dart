import 'package:youpass/core/constants/country_code_registry.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/network/config_api_service.dart';

class CountryCodeList {
  static const CountryCode defaultCountry = CountryCode(
    name: 'Chile',
    isoCode: 'CL',
    dialCode: '56',
    flagEmoji: '🇨🇱',
    phoneHint: '9 1234 5678',
  );

  static List<CountryCode> get countries => CountryCodeRegistry.countries;

  static Future<void> initialize(ConfigApiService configApiService) {
    return CountryCodeRegistry.loadFromApi(configApiService);
  }

  static CountryCode findByIsoCode(String isoCode) {
    return CountryCodeRegistry.findByIsoCode(isoCode);
  }

  static List<CountryCode> search(String query) {
    return CountryCodeRegistry.search(query);
  }
}
