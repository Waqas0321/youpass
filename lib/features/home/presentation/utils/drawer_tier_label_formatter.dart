import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/home/domain/entities/drawer_membership_tier.dart';
import 'package:youpass/l10n/app_localizations.dart';

class DrawerTierLabelFormatter {
  DrawerTierLabelFormatter._();

  static String label(AppLocalizations l10n, DrawerMembershipTier tier) {
    switch (tier) {
      case DrawerMembershipTier.gold:
        return AppStrings.drawerTierGold(l10n);
      case DrawerMembershipTier.silver:
        return AppStrings.drawerTierSilver(l10n);
      case DrawerMembershipTier.platinum:
        return AppStrings.drawerTierPlatinum(l10n);
      case DrawerMembershipTier.bronze:
        return AppStrings.drawerTierBronze(l10n);
    }
  }
}
