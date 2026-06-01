import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_field.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/auth_bottom_sheet_shell.dart';

class CountryCodePickerSheet extends StatefulWidget {
  const CountryCodePickerSheet({
    super.key,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  final CountryCode selectedCountry;
  final ValueChanged<CountryCode> onCountrySelected;

  static Future<CountryCode?> show({
    required BuildContext context,
    required CountryCode selectedCountry,
  }) {
    return AuthBottomSheetShell.show<CountryCode>(
      context: context,
      title: AppStrings.selectCountryTitle(context.l10n),
      maxHeightFactor: AppConstants.countryPickerSheetHeightFactor,
      child: CountryCodePickerSheet(
        selectedCountry: selectedCountry,
        onCountrySelected: (country) {
          Navigator.of(context).pop(country);
        },
      ),
    );
  }

  @override
  State<CountryCodePickerSheet> createState() => CountryCodePickerSheetState();
}

class CountryCodePickerSheetState extends State<CountryCodePickerSheet> {
  final TextEditingController searchController = TextEditingController();
  List<CountryCode> filteredCountries = CountryCodeList.countries;

  @override
  void initState() {
    super.initState();
    searchController.addListener(updateFilteredCountries);
  }

  @override
  void dispose() {
    searchController.removeListener(updateFilteredCountries);
    searchController.dispose();
    super.dispose();
  }

  void updateFilteredCountries() {
    setState(() {
      filteredCountries = CountryCodeList.search(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            layout.spacing(16),
            0,
            layout.spacing(16),
            layout.spacing(12),
          ),
          child: AppTextField(
            controller: searchController,
            hintText: AppStrings.searchCountryHint(l10n),
            autofocus: true,
          ),
        ),
        Expanded(
          child: buildCountryList(layout),
        ),
      ],
    );
  }

  Widget buildCountryList(ResponsiveLayout layout) {
    if (filteredCountries.isEmpty) {
      return Center(
        child: AppText(
          AppStrings.searchCountryEmpty(context.l10n),
          variant: AppTextVariant.body,
          color: AppColors.secondaryGrey,
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: layout.spacing(16)),
      itemCount: filteredCountries.length,
      separatorBuilder: (_, index) => const Divider(
        height: 1,
        color: AppColors.homeDividerGrey,
      ),
      itemBuilder: (context, index) {
        final country = filteredCountries[index];
        final isSelected = country.isoCode == widget.selectedCountry.isoCode;

        return ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: layout.spacing(8),
          ),
          leading: AppText(
            country.flagEmoji,
            variant: AppTextVariant.emojiLarge,
          ),
          title: AppText(
            country.name,
            variant: AppTextVariant.listTitle,
          ),
          trailing: AppText(
            country.displayDialCode,
            variant: AppTextVariant.listTrailing,
            color: isSelected
                ? AppColors.primaryMustard
                : AppColors.secondaryGrey,
          ),
          selected: isSelected,
          selectedTileColor: AppColors.primaryMustard.withValues(alpha: 0.12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(layout.radius(10)),
          ),
          onTap: () => widget.onCountrySelected(country),
        );
      },
    );
  }
}
