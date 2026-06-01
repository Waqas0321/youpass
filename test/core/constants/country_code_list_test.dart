import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/constants/country_code_list.dart';

void main() {
  test('countries includes all regions with Chile first', () {
    expect(CountryCodeList.countries.length, greaterThan(200));
    expect(CountryCodeList.countries.first.isoCode, 'CL');
    expect(CountryCodeList.countries.any((c) => c.isoCode == 'US'), isTrue);
    expect(CountryCodeList.countries.any((c) => c.isoCode == 'JP'), isTrue);
  });

  test('search filters by name dial code and iso', () {
    final argentinaResults = CountryCodeList.search('argentina');
    expect(argentinaResults.any((c) => c.isoCode == 'AR'), isTrue);

    final dialResults = CountryCodeList.search('+56');
    expect(dialResults.any((c) => c.isoCode == 'CL'), isTrue);

    final isoResults = CountryCodeList.search('de');
    expect(isoResults.any((c) => c.isoCode == 'DE'), isTrue);
  });

  test('findByIsoCode returns default for unknown iso', () {
    expect(
      CountryCodeList.findByIsoCode('ZZ').isoCode,
      CountryCodeList.defaultCountry.isoCode,
    );
  });
}
