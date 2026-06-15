import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_entity.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_currency_formatter.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_venue_label_helper.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_shared_widgets.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_surface_card_widget.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class VipTableDetailCardWidget extends StatelessWidget {
  const VipTableDetailCardWidget({
    super.key,
    required this.table,
    required this.zone,
    this.currencyCode = 'CLP',
    this.countryIsoCode = 'CL',
  });

  final VenueTableEntity table;
  final VenueZoneEntity zone;
  final String currencyCode;
  final String countryIsoCode;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final accent = VipVenueScreenTheme.accent(context);
    final tableNumber = VipVenueLabelHelper.tableDisplayNumber(table.label);

    return VipSurfaceCardWidget(
      borderColor: accent,
      borderWidth: 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      AppStrings.vipTableDetailTitle(strings, tableNumber, zone.name),
                      variant: AppTextVariant.bodyEmphasis,
                      color: VipVenueScreenTheme.title(context),
                      fontSize: VipVenueDesignSpec.px(context, 16),
                      fontWeight: FontWeight.w800,
                    ),
                    if (table.showsAsPremium) ...[
                      SizedBox(height: VipVenueDesignSpec.px(context, 6)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: VipVenueDesignSpec.px(context, 8),
                          vertical: VipVenueDesignSpec.px(context, 4),
                        ),
                        decoration: BoxDecoration(
                          color: VipVenueDesignSpec.tablePremium.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(
                            VipVenueDesignSpec.px(context, 8),
                          ),
                        ),
                        child: Text(
                          AppStrings.vipTablePremiumBadge(strings),
                          style: TextStyle(
                            color: VipVenueDesignSpec.tablePremium,
                            fontSize: VipVenueDesignSpec.px(context, 11),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              VipPriceColumnWidget(
                amount: VipCurrencyFormatter.formatAmountCompact(
                  context,
                  table.price,
                  currencyCode: currencyCode,
                  countryIsoCode: countryIsoCode,
                ),
                currencyLabel: currencyCode,
              ),
            ],
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 12)),
          VipMetaRowWidget(
            icon: Icons.people_outline,
            label: AppStrings.vipTableCapacity(strings, table.capacity),
          ),
          if (table.bottleCount > 0) ...[
            SizedBox(height: VipVenueDesignSpec.px(context, 4)),
            VipMetaRowWidget(
              icon: Icons.local_bar_outlined,
              label: AppStrings.vipTableBottles(strings, table.bottleCount),
            ),
          ],
          if (table.voucherCount > 0) ...[
            SizedBox(height: VipVenueDesignSpec.px(context, 4)),
            VipMetaRowWidget(
              icon: Icons.confirmation_number_outlined,
              label: AppStrings.vipTableVouchers(strings, table.voucherCount),
            ),
          ],
          for (final extra in table.extras) ...[
            SizedBox(height: VipVenueDesignSpec.px(context, 4)),
            VipMetaRowWidget(
              icon: Icons.star_outline,
              label: extra,
            ),
          ],
        ],
      ),
    );
  }
}
