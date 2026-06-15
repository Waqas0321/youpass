import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';

class VipVenueScreenTheme {
  VipVenueScreenTheme._();

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static const Color brandGold = Color(0xFFE5A906);
  static const Color brandButtonText = Color(0xFF0F0F14);

  static Color accent(BuildContext context) => brandGold;

  static Color screenBackground(BuildContext context) =>
      YouPassThemedColors.screenBackground(context);

  static Color title(BuildContext context) =>
      YouPassThemedColors.primaryText(context);

  static Color body(BuildContext context) =>
      YouPassThemedColors.secondaryText(context);

  static Color muted(BuildContext context) => isDark(context)
      ? const Color(0xFF757575)
      : AppColors.profileLabelGrey;

  static Color cardBackground(BuildContext context) =>
      YouPassThemeExtension.of(context).cardBackground;

  static Color cardBorder(BuildContext context) =>
      YouPassThemeExtension.of(context).cardBorder;

  static Color mapBackground(BuildContext context) => isDark(context)
      ? const Color(0xFF252525)
      : const Color(0xFFF3F3F3);

  static Color primaryButtonForeground(BuildContext context) => brandButtonText;

  static Color dialogBackground(BuildContext context) =>
      Theme.of(context).dialogTheme.backgroundColor ??
      Theme.of(context).colorScheme.surface;

  static Color accentSurface(BuildContext context) =>
      accent(context).withValues(alpha: isDark(context) ? 0.15 : 0.12);

  static Color summaryCardBackground(BuildContext context) => isDark(context)
      ? const Color(0xFF2A2418)
      : VipVenueDesignSpec.summaryCardBackground;

  static Color hintCardBackground(BuildContext context) => isDark(context)
      ? const Color(0xFF2A2418)
      : VipVenueDesignSpec.hintCardBackground;

  static Color hintCardBody(BuildContext context) => isDark(context)
      ? const Color(0xFFB8A88E)
      : VipVenueDesignSpec.hintCardBody;

  static Color stepperBarBackground(BuildContext context) => isDark(context)
      ? const Color(0xFF2A2418)
      : VipVenueDesignSpec.stepperBarBackground;

  static Color stepperButtonBackground(BuildContext context) => isDark(context)
      ? const Color(0xFF3A3A3A)
      : const Color(0xFFE8E8E8);

  static List<BoxShadow> cardShadow(BuildContext context) {
    if (isDark(context)) {
      return const [];
    }

    return const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ];
  }

  static Color zoneAvailable(BuildContext context) =>
      VipVenueDesignSpec.zoneAvailable;

  static Color zonePremium(BuildContext context) =>
      VipVenueDesignSpec.zonePremium;

  static Color zoneSold(BuildContext context) => VipVenueDesignSpec.zoneSold;

  static Color tableAvailable(BuildContext context) =>
      VipVenueDesignSpec.tableAvailable;

  static Color tableSelected(BuildContext context) =>
      VipVenueDesignSpec.tableSelected;

  static Color tableSold(BuildContext context) =>
      VipVenueDesignSpec.tableSold;

  static Color tablePremium(BuildContext context) =>
      VipVenueDesignSpec.tablePremium;

  static Color zoneLabelText(BuildContext context) => isDark(context)
      ? Colors.white
      : AppColors.homeBlack;
}
