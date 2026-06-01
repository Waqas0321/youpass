import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class CountryCodePickerSheet extends StatelessWidget {
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
    return showModalBottomSheet<CountryCode>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return CountryCodePickerSheet(
          selectedCountry: selectedCountry,
          onCountrySelected: (country) {
            Navigator.of(context).pop(country);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final mediaQuery = MediaQuery.of(context);
    final maxHeight = mediaQuery.size.height * 0.55;

    return SafeArea(
      child: SizedBox(
        height: maxHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: layout.spacing(12)),
            Center(
              child: Container(
                width: layout.spacing(40),
                height: layout.spacing(4),
                decoration: BoxDecoration(
                  color: AppColors.lightGreyBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: layout.spacing(16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: layout.spacing(24)),
              child: AppText(
                context.l10n.selectCountryTitle,
                variant: AppTextVariant.title,
              ),
            ),
            SizedBox(height: layout.spacing(16)),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: layout.spacing(16)),
                itemCount: CountryCodeList.countries.length,
                separatorBuilder: (_, index) => Divider(
                  height: 1,
                  color: Colors.grey.shade200,
                ),
                itemBuilder: (context, index) {
                  final country = CountryCodeList.countries[index];
                  final isSelected = country.isoCode == selectedCountry.isoCode;

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
                          : null,
                    ),
                    selected: isSelected,
                    selectedTileColor:
                        AppColors.primaryMustard.withValues(alpha: 0.12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(layout.radius(10)),
                    ),
                    onTap: () => onCountrySelected(country),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
