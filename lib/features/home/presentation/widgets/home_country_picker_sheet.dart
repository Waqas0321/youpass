import 'package:flutter/material.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/constants/country_code_registry.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/features/auth/presentation/widgets/country_code_picker_sheet.dart';

/// Home country picker — only countries supported by the backend (/config).
class HomeCountryPickerSheet {
  HomeCountryPickerSheet._();

  static List<CountryCode> get _supportedCountriesSorted {
    final sorted = List<CountryCode>.from(CountryCodeRegistry.countries);
    sorted.sort((a, b) => a.name.compareTo(b.name));
    return sorted;
  }

  static CountryCode _findCountry(String isoCode) {
    final normalized = isoCode.toUpperCase();
    return _supportedCountriesSorted.firstWhere(
      (country) => country.isoCode == normalized,
      orElse: () => CountryCodeList.findByIsoCode(normalized),
    );
  }

  static Future<String?> show(
    BuildContext context, {
    required String selectedCountryCode,
  }) async {
    final selected = _findCountry(selectedCountryCode);
    final result = await CountryCodePickerSheet.show(
      context: context,
      selectedCountry: selected,
      countries: _supportedCountriesSorted,
      showIsoCodeSubtitle: true,
      autofocusSearch: false,
      scrollToSelectedOnOpen: false,
    );
    return result?.isoCode;
  }
}
