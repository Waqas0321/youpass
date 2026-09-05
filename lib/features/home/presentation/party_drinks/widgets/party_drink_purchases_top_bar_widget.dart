import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

class PartyDrinkPurchasesTopBarWidget extends StatelessWidget {
  const PartyDrinkPurchasesTopBarWidget({
    super.key,
    required this.onBackTap,
  });

  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.horizontalPadding,
    );
    final iconSize = PartyDrinksDesignSpec.px(context, 20);
    final sideSlot = PartyDrinksDesignSpec.px(context, 40);

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
              onPressed: onBackTap,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(
                minWidth: sideSlot,
                minHeight: sideSlot,
              ),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: PartyDrinksDesignSpec.gold,
                size: iconSize,
              ),
            ),
            const Expanded(
              child: Center(
                child: YouPassLogo(),
              ),
            ),
            SizedBox(width: sideSlot, height: sideSlot),
          ],
        ),
      ),
    );
  }
}
