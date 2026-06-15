import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/category_chip_widget.dart';
import 'package:youpass/features/favorites/domain/entities/favorites_filter.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class FavoritesFilterPillsWidget extends StatelessWidget {
  const FavoritesFilterPillsWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final FavoritesFilter selectedFilter;
  final ValueChanged<FavoritesFilter> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final filters = <(FavoritesFilter, String, IconData)>[
      (FavoritesFilter.all, AppStrings.favoritesFilterAll(strings), Icons.apps),
      (
        FavoritesFilter.upcoming,
        AppStrings.favoritesFilterUpcoming(strings),
        Icons.schedule,
      ),
      (
        FavoritesFilter.parties,
        AppStrings.favoritesFilterParties(strings),
        Icons.celebration_outlined,
      ),
      (FavoritesFilter.vip, AppStrings.favoritesFilterVip(strings), Icons.star_outline),
    ];

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
            itemCount: filters.length,
            separatorBuilder: (_, index) =>
                SizedBox(width: FavoritesDesignSpec.px(context, 8)),
            itemBuilder: (context, index) {
              final entry = filters[index];
              return CategoryChipWidget(
                label: entry.$2,
                icon: entry.$3,
                isSelected: selectedFilter == entry.$1,
                onTap: () => onFilterSelected(entry.$1),
              );
            },
          ),
        ),
      ],
    );
  }
}
