import 'package:flutter/material.dart';

class VipVenueDesignSpec {
  VipVenueDesignSpec._();

  static const double designWidth = 390;

  static const Color zoneAvailable = Color(0xFF4CAF50);
  static const Color zonePremium = Color(0xFFE91E8C);
  static const Color zoneSold = Color(0xFF7B1FA2);
  static const Color tableAvailable = Color(0xFF76B947);
  static const Color tableSelected = Color(0xFFFF9800);
  static const Color tableSold = Color(0xFFE53935);
  static const Color tablePremium = Color(0xFFE91E8C);
  static const Color summaryCardBackground = Color(0xFFFFF6E8);
  static const Color hintCardBackground = Color(0xFFFFFBF2);
  static const Color hintCardBody = Color(0xFF8A7A62);
  static const Color stepperBarBackground = Color(0xFFFFF6E8);

  static const double horizontalPadding = 20;
  static const double cardRadius = 16;

  static double scale(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / designWidth).clamp(0.85, 1.15);
  }

  static double px(BuildContext context, double designPixels) {
    return designPixels * scale(context);
  }
}
