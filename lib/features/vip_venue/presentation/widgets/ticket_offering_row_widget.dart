import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_entity.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_currency_formatter.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_surface_card_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_ticket_quantity_stepper_widget.dart';

class TicketOfferingRowWidget extends StatelessWidget {
  const TicketOfferingRowWidget({
    super.key,
    required this.offering,
    required this.isExpanded,
    required this.onTap,
    required this.onQuantityChanged,
  });

  final TicketOfferingEntity offering;
  final bool isExpanded;
  final VoidCallback? onTap;
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final soldOut = offering.isSoldOut || !offering.isSelectable;
    final accent = VipVenueScreenTheme.accent(context);
    final titleColor = soldOut
        ? VipVenueScreenTheme.muted(context)
        : VipVenueScreenTheme.title(context);
    final labelColor = soldOut ? VipVenueScreenTheme.muted(context) : accent;
    final priceLabel = VipCurrencyFormatter.formatAmount(
      context,
      offering.price,
      currencyCode: offering.currency,
    );

    return VipSurfaceCardWidget(
      margin: EdgeInsets.only(bottom: VipVenueDesignSpec.px(context, 12)),
      boxShadow: const [],
      backgroundColor: soldOut
          ? VipVenueScreenTheme.muted(context).withValues(alpha: 0.12)
          : null,
      onTap: soldOut ? null : onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
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
                    if (offering.badgeLabel != null && !soldOut) ...[
                      SizedBox(height: VipVenueDesignSpec.px(context, 2)),
                      AppText(
                        offering.badgeLabel!,
                        variant: AppTextVariant.body,
                        color: VipVenueScreenTheme.body(context),
                        fontSize: VipVenueDesignSpec.px(context, 12),
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (soldOut)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: VipVenueDesignSpec.px(context, 8),
                        vertical: VipVenueDesignSpec.px(context, 4),
                      ),
                      decoration: BoxDecoration(
                        color:
                            VipVenueScreenTheme.muted(context).withValues(alpha: 0.2),
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
                    AppText(
                      priceLabel,
                      variant: AppTextVariant.bodyEmphasis,
                      color: titleColor,
                      fontSize: VipVenueDesignSpec.px(context, 16),
                      fontWeight: FontWeight.w800,
                    ),
                ],
              ),
            ],
          ),
          if (offering.description != null && offering.description!.trim().isNotEmpty) ...[
            SizedBox(height: VipVenueDesignSpec.px(context, 4)),
            AppText(
              offering.description!,
              variant: AppTextVariant.body,
              color: soldOut
                  ? VipVenueScreenTheme.muted(context)
                  : VipVenueScreenTheme.body(context),
              fontSize: VipVenueDesignSpec.px(context, 12),
              fontWeight: FontWeight.w500,
            ),
          ],
          if (isExpanded && !soldOut) ...[
            SizedBox(height: VipVenueDesignSpec.px(context, 12)),
            VipTicketQuantityStepperWidget(
              quantity: offering.quantity,
              minQuantity: 1,
              onChanged: onQuantityChanged,
            ),
          ],
        ],
      ),
    );
  }
}
