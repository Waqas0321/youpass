import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

class PartyDrinkPurchasesHeaderWidget extends StatelessWidget {
  const PartyDrinkPurchasesHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.horizontalPadding,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        PartyDrinksDesignSpec.px(context, 4),
        horizontalPadding,
        PartyDrinksDesignSpec.px(context, 16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: PartyDrinksDesignSpec.px(context, 26),
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.6,
              height: 1.1,
            ),
          ),
          SizedBox(height: PartyDrinksDesignSpec.px(context, 8)),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: PartyDrinksDesignSpec.px(context, 14),
              color: Colors.white.withValues(alpha: 0.88),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
