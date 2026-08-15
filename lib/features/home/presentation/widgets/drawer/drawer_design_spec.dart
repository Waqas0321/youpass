import 'package:flutter/material.dart';

/// Pixel values and colors from the YouPass drawer mockup (390×844 design frame).
class DrawerDesignSpec {
  DrawerDesignSpec._();

  static const double designWidth = 390;

  // Brand / accents (mockup)
  static const Color gold = Color(0xFFE5A024);
  static const Color goldSparkleSecondary = Color(0xFFF0B84A);

  // Profile header card (mockup crop)
  static const Color profileBackground = Color(0xFFF9D189);
  static const Color profileWaveBand1 = Color(0xFFFAD59A);
  static const Color profileWaveBand2 = Color(0xFFF8D092);
  static const Color profileWaveBand3 = Color(0xFFF5C878);
  static const Color profileWaveBand4 = Color(0xFFF2C070);
  static const Color tierBadgeBackground = Color(0xFFEBB04D);
  static const Color profileName = Color(0xFF000000);

  // Menu
  static const Color menuTitle = Color(0xFF000000);
  static const Color menuBorder = Color(0xFFEDEDED);
  static const Color menuTileBackground = Color(0xFFFFFFFF);
  static const Color invitationsBackground = Color(0xFFFFF8EB);
  static const Color invitationsTitle = Color(0xFFE5A024);
  static const Color invitationsBadgeBackground = Color(0xFFFFE5C8);
  static const Color invitationsBadgeText = Color(0xFFE8873A);

  // Avatar
  static const Color avatarBackground = Color(0xFFFFFFFF);
  static const Color avatarIcon = Color(0xFFF9D189);

  static const Color screenBackground = Color(0xFFFFFFFF);

  // Dark drawer panel (Section 9.1)
  static const Color drawerPanelBackground = Color(0xFF1A2B4A);
  static const Color drawerScrimColor = Color(0xB3000000);
  static const double drawerWidthFactor = 0.78;
  static const Color drawerMenuTileOnDark = Color(0xFF243B5C);
  static const Color drawerMenuTitleOnDark = Color(0xFFFFFFFF);
  static const Color drawerMenuBorderOnDark = Color(0xFF2E4A6E);

  // Layout (px @ 390w)
  static const double horizontalPadding = 16;
  static const double headerTopPadding = 16;
  static const double headerBottomPadding = 24;
  static const double headerHeight = 56;
  static const double backIconSize = 24;
  static const double logoFontSize = 32;
  static const double logoRegFontSize = 10;
  static const double logoRegOffsetY = -10;

  static const double profileCardRadius = 20;
  static const double profileCardPaddingHorizontal = 18;
  static const double profileCardPaddingVertical = 18;
  static const double profileCardMinHeight = 104;
  static const double profileWaveWidth = 150;

  static const double avatarSize = 64;
  static const double avatarRingWidth = 1.25;
  static const double avatarIconSize = 40;
  static const double avatarToNameGap = 14;
  static const double nameFontSize = 20;
  static const double nameToBadgeGap = 8;

  static const double tierBadgePaddingHorizontal = 10;
  static const double tierBadgePaddingVertical = 5;
  static const double tierBadgeRadius = 20;
  static const double tierIconSize = 13;
  static const double tierFontSize = 12;
  static const double tierLetterSpacing = 0.4;

  static const double profileToMenuGap = 16;
  static const double menuTileRadius = 12;
  static const double menuTilePaddingHorizontal = 16;
  static const double menuTilePaddingVertical = 14;
  static const double menuTileGap = 12;
  static const double menuIconSize = 22;
  static const double menuIconToTextGap = 12;
  static const double menuTitleFontSize = 15;
  static const double invitationsMenuTitleFontSize = 17;
  static const double invitationsTilePaddingVertical = 16;
  static const double menuChevronSize = 20;

  static const double sparkleSlotWidth = 28;
  static const double sparkleLarge = 18;
  static const double sparkleSmall = 14;
  static const double sparkleOffsetX = 10;
  static const double sparkleOffsetY = 6;

  static const double badgePaddingHorizontal = 8;
  static const double badgePaddingVertical = 4;
  static const double badgeFontSize = 11;
  static const double badgeRadius = 10;
  static const double badgeToChevronGap = 8;
  static const double invitationsBadgeDiameter = 22;
  static const double invitationsBadgeFontSize = 11;
  static const Color invitationsBadgeFill = Color(0xFFE8873A);
  static const Color invitationsBadgeTextOnFill = Color(0xFFFFFFFF);

  static double scale(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / designWidth).clamp(0.85, 1.15);
  }

  static double px(BuildContext context, double designPixels) {
    return designPixels * scale(context);
  }
}
