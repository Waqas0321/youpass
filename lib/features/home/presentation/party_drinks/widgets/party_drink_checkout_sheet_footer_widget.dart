import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';

class PartyDrinkCheckoutSheetFooterWidget extends StatelessWidget {
  const PartyDrinkCheckoutSheetFooterWidget({
    super.key,
    required this.onPurchaseTap,
    this.isSubmitting = false,
  });

  final VoidCallback onPurchaseTap;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.horizontalPadding,
    );
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        PartyDrinksDesignSpec.px(context, 8),
        horizontalPadding,
        bottomPadding + PartyDrinksDesignSpec.px(context, 8),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: PartyDrinksDesignSpec.px(context, 52),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                PartyDrinksDesignSpec.px(context, 14),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: isSubmitting ? null : onPurchaseTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isSubmitting)
                      SizedBox(
                        width: PartyDrinksDesignSpec.px(context, 18),
                        height: PartyDrinksDesignSpec.px(context, 18),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      )
                    else
                      Icon(
                        Icons.lock_outline_rounded,
                        size: PartyDrinksDesignSpec.px(context, 18),
                        color: Colors.black,
                      ),
                    SizedBox(width: PartyDrinksDesignSpec.px(context, 8)),
                    Text(
                      AppStrings.partyDrinkCheckoutCompletePurchase(strings),
                      style: TextStyle(
                        fontSize: PartyDrinksDesignSpec.px(context, 16),
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: PartyDrinksDesignSpec.px(context, 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: PartyDrinksDesignSpec.px(context, 12),
                color: PartyDrinksDesignSpec.checkoutMutedText,
              ),
              SizedBox(width: PartyDrinksDesignSpec.px(context, 6)),
              Text(
                AppStrings.partyDrinkCheckoutSecurePayment(strings),
                style: TextStyle(
                  fontSize: PartyDrinksDesignSpec.px(context, 12),
                  color: PartyDrinksDesignSpec.checkoutMutedText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
