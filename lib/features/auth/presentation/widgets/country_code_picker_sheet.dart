import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/l10n/country_code_display_helper.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
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
    this.countries,
    this.showIsoCodeSubtitle = false,
    this.autofocusSearch = true,
    this.scrollToSelectedOnOpen = true,
  });

  final CountryCode selectedCountry;
  final ValueChanged<CountryCode> onCountrySelected;
  final List<CountryCode>? countries;
  final bool showIsoCodeSubtitle;
  final bool autofocusSearch;
  final bool scrollToSelectedOnOpen;

  static Future<CountryCode?> show({
    required BuildContext context,
    required CountryCode selectedCountry,
    List<CountryCode>? countries,
    bool showIsoCodeSubtitle = false,
    bool autofocusSearch = true,
    bool scrollToSelectedOnOpen = true,
  }) {
    return AuthBottomSheetShell.show<CountryCode>(
      context: context,
      title: AppStrings.selectCountryTitle(context.l10n),
      maxHeightFactor: AppConstants.countryPickerSheetHeightFactor,
      child: CountryCodePickerSheet(
        selectedCountry: selectedCountry,
        countries: countries,
        showIsoCodeSubtitle: showIsoCodeSubtitle,
        autofocusSearch: autofocusSearch,
        scrollToSelectedOnOpen: scrollToSelectedOnOpen,
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
  final ScrollController scrollController = ScrollController();
  late List<CountryCode> filteredCountries;

  List<CountryCode> get availableCountries =>
      widget.countries ?? CountryCodeList.countries;

  @override
  void initState() {
    super.initState();
    filteredCountries = availableCountries;
    searchController.addListener(updateFilteredCountries);
    if (widget.scrollToSelectedOnOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToSelectedCountry());
    }
  }

  @override
  void dispose() {
    searchController.removeListener(updateFilteredCountries);
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void scrollToSelectedCountry() {
    final index = filteredCountries.indexWhere(
      (country) => country.isoCode == widget.selectedCountry.isoCode,
    );
    if (index <= 0 || !scrollController.hasClients) {
      return;
    }

    const estimatedTileHeight = 72.0;
    final targetOffset = (index * estimatedTileHeight).clamp(
      0.0,
      scrollController.position.maxScrollExtent,
    );
    scrollController.jumpTo(targetOffset);
  }

  void updateFilteredCountries() {
    setState(() {
      filteredCountries = searchCountries(
        availableCountries,
        searchController.text,
      );
    });
    if (widget.scrollToSelectedOnOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToSelectedCountry());
    }
  }

  static List<CountryCode> searchCountries(
    List<CountryCode> source,
    String query,
  ) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return source;
    }

    return source.where((country) {
      return country.name.toLowerCase().contains(normalized) ||
          country.isoCode.toLowerCase().contains(normalized) ||
          country.dialCode.contains(normalized) ||
          country.displayDialCode.contains(normalized);
    }).toList();
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
            autofocus: widget.autofocusSearch,
          ),
        ),
        Expanded(
          child: buildCountryList(layout),
        ),
      ],
    );
  }

  Widget buildCountryList(ResponsiveLayout layout) {
    final scheme = Theme.of(context).colorScheme;
    final theme = YouPassThemeExtension.of(context);

    if (filteredCountries.isEmpty) {
      return Center(
        child: AppText(
          AppStrings.searchCountryEmpty(context.l10n),
          variant: AppTextVariant.body,
          color: scheme.onSurfaceVariant,
        ),
      );
    }

    return ListView.separated(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: layout.spacing(16)),
      itemCount: filteredCountries.length,
      separatorBuilder: (_, index) => Divider(
        height: 1,
        color: theme.cardBorder,
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
            CountryCodeDisplayHelper.localizedName(country, context.l10n),
            variant: AppTextVariant.listTitle,
          ),
          subtitle: widget.showIsoCodeSubtitle
              ? AppText(
                  country.isoCode,
                  variant: AppTextVariant.body,
                  color: scheme.onSurfaceVariant,
                )
              : null,
          trailing: widget.showIsoCodeSubtitle
              ? null
              : AppText(
                  country.displayDialCode,
                  variant: AppTextVariant.listTrailing,
                  color: isSelected
                      ? AppColors.primaryMustard
                      : scheme.onSurfaceVariant,
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
