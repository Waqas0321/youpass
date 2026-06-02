import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/favorites/domain/entities/producer_event_category.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_filter_chip_widget.dart';

class ProducerEventCategoryChipsWidget extends StatelessWidget {
  const ProducerEventCategoryChipsWidget({
    super.key,
    this.selectedCategory,
    this.onCategorySelected,
  });

  final ProducerEventCategory? selectedCategory;
  final ValueChanged<ProducerEventCategory?>? onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FavoritesFilterChipWidget(
            label: AppStrings.producerEventCategoryParties(strings),
            isSelected: selectedCategory == ProducerEventCategory.parties,
            onTap: () => onCategorySelected?.call(
              selectedCategory == ProducerEventCategory.parties
                  ? null
                  : ProducerEventCategory.parties,
            ),
          ),
          SizedBox(width: FavoritesDesignSpec.px(context, 8)),
          FavoritesFilterChipWidget(
            label: AppStrings.producerEventCategoryFestivals(strings),
            isSelected: selectedCategory == ProducerEventCategory.festivals,
            onTap: () => onCategorySelected?.call(
              selectedCategory == ProducerEventCategory.festivals
                  ? null
                  : ProducerEventCategory.festivals,
            ),
          ),
          SizedBox(width: FavoritesDesignSpec.px(context, 8)),
          FavoritesFilterChipWidget(
            label: AppStrings.producerEventCategoryConcerts(strings),
            isSelected: selectedCategory == ProducerEventCategory.concerts,
            onTap: () => onCategorySelected?.call(
              selectedCategory == ProducerEventCategory.concerts
                  ? null
                  : ProducerEventCategory.concerts,
            ),
          ),
        ],
      ),
    );
  }
}
