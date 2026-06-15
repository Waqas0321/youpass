import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';

/// Central drawer palette — resolves light vs Party Mode (dark) from app theme.
class HomeDrawerTheme {
  const HomeDrawerTheme._({
    required this.isDark,
    required this.panelBackground,
    required this.gold,
    required this.goldSecondary,
    required this.menuTileBackground,
    required this.menuBorder,
    required this.menuTitle,
    required this.menuIcon,
    required this.chevron,
    required this.invitationsBackground,
    required this.invitationsBorder,
    required this.invitationsTitle,
    required this.invitationsBadgeBackground,
    required this.invitationsBadgeText,
    required this.profileCardGradientStart,
    required this.profileCardGradientEnd,
    required this.profileWaveBands,
    required this.shadowColor,
  });

  final bool isDark;
  final Color panelBackground;
  final Color gold;
  final Color goldSecondary;
  final Color menuTileBackground;
  final Color menuBorder;
  final Color menuTitle;
  final Color menuIcon;
  final Color chevron;
  final Color invitationsBackground;
  final Color invitationsBorder;
  final Color invitationsTitle;
  final Color invitationsBadgeBackground;
  final Color invitationsBadgeText;
  final Color profileCardGradientStart;
  final Color profileCardGradientEnd;
  final List<Color> profileWaveBands;
  final Color shadowColor;

  static const _darkWaveBands = [
    Color(0xFF3D3218),
    Color(0xFF473A1C),
    Color(0xFF52441F),
    Color(0xFF5C4E23),
  ];

  factory HomeDrawerTheme.of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final extension = YouPassThemeExtension.of(context);
    final scheme = Theme.of(context).colorScheme;

    if (!isDark) {
      return const HomeDrawerTheme._(
        isDark: false,
        panelBackground: DrawerDesignSpec.screenBackground,
        gold: DrawerDesignSpec.gold,
        goldSecondary: DrawerDesignSpec.goldSparkleSecondary,
        menuTileBackground: DrawerDesignSpec.menuTileBackground,
        menuBorder: DrawerDesignSpec.menuBorder,
        menuTitle: DrawerDesignSpec.menuTitle,
        menuIcon: DrawerDesignSpec.menuTitle,
        chevron: Color(0x73000000),
        invitationsBackground: DrawerDesignSpec.invitationsBackground,
        invitationsBorder: DrawerDesignSpec.gold,
        invitationsTitle: DrawerDesignSpec.gold,
        invitationsBadgeBackground: DrawerDesignSpec.invitationsBadgeBackground,
        invitationsBadgeText: DrawerDesignSpec.invitationsBadgeText,
        profileCardGradientStart: DrawerDesignSpec.profileBackground,
        profileCardGradientEnd: Color(0xFFFFF8EC),
        profileWaveBands: [
          DrawerDesignSpec.profileWaveBand1,
          DrawerDesignSpec.profileWaveBand2,
          DrawerDesignSpec.profileWaveBand3,
          DrawerDesignSpec.profileWaveBand4,
        ],
        shadowColor: Color(0x1F000000),
      );
    }

    return HomeDrawerTheme._(
      isDark: true,
      panelBackground: Theme.of(context).scaffoldBackgroundColor,
      gold: AppColors.homeAccentYellow,
      goldSecondary: AppColors.drawerGold,
      menuTileBackground: extension.drawerMenuTileBackground,
      menuBorder: extension.drawerMenuBorder,
      menuTitle: extension.drawerMenuTitle,
      menuIcon: extension.drawerMenuTitle,
      chevron: scheme.onSurfaceVariant.withValues(alpha: 0.7),
      invitationsBackground: extension.drawerInvitationsTileBackground,
      invitationsBorder: AppColors.homeAccentYellow,
      invitationsTitle: AppColors.homeAccentYellow,
      invitationsBadgeBackground: extension.drawerInvitationsBadgeBackground,
      invitationsBadgeText: extension.drawerInvitationsBadgeText,
      profileCardGradientStart: const Color(0xFF2A2210),
      profileCardGradientEnd: extension.drawerMenuTileBackground,
      profileWaveBands: _darkWaveBands,
      shadowColor: Colors.transparent,
    );
  }
}
