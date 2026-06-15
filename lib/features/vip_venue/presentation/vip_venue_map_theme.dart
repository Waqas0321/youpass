import 'package:flutter/material.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';

/// Figma-accurate colors for the YouFest venue map card.
class VipVenueMapTheme {
  VipVenueMapTheme._();

  static const Color neonPink = Color(0xFFFF007F);
  static const Color neonGreen = Color(0xFF39FF14);
  static const Color neonPurple = Color(0xFF7B2CBF);
  static const Color mapBlack = Color(0xFF0A0A0A);
  static const Color mapInnerBlack = Color(0xFF111111);
  static const Color danceFloorPurple = Color(0xFF4A148C);
  static const Color danceFloorPurpleDark = Color(0xFF1A0828);

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color mapFrameBorder(BuildContext context) => neonPink;

  static Color mapCanvasBackground(BuildContext context) => isDark(context)
      ? mapBlack
      : const Color(0xFF1A1A1A);

  static Color legendLabel(BuildContext context) => isDark(context)
      ? Colors.white.withValues(alpha: 0.85)
      : VipVenueScreenTheme.body(context);

  static Color zoneLabelText(BuildContext context) => Colors.white;

  static Color emergencyExitBorder(BuildContext context) =>
      Colors.white.withValues(alpha: 0.55);

  static Color stageBorder(BuildContext context) =>
      Colors.white.withValues(alpha: 0.85);

  static const Color tableDistributionCanvas = Color(0xFF0A0A0A);
  static const Color tableDistributionStageBar = Color(0xFF1E1E1E);
  static const Color tableAvailable = VipVenueDesignSpec.tableAvailable;
  static const Color tablePremium = VipVenueDesignSpec.tablePremium;
  static const Color tableSelected = VipVenueDesignSpec.tableSelected;
  static const Color tableOccupied = VipVenueDesignSpec.tableSold;
  static const Color tableBlocked = VipVenueDesignSpec.tableBlocked;
  static const Color tableDistributionTitleText = Colors.white;
  static const Color tableDistributionStageText = Colors.white;
}
