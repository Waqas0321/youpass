import 'package:youpass/core/constants/country_code_registry.dart';
import 'package:youpass/core/models/country_code.dart';

class CountryFormatHelper {
  CountryFormatHelper._();

  static CountryCode countryFor({
    String? countryIsoCode,
    String? currencyCode,
  }) {
    if (countryIsoCode != null && countryIsoCode.trim().isNotEmpty) {
      return CountryCodeRegistry.findByIsoCode(countryIsoCode);
    }

    if (currencyCode != null && currencyCode.trim().isNotEmpty) {
      return CountryCodeRegistry.findByCurrency(currencyCode) ??
          CountryCodeRegistry.defaultCountry;
    }

    return CountryCodeRegistry.defaultCountry;
  }

  static String numberLocaleForCountry(CountryCode country) {
    switch (country.defaultLanguage) {
      case 'pt':
        return 'pt_${country.isoCode}';
      case 'en':
        return 'en_US';
      default:
        return 'es_${country.isoCode}';
    }
  }
}
