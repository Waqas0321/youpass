import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_product_kind.dart';

class InvitationsProductKindStyle {
  InvitationsProductKindStyle._();

  static const Color freeGreen = Color(0xFF2E7D32);
  static const Color guaranteedGold = Color(0xFFE5A024);
  static const Color discountedPurple = Color(0xFF7B1FA2);

  static Color colorFor(InvitationProductKind kind) {
    switch (kind) {
      case InvitationProductKind.free:
        return freeGreen;
      case InvitationProductKind.guaranteedPass:
        return guaranteedGold;
      case InvitationProductKind.discounted:
        return discountedPurple;
    }
  }

  static Color? parseHexColor(String? hex) {
    if (hex == null || hex.isEmpty) {
      return null;
    }
    final normalized = hex.replaceFirst('#', '');
    if (normalized.length != 6) {
      return null;
    }
    final value = int.tryParse(normalized, radix: 16);
    if (value == null) {
      return null;
    }
    return Color(0xFF000000 | value);
  }
}
