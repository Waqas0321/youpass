import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_navigation_widgets.dart';

class VipFloorPlanHintCardWidget extends StatelessWidget {
  const VipFloorPlanHintCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final accent = VipVenueScreenTheme.accent(context);

    return VipNavigationEntryCardWidget(
      icon: Icons.star_rounded,
      title: AppStrings.vipTapVipZoneTitle(strings),
      subtitle: AppStrings.vipTapVipZoneSubtitle(strings),
      onTap: () {},
      titleColor: accent,
    );
  }
}
