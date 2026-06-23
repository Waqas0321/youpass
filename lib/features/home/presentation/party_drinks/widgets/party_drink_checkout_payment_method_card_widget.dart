import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/data/party_drink_checkout_mock_payment.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

class PartyDrinkCheckoutPaymentMethodCardWidget extends StatelessWidget {
  const PartyDrinkCheckoutPaymentMethodCardWidget({
    super.key,
    required this.onChangeTap,
  });

  final VoidCallback onChangeTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = PartyDrinksDesignSpec.px(context, 14);
    final iconSize = PartyDrinksDesignSpec.px(context, 40);
    final cardMask = AppStrings.partyDrinkCheckoutCardMask(
      strings,
      PartyDrinkCheckoutMockPayment.cardLast4,
    );

    return Container(
      decoration: BoxDecoration(
        color: PartyDrinksDesignSpec.checkoutSurface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: PartyDrinksDesignSpec.checkoutPaymentBorder),
      ),
      padding: EdgeInsets.all(PartyDrinksDesignSpec.px(context, 14)),
      child: Row(
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: const BoxDecoration(
              color: PartyDrinksDesignSpec.checkoutIconCircle,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.credit_card_rounded,
              size: PartyDrinksDesignSpec.px(context, 20),
              color: Colors.white,
            ),
          ),
          SizedBox(width: PartyDrinksDesignSpec.px(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.partyDrinkCheckoutPaymentMethod(strings),
                  style: TextStyle(
                    fontSize: PartyDrinksDesignSpec.px(context, 11),
                    color: PartyDrinksDesignSpec.checkoutMutedText,
                  ),
                ),
                SizedBox(height: PartyDrinksDesignSpec.px(context, 4)),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${AppStrings.partyDrinkCheckoutCreditCard(strings)} $cardMask',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: PartyDrinksDesignSpec.px(context, 14),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: PartyDrinksDesignSpec.px(context, 8)),
                    Text(
                      AppStrings.paymentBrandVisa(strings),
                      style: TextStyle(
                        fontSize: PartyDrinksDesignSpec.px(context, 10),
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1A1F71),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onChangeTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: PartyDrinksDesignSpec.px(context, 4),
                vertical: PartyDrinksDesignSpec.px(context, 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.partyDrinkCheckoutChangePayment(strings),
                    style: TextStyle(
                      fontSize: PartyDrinksDesignSpec.px(context, 14),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: PartyDrinksDesignSpec.px(context, 20),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
