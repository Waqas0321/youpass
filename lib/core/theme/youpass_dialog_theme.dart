import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

/// Semantic colors for modal dialogs in light and dark mode.
class YouPassDialogTheme {
  YouPassDialogTheme._();

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color background(BuildContext context) => isDark(context)
      ? const Color(0xFF1A1A1A)
      : InvitationsDesignSpec.dialogBackground;

  static Color border(BuildContext context) => isDark(context)
      ? const Color(0xFF2A2A2A)
      : InvitationsDesignSpec.dialogBorder;

  static Color title(BuildContext context) =>
      YouPassThemedColors.primaryText(context);

  static Color body(BuildContext context) =>
      YouPassThemedColors.secondaryText(context);

  static Color iconBadgeBackground(BuildContext context) => isDark(context)
      ? const Color(0xFF2A2210)
      : InvitationsDesignSpec.warningIconBackground;

  static Color iconColor(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : InvitationsDesignSpec.primary;

  static Color successIconBadgeBackground(BuildContext context) =>
      isDark(context) ? const Color(0xFF1B3A1F) : const Color(0xFFE8F5E9);

  static Color successIconColor(BuildContext context) => isDark(context)
      ? const Color(0xFF66BB6A)
      : InvitationsDesignSpec.successGreen;

  static Color successTitle(BuildContext context) => successIconColor(context);

  static Color infoPanelBackground(BuildContext context) => isDark(context)
      ? const Color(0xFF2A2210)
      : InvitationsDesignSpec.footerInfoBackground;

  static Color infoPanelText(BuildContext context) => isDark(context)
      ? const Color(0xFFE8E8E8)
      : InvitationsDesignSpec.titleText;

  static Color infoPanelIcon(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : InvitationsDesignSpec.primary;

  static Color primaryButtonBackground(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : InvitationsDesignSpec.primary;

  static Color primaryButtonForeground(BuildContext context) => isDark(context)
      ? AppColors.scrimBase
      : AppColors.backgroundWhite;

  static Color destructiveIconBackground(BuildContext context) =>
      AppColors.profileDeleteRed.withValues(alpha: isDark(context) ? 0.2 : 0.12);

  static Color cancelText(BuildContext context) => body(context);
}
