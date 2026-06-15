import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
import 'package:youpass/features/home/presentation/models/drawer_menu_item.dart';
import 'package:youpass/l10n/app_localizations.dart';

class DrawerMenuFactory {
  DrawerMenuFactory._();

  static List<DrawerMenuItem> build(AppLocalizations l10n) {
    return [
      DrawerMenuItem(
        id: DrawerMenuId.invitations,
        label: AppStrings.drawerInvitations(l10n),
        isHighlighted: true,
      ),
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
    ];
  }

  static DrawerMenuItem invitationsItem(AppLocalizations l10n) {
    return build(l10n).first;
  }

  static List<DrawerMenuItem> standardItems(AppLocalizations l10n) {
    final items = build(l10n);
    return items.sublist(1);
  }
}
