import 'package:youpass/core/constants/country_code_registry.dart';
import 'package:youpass/core/models/country_code.dart';

class CountryFormatHelper {
  CountryFormatHelper._();

  static CountryCode countryFor({
    String? countryIsoCode,
    String? currencyCode,
  }) {
    final normalizedCurrency = currencyCode?.trim().toUpperCase();
    final byCurrency = normalizedCurrency == null || normalizedCurrency.isEmpty
        ? null
        : CountryCodeRegistry.findByCurrency(normalizedCurrency);

    if (countryIsoCode != null && countryIsoCode.trim().isNotEmpty) {
      final byIso = CountryCodeRegistry.findByIsoCode(countryIsoCode);
      // Prefer currency when ISO country conflicts (e.g. default CL + PKR tickets).
      if (byCurrency != null &&
          byIso.defaultCurrency.toUpperCase() != normalizedCurrency) {
        return byCurrency;
      }
      return byIso;
    }

    if (byCurrency != null) {
      return byCurrency;
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
