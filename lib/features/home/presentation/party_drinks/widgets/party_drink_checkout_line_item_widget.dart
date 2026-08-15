import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_calculator.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_price_formatter.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_product_image_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_quantity_stepper_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_volume_badge_widget.dart';

class PartyDrinkCheckoutLineItemWidget extends StatelessWidget {
  const PartyDrinkCheckoutLineItemWidget({
    super.key,
    required this.lineItem,
    required this.onDecrement,
    required this.onIncrement,
  });

  final PartyDrinkCartLineItem lineItem;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final drink = lineItem.drink;
    final px = PartyDrinksDesignSpec.px;
    final imageSize = px(context, PartyDrinksDesignSpec.checkoutItemImageSize);
    final imageRadius = px(context, PartyDrinksDesignSpec.checkoutItemImageRadius);
    final cardRadius = px(context, PartyDrinksDesignSpec.checkoutItemCardRadius);

    return Padding(
      padding: EdgeInsets.only(
        bottom: px(context, PartyDrinksDesignSpec.checkoutItemCardGap),
      ),
      child: Material(
        color: PartyDrinksDesignSpec.checkoutItemCardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: const BorderSide(color: PartyDrinksDesignSpec.checkoutItemCardBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(px(context, 12)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(imageRadius),
                child: PartyDrinkProductImageWidget(
                  drink: drink,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: px(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      drink.displayName(context.l10n),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: px(context, 15),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    if (drink.volumeMl > 0) ...[
                      SizedBox(height: px(context, 6)),
                      PartyDrinkVolumeBadgeWidget(
                        volumeMl: drink.volumeMl,
                        filled: true,
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: px(context, 8)),
              PartyDrinkCheckoutQuantityStepperWidget(
                quantity: lineItem.quantity,
                onDecrement: onDecrement,
                onIncrement: onIncrement,
              ),
              SizedBox(width: px(context, 10)),
              SizedBox(
                width: px(context, 104),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    PartyDrinkPriceFormatter.format(
                      context,
                      lineItem.subtotalClp,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: px(context, 15),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
