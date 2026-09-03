import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/category_chip_widget.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/presentation/widgets/home_country_picker_sheet.dart';

class HomeCategoryFiltersWidget extends StatelessWidget {
  const HomeCategoryFiltersWidget({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    this.onCountrySelected,
  });

  final List<EventCategoryEntity> categories;
  final String selectedCategoryId;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String>? onCountrySelected;

  static bool isCountryCategory(String categoryId) =>
      categoryId.startsWith('country:');

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final gap = layout.spacing(8);

    EventCategoryEntity? pinnedCountry;
    final scrollableCategories = <EventCategoryEntity>[];

    for (final category in categories) {
      if (isCountryCategory(category.id)) {
        pinnedCountry ??= category;
      } else {
        scrollableCategories.add(category);
      }
    }

    Widget buildChip(
      EventCategoryEntity category, {
      required VoidCallback onTap,
      bool showTrailingChevron = false,
    }) {
      return CategoryChipWidget(
        label: category.label,
        icon: category.icon,
        leadingEmoji: category.leadingEmoji,
        showLeadingIcon: category.showLeadingIcon,
        showTrailingChevron: showTrailingChevron,
        isSelected: category.id == selectedCategoryId,
        onTap: onTap,
      );
    }

    return SizedBox(
      height: layout.spacing(40),
      child: Row(
        children: [
          if (pinnedCountry != null) ...[
            Builder(
              builder: (chipContext) {
                final country = pinnedCountry!;
                return buildChip(
                  country,
                  showTrailingChevron: true,
                  onTap: () => _openCountryPicker(
                    chipContext,
                    country: country,
                  ),
                );
              },
            ),
            SizedBox(width: gap),
          ],
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: scrollableCategories.length,
              separatorBuilder: (_, index) => SizedBox(width: gap),
              itemBuilder: (context, index) {
                final category = scrollableCategories[index];
                return buildChip(
                  category,
                  onTap: () => onCategorySelected(category.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openCountryPicker(
    BuildContext chipContext, {
    required EventCategoryEntity country,
  }) async {
    final currentCode =
        country.countryCode ?? country.id.replaceFirst('country:', '');
    final selected = await HomeCountryPickerSheet.show(
      chipContext,
      selectedCountryCode: currentCode,
    );
    if (selected == null || !chipContext.mounted) {
      return;
    }
    onCountrySelected?.call(selected);
  }
}
