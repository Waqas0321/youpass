import 'package:flutter/material.dart';

class FavoritesDesignSpec {
  FavoritesDesignSpec._();

  static const double designWidth = 390;

  static const Color primary = Color(0xFFE69D17);
  static const Color buyAccent = Color(0xFFE91E8C);
  static const Color screenBackground = Color(0xFFFFFFFF);
  static const Color titleText = Color(0xFF212121);
  static const Color bodyText = Color(0xFF757575);
  static const Color metaIcon = Color(0xFF9E9E9E);
  static const Color divider = Color(0xFFE8E8E8);
  static const Color chipBorder = Color(0xFFE0E0E0);
  static const Color chipText = Color(0xFF757575);
  static const Color favoriteActive = Color(0xFFE53935);
  static const Color searchFill = Color(0xFFF5F5F5);
  static const Color searchBorder = Color(0xFFE8E8E8);
  static const Color cardBorder = Color(0xFFEEEEEE);
  static const Color sectionIconBackground = Color(0xFFFFF0D6);
  static const Color chipSelectedFill = Color(0xFFE69D17);
  static const Color chipSelectedText = Color(0xFFFFFFFF);

  static const double horizontalPadding = 20;
  static const double backIconSize = 24;
  static const double appBarSubtitleSize = 12;
  static const double cardRadius = 16;
  static const double imageRadius = 12;

  static double scale(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / designWidth).clamp(0.85, 1.15);
  }

  static double px(BuildContext context, double designPixels) {
    return designPixels * scale(context);
  }
}
