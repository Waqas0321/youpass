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

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return SizedBox(
      height: layout.spacing(44),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, index) => SizedBox(width: layout.spacing(10)),
        itemBuilder: (context, index) {
          final category = categories[index];

          return CategoryChipWidget(
            label: category.label,
            icon: category.icon,
            isSelected: category.id == selectedCategoryId,
            onTap: () => onCategorySelected(category.id),
          );
        },
      ),
    );
  }
}
