import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_shared_widgets.dart';

/// Informational banner — VIP zones above are tappable; this card is not a button.
class VipFloorPlanHintCardWidget extends StatelessWidget {
  const VipFloorPlanHintCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final accent = VipVenueScreenTheme.accent(context);

    return Container(
      padding: EdgeInsets.all(VipVenueDesignSpec.px(context, 14)),
      decoration: BoxDecoration(
        color: VipVenueScreenTheme.hintCardBackground(context),
        borderRadius: BorderRadius.circular(VipVenueDesignSpec.px(context, 14)),
        border: Border.all(color: accent, width: 1.2),
      ),
      child: Row(
        children: [
          VipIconBadgeWidget(
            icon: Icons.star_rounded,
            size: 44,
            iconSize: 22,
            backgroundColor: VipVenueScreenTheme.accentSurface(context),
            iconColor: accent,
          ),
          SizedBox(width: VipVenueDesignSpec.px(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.vipTapVipZoneTitle(strings),
                  style: TextStyle(
                    color: accent,
                    fontSize: VipVenueDesignSpec.px(context, 15),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: VipVenueDesignSpec.px(context, 4)),
                Text(
                  AppStrings.vipTapVipZoneSubtitle(strings),
                  style: TextStyle(
                    color: VipVenueScreenTheme.body(context),
                    fontSize: VipVenueDesignSpec.px(context, 12),
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
