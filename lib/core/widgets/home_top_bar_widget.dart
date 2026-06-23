import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/presentation/providers/app_theme_provider.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_widget.dart';
import 'package:youpass/core/widgets/youpass_home_pill_logo_widget.dart';

class HomeTopBarWidget extends StatelessWidget {
  const HomeTopBarWidget({
    super.key,
    this.onMenuTap,
    this.showPartyModeBanner = false,
    this.partyModeEligible = false,
  });

  final VoidCallback? onMenuTap;
  final bool showPartyModeBanner;
  final bool partyModeEligible;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final themeProvider = context.watch<AppThemeProvider>();
    final sideSlotWidth = layout.iconSize + layout.spacing(16);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: layout.spacing(4),
        vertical: layout.spacing(8),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onMenuTap ?? () {},
            icon: Icon(
              Icons.menu,
              color: AppColors.homeAccentYellow,
              size: layout.iconSize,
            ),
          ),
          Expanded(
            child: Center(
              child: showPartyModeBanner
                  ? FiestaModeToggleWidget(
                      isFiestaMode: themeProvider.isFiestaMode,
                      onToggle: () => themeProvider.toggleFiestaMode(
                        eligible: partyModeEligible,
                      ),
                    )
                  : const YouPassHomePillLogoWidget(),
            ),
          ),
          SizedBox(width: sideSlotWidth),
        ],
      ),
    );
  }
}
