import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_calculator.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_price_formatter.dart';

class PartyDrinkCheckoutPriceBreakdownWidget extends StatelessWidget {
  const PartyDrinkCheckoutPriceBreakdownWidget({
    super.key,
    required this.cart,
  });

  final PartyDrinkCartSummary cart;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Column(
      children: [
        _PriceRow(
          label: AppStrings.partyDrinkCheckoutSubtotal(strings),
          value: PartyDrinkPriceFormatter.format(context, cart.subtotalClp),
        ),
        SizedBox(height: PartyDrinksDesignSpec.px(context, 12)),
        _PriceRow(
          label: AppStrings.partyDrinkCheckoutServiceCharge(strings),
          value: PartyDrinkPriceFormatter.format(context, cart.serviceChargeClp),
          showInfo: true,
        ),
        SizedBox(height: PartyDrinksDesignSpec.px(context, 16)),
        _PriceRow(
          label: AppStrings.partyDrinkCheckoutTotal(strings),
          value: PartyDrinkPriceFormatter.format(context, cart.grandTotalClp),
          emphasized: true,
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.emphasized = false,
    this.showInfo = false,
  });

  final String label;
  final String value;
  final bool emphasized;
  final bool showInfo;

  @override
  Widget build(BuildContext context) {
    final labelSize = emphasized
        ? PartyDrinksDesignSpec.px(context, 18)
        : PartyDrinksDesignSpec.px(context, 15);
    final valueSize = emphasized
        ? PartyDrinksDesignSpec.px(context, 18)
        : PartyDrinksDesignSpec.px(context, 15);

    return Row(
      children: [
        if (showInfo)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: labelSize,
                  fontWeight: FontWeight.w400,
                  color: PartyDrinksDesignSpec.checkoutMutedText,
                ),
              ),
              SizedBox(width: PartyDrinksDesignSpec.px(context, 5)),
              Icon(
                Icons.info_outline_rounded,
                size: PartyDrinksDesignSpec.px(context, 15),
                color: PartyDrinksDesignSpec.checkoutMutedText,
              ),
            ],
          )
        else
          Text(
            label,
            style: TextStyle(
              fontSize: labelSize,
              fontWeight: emphasized ? FontWeight.w800 : FontWeight.w500,
              color: Colors.white,
            ),
          ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: valueSize,
            fontWeight: emphasized ? FontWeight.w800 : FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
