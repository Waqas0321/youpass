import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
import 'package:youpass/features/home/presentation/models/drawer_menu_item.dart';
import 'package:youpass/l10n/app_localizations.dart';

class DrawerMenuFactory {
  DrawerMenuFactory._();

  static List<DrawerMenuItem> build(
    AppLocalizations l10n, {
    int invitationsBadgeCount = 0,
  }) {
    return [
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
        icon: Icons.auto_awesome_outlined,
        isHighlighted: true,
        badgeLabel: invitationsBadgeCount > 0
            ? AppStrings.drawerInvitationsNewBadge(
                l10n,
                invitationsBadgeCount,
              )
            : null,
      ),
    ];
  }
}
