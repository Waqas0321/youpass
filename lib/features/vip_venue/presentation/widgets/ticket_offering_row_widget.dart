import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_section.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_currency_formatter.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_venue_label_helper.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_shared_widgets.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_surface_card_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_ticket_quantity_stepper_widget.dart';

class TicketOfferingRowWidget extends StatelessWidget {
  const TicketOfferingRowWidget({
    super.key,
    required this.offering,
    required this.isExpanded,
    required this.onTap,
    required this.onQuantityChanged,
    this.countryIsoCode,
    this.currencyDecimals,
  });

  final TicketOfferingEntity offering;
  final bool isExpanded;
  final VoidCallback? onTap;
  final ValueChanged<int> onQuantityChanged;
  final String? countryIsoCode;
  final int? currencyDecimals;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final soldOut = offering.isSoldOut || !offering.isSelectable;
    final isVip = offering.section == TicketOfferingSection.vip;
    final accent = isVip
        ? VipVenueScreenTheme.vipCardAccent(context)
        : VipVenueScreenTheme.accent(context);
    final titleColor = soldOut
        ? VipVenueScreenTheme.muted(context)
        : VipVenueScreenTheme.title(context);
    final labelColor = soldOut ? VipVenueScreenTheme.muted(context) : accent;
    final cardRadius = VipVenueDesignSpec.px(context, 14);
    final priceDisplay = VipCurrencyFormatter.formatTicketCardPrice(
      context,
      offering.price,
      currencyCode: offering.currency,
      countryIsoCode: countryIsoCode,
      currencyDecimals: currencyDecimals,
    );
    final description = VipVenueLabelHelper.offeringDescription(strings, offering);

    return VipSurfaceCardWidget(
      margin: EdgeInsets.only(bottom: VipVenueDesignSpec.px(context, 12)),
      padding: EdgeInsets.zero,
      boxShadow: const [],
      borderColor: soldOut ? VipVenueScreenTheme.cardBorder(context) : accent,
      borderWidth: soldOut ? 1 : 1.2,
      radius: cardRadius,
      backgroundColor: soldOut
          ? VipVenueScreenTheme.muted(context).withValues(alpha: 0.12)
          : null,
      onTap: soldOut ? null : onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(VipVenueDesignSpec.px(context, 14)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        offering.displayName,
                        variant: AppTextVariant.bodyEmphasis,
                        color: labelColor,
                        fontSize: VipVenueDesignSpec.px(context, 14),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                      SizedBox(height: VipVenueDesignSpec.px(context, 4)),
                      AppText(
                        description,
                        variant: AppTextVariant.body,
                        color: soldOut
                            ? VipVenueScreenTheme.muted(context)
                            : VipVenueScreenTheme.body(context),
                        fontSize: VipVenueDesignSpec.px(context, 12),
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: VipVenueDesignSpec.px(context, 12)),
                if (soldOut)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: VipVenueDesignSpec.px(context, 8),
                      vertical: VipVenueDesignSpec.px(context, 4),
                    ),
                    decoration: BoxDecoration(
                      color: VipVenueScreenTheme.muted(context)
                          .withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(
                        VipVenueDesignSpec.px(context, 6),
                      ),
                    ),
                    child: AppText(
                      AppStrings.vipTicketSoldOutBadge(strings),
                      variant: AppTextVariant.body,
                      color: VipVenueScreenTheme.muted(context),
                      fontSize: VipVenueDesignSpec.px(context, 11),
                      fontWeight: FontWeight.w700,
                    ),
                  )
                else
                  VipPriceColumnWidget(
                    amount: priceDisplay.amountLine,
                    currencyLabel: priceDisplay.currencyLine,
                    amountColor: titleColor,
                  ),
              ],
            ),
          ),
          if (isExpanded && !soldOut)
            Container(
              decoration: BoxDecoration(
                color: isVip
                    ? accent.withValues(alpha: 0.12)
                    : VipVenueScreenTheme.stepperBarBackground(context),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(cardRadius),
                  bottomRight: Radius.circular(cardRadius),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: VipVenueDesignSpec.px(context, 10),
                vertical: VipVenueDesignSpec.px(context, 8),
              ),
              child: VipTicketQuantityStepperWidget(
                quantity: offering.quantity,
                minQuantity: 1,
                onChanged: onQuantityChanged,
                alignControlsEnd: true,
                accentColor: isVip ? accent : null,
              ),
            ),
        ],
      ),
    );
  }
}
