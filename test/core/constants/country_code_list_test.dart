import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/constants/latam_country_codes.dart';

void main() {
  test('countries is Latin America only with Chile first', () {
    expect(CountryCodeList.countries, isNotEmpty);
    expect(CountryCodeList.countries.first.isoCode, 'CL');
    expect(
      CountryCodeList.countries.every(
        (c) => kLatamCountryIsoCodes.contains(c.isoCode),
      ),
      isTrue,
    );
    expect(CountryCodeList.countries.any((c) => c.isoCode == 'US'), isFalse);
    expect(CountryCodeList.countries.any((c) => c.isoCode == 'PK'), isFalse);
    expect(CountryCodeList.countries.any((c) => c.isoCode == 'JP'), isFalse);
  });

  test('search filters by name dial code and iso within LATAM', () {
    final argentinaResults = CountryCodeList.search('argentina');
    expect(argentinaResults.any((c) => c.isoCode == 'AR'), isTrue);

    final dialResults = CountryCodeList.search('+56');
    expect(dialResults.any((c) => c.isoCode == 'CL'), isTrue);

    final germanyResults = CountryCodeList.search('germany');
    expect(germanyResults, isEmpty);
  });

  test('findByIsoCode returns default for unknown iso', () {
    expect(
      CountryCodeList.findByIsoCode('ZZ').isoCode,
      CountryCodeList.defaultCountry.isoCode,
    );
  });
}
