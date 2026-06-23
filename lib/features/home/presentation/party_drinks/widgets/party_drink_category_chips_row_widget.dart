import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_menu_category.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_category_filter.dart';

class PartyDrinkCategoryChipsRowWidget extends StatelessWidget {
  const PartyDrinkCategoryChipsRowWidget({
    super.key,
    required this.categories,
    required this.selectedCategories,
    required this.onCategoryToggled,
  });

  final List<PartyDrinkMenuCategory> categories;
  final Set<String> selectedCategories;
  final ValueChanged<String> onCategoryToggled;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final chipHeight = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.categoryChipHeight,
    );
    final chips = [
      (
        PartyDrinkMenuCategory.allSlug,
        AppStrings.partyDrinkCategoryAll(strings),
        Icons.grid_view_rounded,
        null,
      ),
      ...categories.map(
        (category) => (
          category.slug,
          category.name,
          Icons.local_bar_outlined,
          category.icon,
        ),
      ),
    ];

    return SizedBox(
      height: chipHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(
          horizontal: PartyDrinksDesignSpec.px(
            context,
            PartyDrinksDesignSpec.horizontalPadding,
          ),
        ),
        itemCount: chips.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: PartyDrinksDesignSpec.px(context, 8)),
        itemBuilder: (context, index) {
          final (slug, label, icon, emoji) = chips[index];
          final isSelected = PartyDrinkCategoryFilter.isSelected(
            selectedCategories,
            slug,
          );

          return _PartyDrinkCategoryChip(
            height: chipHeight,
            label: label,
            icon: icon,
            emoji: emoji,
            isSelected: isSelected,
            onTap: () => onCategoryToggled(slug),
          );
        },
      ),
    );
  }
}

class _PartyDrinkCategoryChip extends StatelessWidget {
  const _PartyDrinkCategoryChip({
    required this.height,
    required this.label,
    required this.icon,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  final double height;
  final String label;
  final IconData icon;
  final String? emoji;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = PartyDrinksDesignSpec.borderRadius;
    final borderColor = isSelected
        ? PartyDrinksDesignSpec.gold
        : PartyDrinksDesignSpec.gold.withValues(alpha: 0.55);
    final textColor =
        isSelected ? Colors.black : Theme.of(context).colorScheme.onSurface;
    final iconColor = isSelected ? Colors.black : PartyDrinksDesignSpec.gold;

    return SizedBox(
      height: height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Ink(
            decoration: BoxDecoration(
              color: isSelected ? PartyDrinksDesignSpec.gold : Colors.transparent,
              borderRadius: radius,
              border: Border.all(color: borderColor, width: 1.2),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: PartyDrinksDesignSpec.px(context, 14),
            ),
            child: SizedBox(
              height: height,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (emoji != null && emoji!.isNotEmpty)
                      Text(
                        emoji!,
                        style: TextStyle(
                          fontSize: PartyDrinksDesignSpec.px(context, 14),
                        ),
                      )
                    else
                      Icon(
                        icon,
                        size: PartyDrinksDesignSpec.px(context, 16),
                        color: iconColor,
                      ),
                    SizedBox(width: PartyDrinksDesignSpec.px(context, 6)),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: PartyDrinksDesignSpec.px(context, 13),
                        fontWeight: FontWeight.w600,
                        color: textColor,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
