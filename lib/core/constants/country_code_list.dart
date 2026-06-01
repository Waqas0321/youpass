import 'package:youpass/core/models/country_code.dart';

class CountryCodeList {
  static const CountryCode defaultCountry = CountryCode(
    name: 'Chile',
    isoCode: 'CL',
    dialCode: '56',
    flagEmoji: '🇨🇱',
    phoneHint: '9 1234 5678',
  );

  static const List<CountryCode> countries = [
    defaultCountry,
    CountryCode(
      name: 'Argentina',
      isoCode: 'AR',
      dialCode: '54',
      flagEmoji: '🇦🇷',
      phoneHint: '9 11 1234 5678',
    ),
    CountryCode(
      name: 'Perú',
      isoCode: 'PE',
      dialCode: '51',
      flagEmoji: '🇵🇪',
      phoneHint: '912 345 678',
    ),
    CountryCode(
      name: 'Colombia',
      isoCode: 'CO',
      dialCode: '57',
      flagEmoji: '🇨🇴',
      phoneHint: '300 123 4567',
    ),
    CountryCode(
      name: 'México',
      isoCode: 'MX',
      dialCode: '52',
      flagEmoji: '🇲🇽',
      phoneHint: '55 1234 5678',
    ),
    CountryCode(
      name: 'Brasil',
      isoCode: 'BR',
      dialCode: '55',
      flagEmoji: '🇧🇷',
      phoneHint: '11 91234 5678',
    ),
    CountryCode(
      name: 'Ecuador',
      isoCode: 'EC',
      dialCode: '593',
      flagEmoji: '🇪🇨',
      phoneHint: '99 123 4567',
    ),
    CountryCode(
      name: 'Bolivia',
      isoCode: 'BO',
      dialCode: '591',
      flagEmoji: '🇧🇴',
      phoneHint: '71234567',
    ),
    CountryCode(
      name: 'Uruguay',
      isoCode: 'UY',
      dialCode: '598',
      flagEmoji: '🇺🇾',
      phoneHint: '94 123 456',
    ),
    CountryCode(
      name: 'Paraguay',
      isoCode: 'PY',
      dialCode: '595',
      flagEmoji: '🇵🇾',
      phoneHint: '981 123456',
    ),
    CountryCode(
      name: 'España',
      isoCode: 'ES',
      dialCode: '34',
      flagEmoji: '🇪🇸',
      phoneHint: '612 34 56 78',
    ),
    CountryCode(
      name: 'Estados Unidos',
      isoCode: 'US',
      dialCode: '1',
      flagEmoji: '🇺🇸',
      phoneHint: '201 555 0123',
    ),
  ];

  static CountryCode findByIsoCode(String isoCode) {
    return countries.firstWhere(
      (country) => country.isoCode == isoCode,
      orElse: () => defaultCountry,
    );
  }
}
