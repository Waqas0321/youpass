import 'package:youpass/staff_app/core/constants/country_code_registry.dart';
import 'package:youpass/staff_app/core/models/country_code.dart';

class CountryCodeList {
  static CountryCode get defaultCountry => CountryCodeRegistry.defaultCountry;

  static List<CountryCode> get countries => CountryCodeRegistry.countries;

  static Future<void> initialize() {
    return CountryCodeRegistry.loadFromApi(null);
  }

  static CountryCode findByIsoCode(String isoCode) {
    return CountryCodeRegistry.findByIsoCode(isoCode);
  }

  static List<CountryCode> search(String query) {
    return CountryCodeRegistry.search(query);
  }
}
