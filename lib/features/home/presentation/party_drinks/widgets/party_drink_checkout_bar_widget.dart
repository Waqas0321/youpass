import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_card_model.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_calculator.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_price_formatter.dart';

class PartyDrinkCheckoutBarWidget extends StatelessWidget {
  const PartyDrinkCheckoutBarWidget({
    super.key,
    required this.cart,
    this.card,
    this.onBuyTap,
  });

  final PartyDrinkCartSummary cart;

  /// User's default wallet card; null shows only the generic "credit card" label.
  final ProfileWalletCardModel? card;
  final VoidCallback? onBuyTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = PartyDrinksDesignSpec.px(context, 20);
    const dividerColor = Color(0xFFE5E5E5);
    final totalLabel = PartyDrinkPriceFormatter.format(context, cart.totalClp);

    return Material(
      elevation: 12,
      shadowColor: Colors.black.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(radius),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: PartyDrinksDesignSpec.px(context, 12),
          vertical: PartyDrinksDesignSpec.px(context, 12),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.partyDrinkCheckoutPaymentMethod(strings),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: PartyDrinksDesignSpec.px(context, 11),
                      color: const Color(0xFF757575),
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: PartyDrinksDesignSpec.px(context, 6)),
                  Row(
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: PartyDrinksDesignSpec.px(context, 18),
                        color: const Color(0xFF212121),
                      ),
                      SizedBox(width: PartyDrinksDesignSpec.px(context, 6)),
                      // Brand + last four scale down together so the full brand stays
                      // readable in the narrow bar column instead of ellipsizing.
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            cart.grandTotalClp <= 0
                                ? AppStrings.partyDrinkCheckoutNoCharge(strings)
                                : card != null
                                ? '${card!.maskedLabel.split(' ').first} •${card!.lastFour}'
                                : AppStrings.partyDrinkCheckoutCreditCard(
                                    strings,
                                  ),
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: PartyDrinksDesignSpec.px(context, 12),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF212121),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: PartyDrinksDesignSpec.px(context, 44),
              color: dividerColor,
              margin: EdgeInsets.symmetric(
                horizontal: PartyDrinksDesignSpec.px(context, 8),
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.partyDrinkCheckoutProducts(
                      strings,
                      cart.itemCount,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: PartyDrinksDesignSpec.px(context, 11),
                      color: const Color(0xFF757575),
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: PartyDrinksDesignSpec.px(context, 4)),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      totalLabel,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: PartyDrinksDesignSpec.px(context, 18),
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF212121),
                        height: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: PartyDrinksDesignSpec.px(context, 8)),
            Material(
              color: PartyDrinksDesignSpec.gold,
              borderRadius: BorderRadius.circular(
                PartyDrinksDesignSpec.px(context, 12),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onBuyTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: PartyDrinksDesignSpec.px(context, 12),
                    vertical: PartyDrinksDesignSpec.px(context, 12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.partyDrinkCheckoutBuy(strings),
                        style: TextStyle(
                          fontSize: PartyDrinksDesignSpec.px(context, 13),
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(width: PartyDrinksDesignSpec.px(context, 2)),
                      Icon(
                        Icons.chevron_right,
                        size: PartyDrinksDesignSpec.px(context, 18),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
