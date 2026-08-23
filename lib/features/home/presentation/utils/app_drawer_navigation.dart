import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/home_drawer_widget.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/home/presentation/utils/party_mode_navigation.dart';
import 'package:youpass/routes/app_routes.dart';
class AppDrawerNavigation {
  AppDrawerNavigation._();
  static Widget buildDrawer(
    BuildContext context, {
    required ValueChanged<DrawerMenuId> onMenuSelected,
  }) {
  final invitationsProvider = context.watch<InvitationsProvider>();

    return HomeDrawerWidget(
      invitationsBadgeCount: invitationsProvider.invitationsBadgeCount,
      onMenuSelected: onMenuSelected,
    );
  }
  static void openDrawer(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    context.read<InvitationsProvider>().refreshDrawerBadge();
    scaffoldKey.currentState?.openDrawer();
  }

  static Widget menuIconButton({
    required BuildContext context,
    required GlobalKey<ScaffoldState> scaffoldKey,
    Color? iconColor,
    double iconSize = 24,
  }) {
    return IconButton(
      onPressed: () => openDrawer(context, scaffoldKey),
      icon: Icon(
        Icons.menu,
        color: iconColor ?? AppColors.homeAccentYellow,
        size: iconSize,
      ),
    );
  }
  static void goBackToHome(BuildContext context) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
      return;
    }
    navigator.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
  }

  static void handleMenuSelected(BuildContext context, DrawerMenuId menuId) {
    void navigate() {
      if (!context.mounted) {
        return;
      }
      switch (menuId) {
        case DrawerMenuId.home:
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.home,
            (route) => false,
          );
        case DrawerMenuId.profile:
          if (ModalRoute.of(context)?.settings.name != AppRoutes.profile) {
            Navigator.of(context).pushNamed(AppRoutes.profile);
          }
        case DrawerMenuId.tickets:
          if (ModalRoute.of(context)?.settings.name != AppRoutes.myTickets) {
            Navigator.of(context).pushNamed(AppRoutes.myTickets);
          }
        case DrawerMenuId.favorites:
          if (ModalRoute.of(context)?.settings.name != AppRoutes.myFavorites) {
            Navigator.of(context).pushNamed(AppRoutes.myFavorites);
          }
        case DrawerMenuId.invitations:
          _navigateTo(context, AppRoutes.myInvitations);
        case DrawerMenuId.drinkMenu:
          unawaited(_openDrinkMenuFromDrawer(context));
        case DrawerMenuId.myPurchases:
          _navigateTo(context, AppRoutes.partyDrinkPurchases);
        case DrawerMenuId.cortesias:
          _navigateTo(context, AppRoutes.partyDrinkCourtesies);
        case DrawerMenuId.logout:
          break;
      }
    }

    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
      WidgetsBinding.instance.addPostFrameCallback((_) => navigate());
      return;
    }

    navigate();
  }

  static void navigateToAllEvents(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.allEvents);
  }

  static void navigateToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (route) => false,
    );
  }

  static void _navigateTo(BuildContext context, String routeName) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == routeName) {
      return;
    }

    Navigator.of(context).pushReplacementNamed(routeName);
  }

  static Future<void> _openDrinkMenuFromDrawer(BuildContext context) async {
    final opened = await PartyModeNavigation.openDrinkMenu(
      context,
      replaceCurrent: true,
    );
    if (!opened && context.mounted) {
      AppSnackBar.show(
        context,
        AppStrings.partyModeUnavailable(context.l10n),
      );
    }
  }

  static Scaffold wrap({
    required GlobalKey<ScaffoldState> scaffoldKey,
    required BuildContext context,
    required Widget body,
    PreferredSizeWidget? appBar,
    Color? backgroundColor,
  }) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor,
      drawerEnableOpenDragGesture: false,
      drawerScrimColor: DrawerDesignSpec.drawerScrimColor,
      drawer: buildDrawer(
        context,
        onMenuSelected: (menuId) => handleMenuSelected(context, menuId),
      ),
      appBar: appBar,
      body: body,
    );
  }
}
