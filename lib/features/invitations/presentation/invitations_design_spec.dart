import 'package:flutter/material.dart';

class InvitationsDesignSpec {
  InvitationsDesignSpec._();

  static const double designWidth = 390;

  static const Color primary = Color(0xFFE5A024);
  static const Color freeTypeGreen = Color(0xFF2E7D32);
  static const Color guaranteedTypeGold = Color(0xFFE5A024);
  static const Color discountedTypePurple = Color(0xFF7B1FA2);
  static const Color screenBackground = Color(0xFFFFFFFF);
  static const Color titleText = Color(0xFF212121);
  static const Color bodyText = Color(0xFF757575);
  static const Color metaIcon = Color(0xFF9E9E9E);
  static const Color cardBorder = Color(0xFFEEEEEE);
  static const Color statusPending = Color(0xFFE5A024);
  static const Color acceptByAccent = Color(0xFFE5A024);
  static const Color statusConfirmed = Color(0xFF2E7D32);
  static const Color statusPendingDot = Color(0xFFE5A024);
  static const Color statusConfirmedDot = Color(0xFF4CAF50);
  static const Color attendanceConfirmedButton = Color(0xFFBDBDBD);
  static const Color cardShadow = Color(0x1A000000);
  static const Color rejectButtonBorder = Color(0xFFE57373);
  static const Color rejectButtonText = Color(0xFFD84343);
  static const Color envelopeIconBackground = Color(0xFFFFF3D6);
  static const Color filterLabelText = Color(0xFF757575);
  static const Color filterUnselectedBorder = Color(0xFFE0E0E0);
  static const Color filterUnselectedText = Color(0xFF616161);
  static const Color footerInfoBackground = Color(0xFFFFF8EB);
  static const Color vipBadgeBackground = Color(0xFF1A2B4A);
  static const Color generalBadgeBackground = Color(0xFF757575);
  static const Color viewQrButton = Color(0xFFE69D17);
  static const Color dialogBackground = Color(0xFFFFFBF2);
  static const Color dialogBorder = Color(0xFFFDE6B0);
  static const Color successGreen = Color(0xFF2E7D32);
  static const Color warningIconBackground = Color(0xFFFFF0D6);
  static const Color pendingStatusIconBackground = Color(0xFFFFF0D6);
  static const Color pendingStatusIcon = Color(0xFF8D6E2C);
  static const Color confirmedStatusIconBackground = Color(0xFFE8F5E9);
  static const Color confirmedStatusIcon = Color(0xFF2E7D32);

  static const double horizontalPadding = 20;
  static const double cardRadius = 16;
  static const double imageRadius = 12;
  static const double cardImageWidth = 120;

  static double scale(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / designWidth).clamp(0.85, 1.15);
  }

  static double px(BuildContext context, double designPixels) {
    return designPixels * scale(context);
  }
}
