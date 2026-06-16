import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

/// Semantic colors for the My Tickets screen in light and dark mode.
class TicketsScreenTheme {
  TicketsScreenTheme._();

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color accent(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : TicketsDesignSpec.primary;

  static Color title(BuildContext context) =>
      YouPassThemedColors.primaryText(context);

  static Color body(BuildContext context) =>
      YouPassThemedColors.secondaryText(context);

  static Color metaIcon(BuildContext context) => body(context);

  static Color cardBackground(BuildContext context) =>
      YouPassThemeExtension.of(context).cardBackground;

  static Color cardBorder(BuildContext context) =>
      YouPassThemeExtension.of(context).cardBorder;

  static Color divider(BuildContext context) => isDark(context)
      ? const Color(0xFF2A2A2A)
      : TicketsDesignSpec.divider;

  static Color sectionIconBackground(BuildContext context) =>
      YouPassThemeExtension.of(context).profileIconBadgeBackground;

  static Color outlineButtonFill(BuildContext context) =>
      YouPassThemeExtension.of(context).outlineButtonFill;

  static Color outlineButtonBorder(BuildContext context) =>
      YouPassThemeExtension.of(context).outlineButtonBorder;

  static Color outlineButtonForeground(BuildContext context) =>
      YouPassThemeExtension.of(context).outlineButtonForeground;

  static Color activeBadgeBackground(BuildContext context) => accent(context);

  static Color activeBadgeText(BuildContext context) => isDark(context)
      ? AppColors.scrimBase
      : AppColors.backgroundWhite;

  static Color vipButtonBackground(BuildContext context) =>
      TicketsDesignSpec.vipButton;

  static Color vipAssignAccent(BuildContext context) =>
      TicketsDesignSpec.vipAssignAccent;

  /// Accent for assign-ticket flow: green for VIP, yellow for general.
  static Color assignFlowAccent(BuildContext context, {required bool isVip}) =>
      isVip ? vipAssignAccent(context) : TicketsDesignSpec.primary;

  static Color favoriteActive(BuildContext context) =>
      TicketsDesignSpec.favoriteActive;

  static Color favoriteToggleBackground(BuildContext context) => isDark(context)
      ? const Color(0xE61A1A1A)
      : const Color(0xEBFFFFFF);

  static Color favoriteToggleIcon(BuildContext context) => isDark(context)
      ? AppColors.backgroundWhite
      : TicketsDesignSpec.metaIcon;

  static List<BoxShadow> cardShadow(BuildContext context) {
    if (isDark(context)) {
      return const [];
    }

    return const [
      BoxShadow(
        color: TicketsDesignSpec.cardShadow,
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ];
  }
}
