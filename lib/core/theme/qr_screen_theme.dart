import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

/// Semantic colors for QR / ticket confirmation screens in light and dark mode.
class QrScreenTheme {
  QrScreenTheme._();

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color accent(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : InvitationsDesignSpec.primary;

  static Color headline(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : InvitationsDesignSpec.titleText;

  static Color subtitle(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : InvitationsDesignSpec.bodyText;

  static Color footer(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : InvitationsDesignSpec.bodyText;

  static Color successIconBackground(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : const Color(0xFFFFF0D6);

  static Color successCheckColor(BuildContext context) => isDark(context)
      ? AppColors.scrimBase
      : InvitationsDesignSpec.primary;

  static Color burstPrimary(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : InvitationsDesignSpec.primary;

  static Color burstSecondary(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow.withValues(alpha: 0.65)
      : InvitationsDesignSpec.successGreen;

  static Color qrCardBackground(BuildContext context) => isDark(context)
      ? AppColors.scrimBase
      : AppColors.backgroundWhite;

  static Color qrCardBorder(BuildContext context) => accent(context);

  static Color qrModuleBackground(BuildContext context) => isDark(context)
      ? AppColors.scrimBase
      : AppColors.backgroundWhite;

  static Color qrModuleForeground(BuildContext context) => isDark(context)
      ? AppColors.backgroundWhite
      : AppColors.scrimBase;

  static Color qrDivider(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow.withValues(alpha: 0.55)
      : InvitationsDesignSpec.primary.withValues(alpha: 0.35);

  static Color manualIdLabel(BuildContext context) => isDark(context)
      ? AppColors.homeAccentYellow
      : InvitationsDesignSpec.bodyText;

  static Color manualIdValue(BuildContext context) => accent(context);

  static Color eventSummaryBackground(BuildContext context) => isDark(context)
      ? const Color(0xFF1A1A1A)
      : const Color(0xFFFFF8E8);

  static Color eventSummaryBorder(BuildContext context) => isDark(context)
      ? const Color(0xFF2A2A2A)
      : InvitationsDesignSpec.dialogBorder;

  static Color eventSummaryIconCircle(BuildContext context) => isDark(context)
      ? const Color(0xFF2A2210)
      : const Color(0xFFFFF0D6);

  static Color eventTitle(BuildContext context) => isDark(context)
      ? AppColors.backgroundWhite
      : InvitationsDesignSpec.titleText;

  static Color eventMeta(BuildContext context) => isDark(context)
      ? AppColors.secondaryGrey
      : InvitationsDesignSpec.bodyText;
}
