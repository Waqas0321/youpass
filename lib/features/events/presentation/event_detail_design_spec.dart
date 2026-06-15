import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';

class EventDetailTheme {
  const EventDetailTheme({
    required this.screenBackground,
    required this.headerBackground,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.promoterCardBackground,
    required this.promoterCardBorder,
    required this.gold,
    required this.iconDefault,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.barDivider,
  });

  final Color screenBackground;
  final Color headerBackground;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color promoterCardBackground;
  final Color promoterCardBorder;
  final Color gold;
  final Color iconDefault;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color barDivider;

  static EventDetailTheme of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final extension = YouPassThemeExtension.of(context);

    if (isDark) {
      return const EventDetailTheme(
        screenBackground: AppColors.darkNavy,
        headerBackground: AppColors.darkNavy,
        textPrimary: Color(0xFFFFFFFF),
        textSecondary: Color(0xFFB8C4D9),
        textMuted: Color(0xFF8FA3BF),
        promoterCardBackground: Color(0xFF243656),
        promoterCardBorder: Color(0xFF314868),
        gold: Color(0xFFE5A906),
        iconDefault: Color(0xFFFFFFFF),
        shimmerBase: Color(0xFF243656),
        shimmerHighlight: Color(0xFF314868),
        barDivider: Color(0xFF314868),
      );
    }

    return EventDetailTheme(
      screenBackground: Theme.of(context).scaffoldBackgroundColor,
      headerBackground: Theme.of(context).scaffoldBackgroundColor,
      textPrimary: Theme.of(context).colorScheme.onSurface,
      textSecondary: AppColors.secondaryGrey,
      textMuted: AppColors.profileLabelGrey,
      promoterCardBackground: extension.cardBackground,
      promoterCardBorder: extension.cardBorder,
      gold: const Color(0xFFE5A906),
      iconDefault: Theme.of(context).colorScheme.onSurface,
      shimmerBase: extension.shimmerBase,
      shimmerHighlight: extension.shimmerHighlight,
      barDivider: AppColors.homeDividerGrey,
    );
  }
}

class EventDetailDesignSpec {
  EventDetailDesignSpec._();

  static const double designWidth = 390;
  static const double horizontalPadding = 20;
  static const double imageBottomRadius = 16;
  static const double promoterAvatarSize = 48;
  static const double buyButtonHeight = 54;
  static const double buyButtonRadius = 12;

  static double px(BuildContext context, double value) {
    final width = MediaQuery.sizeOf(context).width;
    return value * (width / designWidth);
  }
}
