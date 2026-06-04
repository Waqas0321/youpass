import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/category_chip_widget.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class EventBrowseCategoryFiltersWidget extends StatelessWidget {
  const EventBrowseCategoryFiltersWidget({
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
    final strings = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.favoritesFiltersLabel(strings),
          style: TextStyle(
            fontSize: FavoritesDesignSpec.px(context, 11),
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: FavoritesDesignSpec.px(context, 8)),
        SizedBox(
          height: FavoritesDesignSpec.px(context, 40),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, index) =>
                SizedBox(width: FavoritesDesignSpec.px(context, 8)),
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
        ),
      ],
    );
  }
}
