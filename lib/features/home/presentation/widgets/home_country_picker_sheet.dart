import 'package:flutter/material.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/constants/country_codes_data.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/features/auth/presentation/widgets/country_code_picker_sheet.dart';

/// Home location tab country picker — shows the full world country list.
class HomeCountryPickerSheet {
  HomeCountryPickerSheet._();

  static List<CountryCode> get _allCountriesSorted {
    final sorted = List<CountryCode>.from(CountryCodesData.all);
    sorted.sort((a, b) => a.name.compareTo(b.name));
    return sorted;
  }

  static CountryCode _findCountry(String isoCode) {
    final normalized = isoCode.toUpperCase();
    return _allCountriesSorted.firstWhere(
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
      countries: _allCountriesSorted,
      showIsoCodeSubtitle: true,
      autofocusSearch: false,
      scrollToSelectedOnOpen: false,
    );
    return result?.isoCode;
  }
}
