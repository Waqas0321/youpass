import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_card_model.dart';

class PartyDrinkCheckoutPaymentMethodCardWidget extends StatelessWidget {
  const PartyDrinkCheckoutPaymentMethodCardWidget({
    super.key,
    required this.onTap,
    this.card,
    this.isLoading = false,
    this.isBusy = false,
  });

  final VoidCallback? onTap;
  final ProfileWalletCardModel? card;
  final bool isLoading;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = PartyDrinksDesignSpec.px(context, 14);
    final iconSize = PartyDrinksDesignSpec.px(context, 40);
    final brand = (card?.brand ?? 'visa').toLowerCase();
    final brandLabel = brand == 'mastercard'
        ? AppStrings.paymentBrandMastercard(strings)
        : AppStrings.paymentBrandVisa(strings);
    final cardLine = card == null
        ? AppStrings.vipAddPaymentMethod(strings)
        : '${AppStrings.partyDrinkCheckoutCreditCard(strings)} ${AppStrings.partyDrinkCheckoutCardMask(strings, card!.lastFour)}';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (isBusy || isLoading) ? null : onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
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
                child: isLoading || isBusy
                    ? Padding(
                        padding: EdgeInsets.all(
                          PartyDrinksDesignSpec.px(context, 10),
                        ),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(
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
                            cardLine,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: PartyDrinksDesignSpec.px(context, 14),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (card != null) ...[
                          SizedBox(width: PartyDrinksDesignSpec.px(context, 8)),
                          Text(
                            brandLabel,
                            style: TextStyle(
                              fontSize: PartyDrinksDesignSpec.px(context, 10),
                              fontWeight: FontWeight.w800,
                              color: brand == 'mastercard'
                                  ? const Color(0xFFEB001B)
                                  : const Color(0xFF1A1F71),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              if (card != null)
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
    );
  }
}
