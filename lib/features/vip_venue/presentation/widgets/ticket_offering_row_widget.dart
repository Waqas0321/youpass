import 'package:flutter/material.dart';
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
    required this.onQuantityChanged,
  });

  final TicketOfferingEntity offering;
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);

    return VipSurfaceCardWidget(
      margin: EdgeInsets.only(bottom: VipVenueDesignSpec.px(context, 12)),
      boxShadow: const [],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            offering.label,
            variant: AppTextVariant.bodyEmphasis,
            color: accent,
            fontSize: VipVenueDesignSpec.px(context, 14),
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
          if (offering.badgeLabel != null) ...[
            SizedBox(height: VipVenueDesignSpec.px(context, 2)),
            AppText(
              offering.badgeLabel!,
              variant: AppTextVariant.body,
              color: VipVenueScreenTheme.body(context),
              fontSize: VipVenueDesignSpec.px(context, 12),
              fontWeight: FontWeight.w500,
            ),
          ],
          SizedBox(height: VipVenueDesignSpec.px(context, 6)),
          AppText(
            VipCurrencyFormatter.formatAmount(
              context,
              offering.price,
              currencyCode: offering.currency,
            ),
            variant: AppTextVariant.bodyEmphasis,
            color: VipVenueScreenTheme.title(context),
            fontSize: VipVenueDesignSpec.px(context, 16),
            fontWeight: FontWeight.w800,
          ),
          if (offering.description != null) ...[
            SizedBox(height: VipVenueDesignSpec.px(context, 4)),
            AppText(
              offering.description!,
              variant: AppTextVariant.body,
              color: VipVenueScreenTheme.body(context),
              fontSize: VipVenueDesignSpec.px(context, 12),
              fontWeight: FontWeight.w500,
            ),
          ],
          SizedBox(height: VipVenueDesignSpec.px(context, 12)),
          VipTicketQuantityStepperWidget(
            quantity: offering.quantity,
            onChanged: onQuantityChanged,
          ),
        ],
      ),
    );
  }
}
