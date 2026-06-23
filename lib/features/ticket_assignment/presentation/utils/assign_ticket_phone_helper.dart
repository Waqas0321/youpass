import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/utils/phone_formatter.dart';

class AssignTicketPhoneHelper {
  AssignTicketPhoneHelper._();

  static CountryCode matchCountryFromDigits(
    String digits, {
    CountryCode? preferred,
  }) {
    final sorted = List<CountryCode>.from(CountryCodeList.countries)
      ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));

    for (final country in sorted) {
      if (digits.startsWith(country.dialCode) &&
          digits.length > country.dialCode.length) {
        return country;
      }
    }

    return preferred ?? CountryCodeList.defaultCountry;
  }

  static String nationalDigitsForCountry(String digits, CountryCode country) {
    if (digits.startsWith(country.dialCode)) {
      return digits.substring(country.dialCode.length);
    }
    return digits;
  }

  static ({CountryCode country, String nationalDigits}) resolvePhone({
    required String rawPhone,
    String? isoCode,
    CountryCode? fallbackCountry,
  }) {
    final fallback = fallbackCountry ?? CountryCodeList.defaultCountry;
    final digits = PhoneFormatter.digitsOnly(rawPhone);
    if (digits.isEmpty) {
      return (country: fallback, nationalDigits: '');
    }

    if (isoCode != null && isoCode.trim().isNotEmpty) {
      final country = CountryCodeList.findByIsoCode(isoCode);
      return (
        country: country,
        nationalDigits: nationalDigitsForCountry(digits, country),
      );
    }

    final matched = matchCountryFromDigits(digits, preferred: fallback);
    return (
      country: matched,
      nationalDigits: nationalDigitsForCountry(digits, matched),
    );
  }
}
