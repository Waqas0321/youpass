import 'package:flutter/material.dart';

/// Colors and dimensions from the Mi Perfil header card mockup (390×844).
class ProfileDesignSpec {
  ProfileDesignSpec._();

  static const double designWidth = 390;

  static const Color primary = Color(0xFFE69D17);
  static const Color cardBackground = Color(0xFFFFFBF2);
  static const Color cardBorder = Color(0xFFFDE6B0);
  static const Color cardWave1 = Color(0xFFFFF5E6);
  static const Color cardWave2 = Color(0xFFFFEFD8);
  static const Color cardWave3 = Color(0xFFFFE9CC);
  static const Color avatarRing = Color(0xFFE69D17);
  static const Color avatarInner = Color(0xFFFFFFFF);
  static const Color avatarIcon = Color(0xFFE69D17);
  static const Color cameraBadgeBackground = Color(0xFFFFFFFF);
  static const Color cameraIcon = Color(0xFFE69D17);
  static const Color cameraBadgeRing = Color(0xFFFFFFFF);
  static const Color valueText = Color(0xFF212121);
  static const Color labelText = Color(0xFF757575);
  static const Color phoneIcon = Color(0xFF757575);
  static const Color divider = Color(0xFFE8E8E8);
  static const Color rowDivider = Color(0xFFEEEEEE);
  static const Color iconCircleBackground = Color(0xFFFFF0D6);
  static const Color sectionDividerOrange = Color(0xFFFDE6B0);
  static const Color editButtonFill = Color(0xFFFFFBF0);
  static const Color screenBackground = Color(0xFFFFFFFF);
  static const Color tierBadge = Color(0xFFE69D17);

  static const double horizontalPadding = 20;
  static const double appBarTitleSize = 18;
  static const double backIconSize = 24;

  static const double cardRadius = 20;
  static const double cardBorderWidth = 1;
  static const double cardPaddingHorizontal = 20;
  static const double cardPaddingTop = 22;
  static const double cardPaddingBottom = 20;
  static const double cardWaveWidth = 140;
  static const double cardWaveHeight = 130;

  static const double avatarOuterSize = 92;
  static const double avatarRingWidth = 2;
  static const double avatarRingGap = 4;
  static const double avatarWhiteBorderWidth = 3;
  static const double avatarIconSize = 46;
  static const double cameraBadgeSize = 30;
  static const double cameraIconSize = 15;

  static const double nameFontSize = 18;
  static const double phoneFontSize = 14;
  static const double phoneIconSize = 16;
  static const double nameToPhoneGap = 8;
  static const double phoneToDividerGap = 16;
  static const double dividerHorizontalInset = 0;
  static const double dividerToBadgeGap = 16;
  static const double badgeToBenefitsGap = 12;
  static const double benefitsFontSize = 14;
  static const double benefitsChevronSize = 18;

  static const double tierBadgePaddingH = 14;
  static const double tierBadgePaddingV = 6;
  static const double tierBadgeRadius = 8;
  static const double tierIconSize = 14;
  static const double tierFontSize = 12;

  static const double sectionHeaderIconCircleSize = 36;
  static const double sectionHeaderIconInnerSize = 18;
  static const double sectionHeaderFontSize = 13;
  static const double sectionHeaderGap = 10;
  static const double sectionHeaderBottomGap = 12;

  static const double infoIconCircleSize = 40;
  static const double infoIconInnerSize = 20;
  static const double infoIconToTextGap = 14;
  static const double infoLabelFontSize = 12;
  static const double infoValueFontSize = 15;
  static const double infoLabelToValueGap = 4;
  static const double infoRowPaddingVertical = 16;

  static const double editButtonRadius = 28;
  static const double editButtonBorderWidth = 1;
  static const double editButtonPaddingVertical = 14;
  static const double editButtonIconSize = 18;
  static const double editButtonFontSize = 14;
  static const double editButtonTopGap = 12;

  static const double cardToSectionGap = 24;
  static const double sectionToNextGap = 28;

  static double scale(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / designWidth).clamp(0.85, 1.15);
  }

  static double px(BuildContext context, double designPixels) {
    return designPixels * scale(context);
  }
}
