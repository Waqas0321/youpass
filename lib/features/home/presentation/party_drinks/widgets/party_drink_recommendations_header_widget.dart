import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

class PartyDrinkRecommendationsHeaderWidget extends StatelessWidget {
  const PartyDrinkRecommendationsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        PartyDrinksDesignSpec.px(context, PartyDrinksDesignSpec.horizontalPadding),
        PartyDrinksDesignSpec.px(context, 20),
        PartyDrinksDesignSpec.px(context, PartyDrinksDesignSpec.horizontalPadding),
        PartyDrinksDesignSpec.px(context, 12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.bolt,
            color: PartyDrinksDesignSpec.gold,
            size: PartyDrinksDesignSpec.px(context, 22),
          ),
          SizedBox(width: PartyDrinksDesignSpec.px(context, 8)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.partyDrinkQuickRecommendations(strings),
                  style: TextStyle(
                    fontSize: PartyDrinksDesignSpec.px(context, 18),
                    fontWeight: FontWeight.w800,
                    color: PartyDrinksDesignSpec.gold,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: PartyDrinksDesignSpec.px(context, 4)),
                Text(
                  AppStrings.partyDrinkQuickRecommendationsSubtitle(strings),
                  style: TextStyle(
                    fontSize: PartyDrinksDesignSpec.px(context, 13),
                    color: PartyDrinksDesignSpec.subtitleText,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
