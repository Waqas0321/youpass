import 'package:flutter/material.dart';
import 'package:youpass/features/home/domain/entities/drawer_membership_tier.dart';

class DrawerProfileTierTheme {
  const DrawerProfileTierTheme({
    required this.backgroundGradient,
    required this.nameColor,
    required this.chevronColor,
    required this.badgeBackground,
    required this.badgeTextColor,
    required this.badgeIconColor,
    required this.avatarRingColor,
    required this.avatarPlaceholderBackground,
    required this.avatarPlaceholderIconColor,
    required this.avatarInitialColor,
    required this.splashColor,
    required this.highlightColor,
    this.outerBorderGradient,
    this.outerBorderWidth = 0,
  });

  final Gradient backgroundGradient;
  final Color nameColor;
  final Color chevronColor;
  final Color badgeBackground;
  final Color badgeTextColor;
  final Color badgeIconColor;
  final Color avatarRingColor;
  final Color avatarPlaceholderBackground;
  final Color avatarPlaceholderIconColor;
  final Color avatarInitialColor;
  final Color splashColor;
  final Color highlightColor;
  final Gradient? outerBorderGradient;
  final double outerBorderWidth;

  static const Color bronzeBase = Color(0xFFB87333);
  static const Color silverBase = Color(0xFFC0C0C0);
  static const Color goldBase = Color(0xFFE5A906);
  static const Color platinumBase = Color(0xFFE5E4E2);

  static DrawerProfileTierTheme forTier(DrawerMembershipTier tier) {
    switch (tier) {
      case DrawerMembershipTier.bronze:
        return const DrawerProfileTierTheme(
          backgroundGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0x1AB87333),
              Color(0x08B87333),
              Color(0x03B87333),
            ],
            stops: [0.0, 0.55, 1.0],
          ),
          nameColor: Color(0xFF6B4423),
          chevronColor: Color(0x996B4423),
          badgeBackground: Color(0xFFB87333),
          badgeTextColor: Color(0xFFFFFFFF),
          badgeIconColor: Color(0xFFFFFFFF),
          avatarRingColor: Color(0xFFB87333),
          avatarPlaceholderBackground: Color(0xFFFFFFFF),
          avatarPlaceholderIconColor: Color(0x4DB87333),
          avatarInitialColor: Color(0xFF6B4423),
          splashColor: Color(0x1AB87333),
          highlightColor: Color(0x0DB87333),
        );
      case DrawerMembershipTier.silver:
        return const DrawerProfileTierTheme(
          backgroundGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0x26C0C0C0),
              Color(0x12C0C0C0),
              Color(0x06C0C0C0),
            ],
            stops: [0.0, 0.55, 1.0],
          ),
          nameColor: Color(0xFF5A5A5A),
          chevronColor: Color(0x995A5A5A),
          badgeBackground: Color(0xFF9E9E9E),
          badgeTextColor: Color(0xFFFFFFFF),
          badgeIconColor: Color(0xFFFFFFFF),
          avatarRingColor: Color(0xFFC0C0C0),
          avatarPlaceholderBackground: Color(0x26C0C0C0),
          avatarPlaceholderIconColor: Color(0x66C0C0C0),
          avatarInitialColor: Color(0xFF5A5A5A),
          splashColor: Color(0x33C0C0C0),
          highlightColor: Color(0x1AC0C0C0),
        );
      case DrawerMembershipTier.gold:
        return const DrawerProfileTierTheme(
          backgroundGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0x33E5A906),
              Color(0x1AE5A906),
              Color(0x0CE5A906),
            ],
            stops: [0.0, 0.55, 1.0],
          ),
          nameColor: Color(0xFF8B6914),
          chevronColor: Color(0x998B6914),
          badgeBackground: Color(0xFFE5A906),
          badgeTextColor: Color(0xFF3D2E00),
          badgeIconColor: Color(0xFF3D2E00),
          avatarRingColor: Color(0xFFE5A906),
          avatarPlaceholderBackground: Color(0x33E5A906),
          avatarPlaceholderIconColor: Color(0x66E5A906),
          avatarInitialColor: Color(0xFF8B6914),
          splashColor: Color(0x33E5A906),
          highlightColor: Color(0x1AE5A906),
        );
      case DrawerMembershipTier.platinum:
        return DrawerProfileTierTheme(
          backgroundGradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFF8F8FC),
              Color(0xFFF0F4FF),
            ],
            stops: [0.0, 0.45, 1.0],
          ),
          nameColor: const Color(0xFF2C2C34),
          chevronColor: const Color(0x992C2C34),
          badgeBackground: const Color(0xFFE5E4E2),
          badgeTextColor: const Color(0xFF3A3A44),
          badgeIconColor: const Color(0xFF5C5C68),
          avatarRingColor: const Color(0xFFB8B8C8),
          avatarPlaceholderBackground: const Color(0xFFF4F4F8),
          avatarPlaceholderIconColor: const Color(0x66B8B8C8),
          avatarInitialColor: const Color(0xFF3A3A44),
          splashColor: const Color(0x33B8B8C8),
          highlightColor: const Color(0x1AB8B8C8),
          outerBorderGradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB8C6FF),
              Color(0xFFFFB8E8),
              Color(0xFFB8FFE8),
              Color(0xFFFFE8B8),
              Color(0xFFD8B8FF),
            ],
          ),
          outerBorderWidth: 1.5,
        );
    }
  }
}
