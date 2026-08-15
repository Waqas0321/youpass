import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/presentation/providers/app_theme_provider.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/home/presentation/utils/party_mode_navigation.dart';

/// Wireframe header: menu (left), YouPass ON pill (true center), title + subtitle below.
class PartyDrinkMenuHeaderWidget extends StatelessWidget {
  const PartyDrinkMenuHeaderWidget({
    super.key,
    required this.onMenuTap,
    this.subtitle,
  });

  final VoidCallback onMenuTap;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = Theme.of(context);
    final layout = ResponsiveLayout(context);
    final themeProvider = context.watch<AppThemeProvider>();
    final homeProvider = context.watch<HomeProvider>();
    final horizontalPadding = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.horizontalPadding,
    );
    final topBarHeight = PartyDrinksDesignSpec.px(context, 48);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: topBarHeight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: layout.iconSize + PartyDrinksDesignSpec.px(context, 8),
                      height: topBarHeight,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: onMenuTap,
                        icon: Icon(
                          Icons.menu,
                          color: PartyDrinksDesignSpec.gold,
                          size: layout.iconSize,
                        ),
                      ),
                    ),
                  ),
                  FiestaModeToggleWidget(
                    isFiestaMode: themeProvider.isFiestaMode,
                    onToggle: () {
                      PartyModeNavigation.toggleFromPartyScreen(
                        context,
                        eligible: homeProvider.partyModeEligible,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: PartyDrinksDesignSpec.px(context, 16)),
            Text(
              AppStrings.drawerDrinkMenu(strings),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: PartyDrinksDesignSpec.px(context, 24),
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
                height: 1.15,
              ),
            ),
            SizedBox(height: PartyDrinksDesignSpec.px(context, 8)),
            Text(
              subtitle?.trim().isNotEmpty == true
                  ? subtitle!.trim()
                  : AppStrings.partyDrinkMenuSubtitle(strings),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: PartyDrinksDesignSpec.px(context, 14),
                color: PartyDrinksDesignSpec.subtitleText,
                height: 1.3,
              ),
            ),
            SizedBox(height: PartyDrinksDesignSpec.px(context, 16)),
          ],
        ),
      ),
    );
  }
}
