import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

class PartyDrinkCheckoutSheetHeaderWidget extends StatelessWidget {
  const PartyDrinkCheckoutSheetHeaderWidget({
    super.key,
    required this.onCloseTap,
  });

  final VoidCallback onCloseTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.horizontalPadding,
    );
    final closeSize = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.checkoutCloseSize,
    );

    return Column(
      children: [
        SizedBox(height: PartyDrinksDesignSpec.px(context, 10)),
        Center(
          child: Container(
            width: PartyDrinksDesignSpec.px(context, 36),
            height: PartyDrinksDesignSpec.px(context, 4),
            decoration: BoxDecoration(
              color: PartyDrinksDesignSpec.checkoutDivider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            PartyDrinksDesignSpec.px(context, 16),
            horizontalPadding,
            PartyDrinksDesignSpec.px(context, 20),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: PartyDrinksDesignSpec.px(context, 44),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.partyDrinkCheckoutSummaryTitle(strings),
                      style: TextStyle(
                        fontSize: PartyDrinksDesignSpec.px(context, 22),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.15,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: PartyDrinksDesignSpec.px(context, 6)),
                    Text(
                      AppStrings.partyDrinkCheckoutSummarySubtitle(strings),
                      style: TextStyle(
                        fontSize: PartyDrinksDesignSpec.px(context, 14),
                        fontWeight: FontWeight.w400,
                        color: PartyDrinksDesignSpec.checkoutSubtitleText,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -PartyDrinksDesignSpec.px(context, 4),
                right: 0,
                child: Material(
                  color: PartyDrinksDesignSpec.checkoutCloseButton,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: onCloseTap,
                    customBorder: const CircleBorder(),
                    child: SizedBox(
                      width: closeSize,
                      height: closeSize,
                      child: Icon(
                        Icons.close,
                        size: PartyDrinksDesignSpec.px(context, 18),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
