import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

enum PartyDrinkPurchasesTab { pending, used }

class PartyDrinkPurchasesTabsWidget extends StatelessWidget {
  const PartyDrinkPurchasesTabsWidget({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  final PartyDrinkPurchasesTab selectedTab;
  final ValueChanged<PartyDrinkPurchasesTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.horizontalPadding,
    );
    final radius = PartyDrinksDesignSpec.px(context, 12);
    final tabHeight = PartyDrinksDesignSpec.px(context, 48);
    final dividerWidth = PartyDrinksDesignSpec.px(context, 1);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        height: tabHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: PartyDrinksDesignSpec.gold, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Expanded(
              child: _TabSegment(
                label: AppStrings.partyDrinkPurchasesTabPending(strings),
                isActive: selectedTab == PartyDrinkPurchasesTab.pending,
                onTap: () => onTabSelected(PartyDrinkPurchasesTab.pending),
              ),
            ),
            Container(
              width: dividerWidth,
              color: PartyDrinksDesignSpec.gold,
            ),
            Expanded(
              child: _TabSegment(
                label: AppStrings.partyDrinkPurchasesTabUsed(strings),
                isActive: selectedTab == PartyDrinkPurchasesTab.used,
                onTap: () => onTabSelected(PartyDrinkPurchasesTab.used),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabSegment extends StatelessWidget {
  const _TabSegment({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: PartyDrinksDesignSpec.px(context, 15),
      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
      color: isActive ? PartyDrinksDesignSpec.gold : Colors.white,
    );
    final indicatorHeight = PartyDrinksDesignSpec.px(context, 3);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              height: isActive ? indicatorHeight : 0,
              width: double.infinity,
              color: PartyDrinksDesignSpec.gold,
            ),
          ],
        ),
      ),
    );
  }
}
