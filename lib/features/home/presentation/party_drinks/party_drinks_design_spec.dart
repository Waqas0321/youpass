import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';

class PartyDrinksDesignSpec {
  PartyDrinksDesignSpec._();

  static const double designWidth = 390;

  static const Color gold = AppColors.homeAccentYellow;
  static const Color cardBackground = Color(0xFF000000);
  static const Color cardBorder = Color(0xFFD4AF37);
  static const Color subtitleText = Color(0xFFAAAAAA);
  static const Color volumeBadgeBorder = Color(0xFF5A5A5A);
  static const Color volumeBadgeText = Color(0xFFFFFFFF);
  static const Color checkoutSurface = Color(0xFF1A1A1A);
  static const Color checkoutIconCircle = Color(0xFF2A2A2A);
  static const Color checkoutCloseButton = Color(0xFF2A2A2A);
  static const Color checkoutMutedText = Color(0xFF9E9E9E);
  static const Color checkoutSubtitleText = Color(0xFFB3B3B3);
  static const Color checkoutDivider = Color(0xFF2A2A2A);
  static const Color checkoutPaymentBorder = Color(0xFF333333);
  static const Color checkoutItemCardBackground = Color(0xFF141414);
  static const Color checkoutItemCardBorder = Color(0xFF2A2A2A);

  static const double checkoutTopRadius = 28;
  static const double checkoutItemCardRadius = 14;
  static const double checkoutItemCardGap = 10;
  static const double checkoutItemImageSize = 56;
  static const double checkoutItemImageRadius = 10;
  static const double checkoutStepperHeight = 32;
  static const double checkoutPriceColumnWidth = 96;
  static const double checkoutCloseSize = 36;

  static const double horizontalPadding = 20;
  static const double categoryChipHeight = 44;
  static const double cornerRadius = 12;
  static const double stepperButtonRadius = 7;
  static const double volumeBadgeRadius = 4;
  static const double gridGap = 12;
  static const double gridChildAspectRatio = 0.58;

  static BorderRadius get borderRadius =>
      BorderRadius.circular(cornerRadius);

  static BorderRadius get stepperButtonBorderRadius =>
      BorderRadius.circular(stepperButtonRadius);

  static BorderRadius get volumeBadgeBorderRadius =>
      BorderRadius.circular(volumeBadgeRadius);

  static double scale(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / designWidth).clamp(0.85, 1.15);
  }

  static double px(BuildContext context, double designPixels) {
    return designPixels * scale(context);
  }
}
