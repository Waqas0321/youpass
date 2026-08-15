import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

class PartyDrinkVolumeBadgeWidget extends StatelessWidget {
  const PartyDrinkVolumeBadgeWidget({
    super.key,
    required this.volumeMl,
    this.filled = false,
  });

  final int volumeMl;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    if (volumeMl <= 0) {
      return const SizedBox.shrink();
    }

    final strings = context.l10n;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: PartyDrinksDesignSpec.volumeBadgeBorderRadius,
        color: filled ? PartyDrinksDesignSpec.checkoutSurface : null,
        border: Border.all(color: PartyDrinksDesignSpec.volumeBadgeBorder),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: PartyDrinksDesignSpec.px(context, 7),
          vertical: PartyDrinksDesignSpec.px(context, 2),
        ),
        child: Text(
          AppStrings.partyDrinkVolumeMl(strings, volumeMl),
          style: TextStyle(
            fontSize: PartyDrinksDesignSpec.px(context, 11),
            fontWeight: FontWeight.w500,
            color: PartyDrinksDesignSpec.volumeBadgeText,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}
