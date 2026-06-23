import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

class PartyDrinkPurchasesTopBarWidget extends StatelessWidget {
  const PartyDrinkPurchasesTopBarWidget({
    super.key,
    required this.onDrawerTap,
    this.onMoreTap,
  });

  final VoidCallback onDrawerTap;
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.horizontalPadding,
    );
    final iconSize = PartyDrinksDesignSpec.px(context, 22);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding - PartyDrinksDesignSpec.px(context, 8),
        PartyDrinksDesignSpec.px(context, 4),
        horizontalPadding - PartyDrinksDesignSpec.px(context, 8),
        PartyDrinksDesignSpec.px(context, 8),
      ),
      child: SizedBox(
        height: PartyDrinksDesignSpec.px(context, 44),
        child: Row(
          children: [
            IconButton(
              onPressed: onDrawerTap,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(
                minWidth: PartyDrinksDesignSpec.px(context, 40),
                minHeight: PartyDrinksDesignSpec.px(context, 40),
              ),
              icon: Icon(
                Icons.menu,
                color: PartyDrinksDesignSpec.gold,
                size: iconSize,
              ),
            ),
            const Expanded(
              child: Center(
                child: YouPassLogo(),
              ),
            ),
            IconButton(
              onPressed: onMoreTap,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(
                minWidth: PartyDrinksDesignSpec.px(context, 40),
                minHeight: PartyDrinksDesignSpec.px(context, 40),
              ),
              icon: Icon(
                Icons.more_vert,
                color: PartyDrinksDesignSpec.gold,
                size: iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
