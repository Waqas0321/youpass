import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

/// Semantic colors for the Invitations screen in light and dark mode.
class InvitationsScreenTheme {
  InvitationsScreenTheme._();

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color accent(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : InvitationsDesignSpec.primary;

  static Color title(BuildContext context) =>
      YouPassThemedColors.primaryText(context);

  static Color body(BuildContext context) =>
      YouPassThemedColors.secondaryText(context);

  static Color cardBackground(BuildContext context) =>
      YouPassThemeExtension.of(context).cardBackground;

  static Color cardBorder(BuildContext context) =>
      YouPassThemeExtension.of(context).cardBorder;

  static Color outlineButtonFill(BuildContext context) =>
      YouPassThemeExtension.of(context).outlineButtonFill;

  static Color outlineButtonBorder(BuildContext context) =>
      YouPassThemeExtension.of(context).outlineButtonBorder;

  static Color outlineButtonForeground(BuildContext context) =>
      YouPassThemeExtension.of(context).outlineButtonForeground;

  static Color sectionIconBackground(BuildContext context) =>
      YouPassThemeExtension.of(context).profileIconBadgeBackground;

  static Color footerNoteBackground(BuildContext context) => isDark(context)
      ? const Color(0xFF2A2210)
      : InvitationsDesignSpec.footerInfoBackground;

  static Color disabledButtonBackground(BuildContext context) => isDark(context)
      ? const Color(0xFF3A3A3A)
      : InvitationsDesignSpec.attendanceConfirmedButton;

  static Color disabledButtonForeground(BuildContext context) => isDark(context)
      ? AppColors.backgroundWhite
      : AppColors.backgroundWhite;

  static Color confirmedStatusIconBackground(BuildContext context) =>
      isDark(context)
          ? const Color(0xFF1B3A24)
          : InvitationsDesignSpec.confirmedStatusIconBackground;

  static Color pendingStatusIconBackground(BuildContext context) =>
      isDark(context)
          ? const Color(0xFF2A2210)
          : InvitationsDesignSpec.pendingStatusIconBackground;

  static List<BoxShadow> cardShadow(BuildContext context) {
    if (isDark(context)) {
      return const [];
    }

    return const [
      BoxShadow(
        color: InvitationsDesignSpec.cardShadow,
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ];
  }
}
