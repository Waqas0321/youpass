import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/category_chip_widget.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class HomeCategoryFiltersWidget extends StatelessWidget {
  const HomeCategoryFiltersWidget({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  final List<EventCategoryEntity> categories;
  final String selectedCategoryId;
  final ValueChanged<String> onCategorySelected;

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

    Widget buildChip(EventCategoryEntity category) {
      return CategoryChipWidget(
        label: category.label,
        icon: category.icon,
        leadingEmoji: category.leadingEmoji,
        showLeadingIcon: category.showLeadingIcon,
        isSelected: category.id == selectedCategoryId,
        onTap: () => onCategorySelected(category.id),
      );
    }

    return SizedBox(
      height: layout.spacing(40),
      child: Row(
        children: [
          if (pinnedCountry != null) ...[
            buildChip(pinnedCountry),
            SizedBox(width: gap),
          ],
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: scrollableCategories.length,
              separatorBuilder: (_, index) => SizedBox(width: gap),
              itemBuilder: (context, index) {
                return buildChip(scrollableCategories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
