import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/domain/entities/drawer_membership_tier.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_tier_theme.dart';

void main() {
  group('DrawerMembershipTierMapper', () {
    test('maps profile categories to tiers', () {
      expect(
        DrawerMembershipTierMapper.fromCategory('gold'),
        DrawerMembershipTier.gold,
      );
      expect(
        DrawerMembershipTierMapper.fromCategory('silver'),
        DrawerMembershipTier.silver,
      );
      expect(
        DrawerMembershipTierMapper.fromCategory('platinum'),
        DrawerMembershipTier.platinum,
      );
      expect(
        DrawerMembershipTierMapper.fromCategory('bronze'),
        DrawerMembershipTier.bronze,
      );
      expect(
        DrawerMembershipTierMapper.fromCategory(null),
        DrawerMembershipTier.bronze,
      );
    });
  });

  group('DrawerProfileTierTheme', () {
    test('provides platinum iridescent border', () {
      final theme = DrawerProfileTierTheme.forTier(DrawerMembershipTier.platinum);

      expect(theme.outerBorderGradient, isNotNull);
      expect(theme.outerBorderWidth, greaterThan(0));
    });

    test('uses tier-specific badge colours', () {
      final bronze = DrawerProfileTierTheme.forTier(DrawerMembershipTier.bronze);
      final gold = DrawerProfileTierTheme.forTier(DrawerMembershipTier.gold);

      expect(bronze.badgeBackground, DrawerProfileTierTheme.bronzeBase);
      expect(gold.badgeBackground, DrawerProfileTierTheme.goldBase);
      expect(bronze.badgeBackground, isNot(gold.badgeBackground));
    });
  });
}
