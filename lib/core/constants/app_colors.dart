import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryMustard = Color(0xFFE5A83B);
  static const Color homeAccentYellow = Color(0xFFFFB800);
  static const Color darkNavy = Color(0xFF1A2B4A);
  static const Color homeBlack = Color(0xFF111111);
  static const Color secondaryGrey = Color(0xFF6B7280);
  static const Color lightGreyBorder = Color(0xFFD1D5DB);
  static const Color homeDividerGrey = Color(0xFFE5E7EB);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color curveAccent = Color(0xFFFFF8E7);
  static const Color linkBlue = Color(0xFF2563EB);
  static const Color whatsAppGreen = Color(0xFF25D366);
  static const Color scrimBase = Color(0xFF000000);
  static const Color homeTitleGradientOrange = Color(0xFFFF8A65);

  static const Color homeFeaturedPrimavera1 = Color(0xFF1A1035);
  static const Color homeFeaturedPrimavera2 = Color(0xFF3D1F5C);
  static const Color homeFeaturedPrimavera3 = Color(0xFF6B2D5C);
  static const List<Color> homeFeaturedPrimaveraGradient = [
    homeFeaturedPrimavera1,
    homeFeaturedPrimavera2,
    homeFeaturedPrimavera3,
  ];

  static const Color homeFeaturedSummer1 = Color(0xFF0F2B46);
  static const Color homeFeaturedSummer2 = Color(0xFF1E4D6B);
  static const Color homeFeaturedSummer3 = Color(0xFF2E6F8F);
  static const List<Color> homeFeaturedSummerGradient = [
    homeFeaturedSummer1,
    homeFeaturedSummer2,
    homeFeaturedSummer3,
  ];

  static const Color homeFeaturedUrban1 = Color(0xFF1F1F1F);
  static const Color homeFeaturedUrban2 = Color(0xFF4A2C2A);
  static const Color homeFeaturedUrban3 = Color(0xFF7A3E4D);
  static const List<Color> homeFeaturedUrbanGradient = [
    homeFeaturedUrban1,
    homeFeaturedUrban2,
    homeFeaturedUrban3,
  ];

  static const Color homeEventCaribe1 = Color(0xFF0E7490);
  static const Color homeEventCaribe2 = Color(0xFF22C55E);
  static const Color homeEventCaribe3 = Color(0xFF86EFAC);
  static const List<Color> homeEventCaribeGradient = [
    homeEventCaribe1,
    homeEventCaribe2,
    homeEventCaribe3,
  ];

  static const Color homeEventRock1 = Color(0xFF7F1D1D);
  static const Color homeEventRock2 = Color(0xFFDC2626);
  static const Color homeEventRock3 = Color(0xFFF97316);
  static const List<Color> homeEventRockGradient = [
    homeEventRock1,
    homeEventRock2,
    homeEventRock3,
  ];

  static const List<Color> homeFeaturedTitleGradient = [
    homeAccentYellow,
    homeTitleGradientOrange,
    backgroundWhite,
  ];

  static Color get homeCardScrimTop => scrimBase.withValues(alpha: 0.1);

  static Color get homeCardScrimBottom => scrimBase.withValues(alpha: 0.75);
}
