import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

/// Resolves profile hub colors for light mode and Party Mode (dark).
class ProfileTheme {
  const ProfileTheme._({
    required this.isDark,
    required this.screenBackground,
    required this.primary,
    required this.cardBackground,
    required this.cardBorder,
    required this.cardShadow,
    required this.cardWaveBands,
    required this.valueText,
    required this.labelText,
    required this.phoneIcon,
    required this.divider,
    required this.rowDivider,
    required this.sectionDivider,
    required this.iconCircleBackground,
    required this.sectionCardBackground,
    required this.sectionCardBorder,
    required this.sectionCardShadow,
    required this.chevronMuted,
    required this.editButtonFill,
    required this.logoutButtonFill,
    required this.logoutButtonForeground,
    required this.logoutButtonBorder,
    required this.deleteButtonFill,
    required this.deleteButtonForeground,
    required this.walletViewButtonFill,
    required this.walletCardBackground,
    required this.walletCardBorder,
    required this.avatarRing,
    required this.avatarInner,
    required this.avatarIcon,
    required this.bannerGradientStart,
    required this.bannerGradientEnd,
    required this.bannerBorder,
    required this.bannerTitleText,
    required this.bannerSubtitleText,
    required this.bannerCompleteButtonForeground,
    required this.switchThumbColor,
    required this.switchInactiveTrack,
  });

  final bool isDark;
  final Color screenBackground;
  final Color primary;
  final Color cardBackground;
  final Color cardBorder;
  final Color cardShadow;
  final List<Color> cardWaveBands;
  final Color valueText;
  final Color labelText;
  final Color phoneIcon;
  final Color divider;
  final Color rowDivider;
  final Color sectionDivider;
  final Color iconCircleBackground;
  final Color sectionCardBackground;
  final Color sectionCardBorder;
  final Color sectionCardShadow;
  final Color chevronMuted;
  final Color editButtonFill;
  final Color logoutButtonFill;
  final Color logoutButtonForeground;
  final Color logoutButtonBorder;
  final Color deleteButtonFill;
  final Color deleteButtonForeground;
  final Color walletViewButtonFill;
  final Color walletCardBackground;
  final Color walletCardBorder;
  final Color avatarRing;
  final Color avatarInner;
  final Color avatarIcon;
  final Color bannerGradientStart;
  final Color bannerGradientEnd;
  final Color bannerBorder;
  final Color bannerTitleText;
  final Color bannerSubtitleText;
  final Color bannerCompleteButtonForeground;
  final Color switchThumbColor;
  final Color switchInactiveTrack;

  static const _darkWaveBands = [
    Color(0xFF2A2210),
    Color(0xFF332A14),
    Color(0xFF3D3218),
    Color(0xFF473A1C),
  ];

  factory ProfileTheme.of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final extension = YouPassThemeExtension.of(context);
    final scheme = Theme.of(context).colorScheme;

    if (!isDark) {
      return ProfileTheme._(
        isDark: false,
        screenBackground: ProfileDesignSpec.screenBackground,
        primary: ProfileDesignSpec.primary,
        cardBackground: ProfileDesignSpec.cardBackground,
        cardBorder: ProfileDesignSpec.cardBorder,
        cardShadow: const Color(0x08000000),
        cardWaveBands: const [
          ProfileDesignSpec.cardWave1,
          ProfileDesignSpec.cardWave2,
          ProfileDesignSpec.cardWave3,
          ProfileDesignSpec.cardWave4,
        ],
        valueText: ProfileDesignSpec.valueText,
        labelText: ProfileDesignSpec.labelText,
        phoneIcon: ProfileDesignSpec.phoneIcon,
        divider: ProfileDesignSpec.divider,
        rowDivider: ProfileDesignSpec.rowDivider,
        sectionDivider: ProfileDesignSpec.sectionDividerOrange,
        iconCircleBackground: ProfileDesignSpec.iconCircleBackground,
        sectionCardBackground: ProfileDesignSpec.sectionCardBackground,
        sectionCardBorder: ProfileDesignSpec.sectionCardBorder,
        sectionCardShadow: const Color(0x06000000),
        chevronMuted: ProfileDesignSpec.chevronMuted,
        editButtonFill: ProfileDesignSpec.editButtonFill,
        logoutButtonFill: ProfileDesignSpec.logoutButtonFill,
        logoutButtonForeground: ProfileDesignSpec.primary,
        logoutButtonBorder: ProfileDesignSpec.primary,
        deleteButtonFill: ProfileDesignSpec.deleteButtonFill,
        deleteButtonForeground: ProfileDesignSpec.deleteButtonForeground,
        walletViewButtonFill: ProfileDesignSpec.walletViewButtonFill,
        walletCardBackground: ProfileDesignSpec.walletCardBackground,
        walletCardBorder: ProfileDesignSpec.walletCardBorder,
        avatarRing: ProfileDesignSpec.avatarRing,
        avatarInner: ProfileDesignSpec.avatarInner,
        avatarIcon: ProfileDesignSpec.avatarIcon,
        bannerGradientStart: const Color(0xFFFFF4D6),
        bannerGradientEnd: const Color(0xFFFFE8A8),
        bannerBorder: AppColors.profileCardBorder,
        bannerTitleText: AppColors.profileValueDark,
        bannerSubtitleText: AppColors.profileLabelGrey,
        bannerCompleteButtonForeground: Colors.white,
        switchThumbColor: ProfileDesignSpec.sectionCardBackground,
        switchInactiveTrack: ProfileDesignSpec.rowDivider,
      );
    }

    return ProfileTheme._(
      isDark: true,
      screenBackground: Theme.of(context).scaffoldBackgroundColor,
      primary: AppColors.homeAccentYellow,
      cardBackground: extension.cardBackground,
      cardBorder: extension.profileCardBorder,
      cardShadow: Colors.transparent,
      cardWaveBands: _darkWaveBands,
      valueText: scheme.onSurface,
      labelText: scheme.onSurfaceVariant,
      phoneIcon: scheme.onSurfaceVariant,
      divider: extension.profileSectionDivider,
      rowDivider: extension.profileRowDivider,
      sectionDivider: extension.profileSectionDivider,
      iconCircleBackground: extension.profileIconBadgeBackground,
      sectionCardBackground: extension.cardBackground,
      sectionCardBorder: extension.cardBorder,
      sectionCardShadow: Colors.transparent,
      chevronMuted: scheme.onSurfaceVariant.withValues(alpha: 0.55),
      editButtonFill: extension.outlineButtonFill,
      logoutButtonFill: extension.outlineButtonFill,
      logoutButtonForeground: extension.outlineButtonForeground,
      logoutButtonBorder: extension.outlineButtonBorder,
      deleteButtonFill: const Color(0xFF2A1515),
      deleteButtonForeground: const Color(0xFFFF6B6B),
      walletViewButtonFill: const Color(0xFF2A2210),
      walletCardBackground: extension.cardBackground,
      walletCardBorder: extension.cardBorder,
      avatarRing: AppColors.homeAccentYellow,
      avatarInner: const Color(0xFF1A1A1A),
      avatarIcon: AppColors.homeAccentYellow,
      bannerGradientStart: const Color(0xFF2A2210),
      bannerGradientEnd: const Color(0xFF1A1A1A),
      bannerBorder: extension.profileCardBorder,
      bannerTitleText: scheme.onSurface,
      bannerSubtitleText: scheme.onSurfaceVariant,
      bannerCompleteButtonForeground: AppColors.homeBlack,
      switchThumbColor: extension.cardBackground,
      switchInactiveTrack: extension.cardBorder,
    );
  }
}
