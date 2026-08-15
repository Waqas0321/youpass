import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
import 'package:youpass/features/home/presentation/models/drawer_menu_item.dart';
import 'package:youpass/l10n/app_localizations.dart';

class DrawerMenuFactory {
  DrawerMenuFactory._();

  static DrawerMenuItem homeItem(AppLocalizations l10n) {
    return DrawerMenuItem(
      id: DrawerMenuId.home,
      label: AppStrings.drawerHome(l10n),
      icon: Icons.home_outlined,
    );
  }

  static List<DrawerMenuItem> build(AppLocalizations l10n) {
    return [
      homeItem(l10n),
      DrawerMenuItem(
        id: DrawerMenuId.profile,
        label: AppStrings.drawerMyProfile(l10n),
        icon: Icons.person_outline,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.tickets,
        label: AppStrings.drawerMyTickets(l10n),
        icon: Icons.confirmation_number_outlined,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.favorites,
        label: AppStrings.drawerMyFavorites(l10n),
        icon: Icons.favorite_border,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.invitations,
        label: AppStrings.drawerInvitations(l10n),
        isHighlighted: true,
      ),
    ];
  }

  static DrawerMenuItem invitationsItem(AppLocalizations l10n) {
    return build(l10n).firstWhere((item) => item.id == DrawerMenuId.invitations);
  }

  static List<DrawerMenuItem> partyModeItems(AppLocalizations l10n) {
    return [
      DrawerMenuItem(
        id: DrawerMenuId.drinkMenu,
        label: AppStrings.drawerDrinkMenu(l10n),
        icon: Icons.local_bar_outlined,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.myPurchases,
        label: AppStrings.drawerMyPurchases(l10n),
        icon: Icons.shopping_bag_outlined,
      ),
      DrawerMenuItem(
        id: DrawerMenuId.cortesias,
        label: AppStrings.invitationsFilterCourtesy(l10n),
        isHighlighted: true,
      ),
    ];
  }

  static DrawerMenuItem cortesiasItem(AppLocalizations l10n) {
    return partyModeItems(l10n).firstWhere((item) => item.id == DrawerMenuId.cortesias);
  }

  static List<DrawerMenuItem> standardItems(AppLocalizations l10n) {
    return build(l10n)
        .where(
          (item) =>
              item.id != DrawerMenuId.home && item.id != DrawerMenuId.invitations,
        )
        .toList();
  }
}
