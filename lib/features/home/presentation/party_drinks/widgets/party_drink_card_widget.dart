import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_item.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_price_formatter.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_product_image_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_quantity_stepper_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_volume_badge_widget.dart';

class PartyDrinkCardWidget extends StatelessWidget {
  const PartyDrinkCardWidget({
    super.key,
    required this.drink,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final PartyDrinkItem drink;
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final gap = PartyDrinksDesignSpec.px(context, 6);
    final radius = PartyDrinksDesignSpec.borderRadius;
    const borderSide = BorderSide(
      color: PartyDrinksDesignSpec.cardBorder,
      width: 1,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = constraints.maxWidth * 0.78;
        final horizontalPadding = PartyDrinksDesignSpec.px(context, 10);
        final bottomPadding = PartyDrinksDesignSpec.px(context, 10);

        return Material(
          color: PartyDrinksDesignSpec.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: borderSide,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: imageHeight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    PartyDrinksDesignSpec.px(context, 8),
                    horizontalPadding,
                    PartyDrinksDesignSpec.px(context, 4),
                  ),
                  child: PartyDrinkProductImageWidget(
                    drink: drink,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  0,
                  horizontalPadding,
                  bottomPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      drink.displayName(strings),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: PartyDrinksDesignSpec.px(context, 15),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: gap),
                    Text(
                      drink.displayDescription(strings),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: PartyDrinksDesignSpec.px(context, 12),
                        color: PartyDrinksDesignSpec.subtitleText,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: gap),
                    Align(
                      child: PartyDrinkVolumeBadgeWidget(volumeMl: drink.volumeMl),
                    ),
                    SizedBox(height: PartyDrinksDesignSpec.px(context, 10)),
                    Text(
                      PartyDrinkPriceFormatter.format(context, drink.priceClp),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: PartyDrinksDesignSpec.px(context, 17),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: gap),
                    PartyDrinkQuantityStepperWidget(
                      quantity: quantity,
                      onDecrement: drink.isAvailable ? onDecrement : () {},
                      onIncrement: drink.isAvailable ? onIncrement : () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
