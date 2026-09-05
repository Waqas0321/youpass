import 'package:youpass/core/constants/latam_country_codes.dart';
import 'package:youpass/staff_app/core/constants/country_codes_data.dart';
import 'package:youpass/staff_app/core/models/country_code.dart';

/// Static country list (same defaults as YouPass consumer app).
class CountryCodeRegistry {
  CountryCodeRegistry._();

  static const String _defaultCountryCode = 'CL';

  static List<CountryCode> get countries => fallbackCountries;

  static String get defaultCountryCode => _defaultCountryCode;

  static CountryCode get defaultCountry => findByIsoCode(_defaultCountryCode);

  static Future<void> loadFromApi(Object? _) async {}

  static CountryCode findByIsoCode(String isoCode) {
    return countries.firstWhere(
      (country) => country.isoCode == isoCode.toUpperCase(),
      orElse: () => defaultCountry,
    );
  }

  static List<CountryCode> search(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return countries;
    }

    return countries.where((country) {
      return country.name.toLowerCase().contains(normalized) ||
          country.isoCode.toLowerCase().contains(normalized) ||
          country.dialCode.contains(normalized) ||
          country.displayDialCode.contains(normalized);
    }).toList();
  }

  static const CountryCode _defaultCountry = CountryCode(
    name: 'Chile',
    isoCode: 'CL',
    dialCode: '56',
    flagEmoji: '🇨🇱',
    phoneHint: '9 1234 5678',
    defaultLanguage: 'es',
    defaultCurrency: 'CLP',
    timezone: 'America/Santiago',
    paymentGateway: 'kushki',
    currencyDecimals: 0,
    currencySymbol: r'$',
  );

  static List<CountryCode> _sortWithDefaultFirst(
    List<CountryCode> list,
    String preferredIso,
  ) {
    final sorted = List<CountryCode>.from(list);
    sorted.sort((a, b) => a.name.compareTo(b.name));

    final preferredIndex =
        sorted.indexWhere((country) => country.isoCode == preferredIso);
    if (preferredIndex > 0) {
      final preferred = sorted.removeAt(preferredIndex);
      sorted.insert(0, preferred);
    }

    return sorted;
  }

  static List<CountryCode> get fallbackCountries {
    final latam = CountryCodesData.all
        .where(
          (country) =>
              kLatamCountryIsoCodes.contains(country.isoCode.toUpperCase()),
        )
        .toList();
    return _sortWithDefaultFirst(latam, _defaultCountry.isoCode);
  }
}
