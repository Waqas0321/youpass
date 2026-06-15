enum DrawerMembershipTier {
  bronze,
  silver,
  gold,
  platinum,
}

extension DrawerMembershipTierMapper on DrawerMembershipTier {
  static DrawerMembershipTier fromCategory(String? category) {
    switch (category?.toLowerCase()) {
      case 'gold':
        return DrawerMembershipTier.gold;
      case 'silver':
        return DrawerMembershipTier.silver;
      case 'platinum':
        return DrawerMembershipTier.platinum;
      default:
        return DrawerMembershipTier.bronze;
    }
  }
}
