import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
import 'package:youpass/features/home/presentation/utils/home_user_display_helper.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/home_drawer_widget.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/routes/app_routes.dart';

class AppDrawerNavigation {
  AppDrawerNavigation._();

  static Widget buildDrawer(
    BuildContext context, {
    required ValueChanged<DrawerMenuId> onMenuSelected,
  }) {
    final authProvider = context.watch<AuthProvider>();
    final invitationsProvider = context.watch<InvitationsProvider>();

    return HomeDrawerWidget(
      firstName: HomeUserDisplayHelper.drawerFirstName(
        authProvider,
        context.l10n,
      ),
      tier: HomeUserDisplayHelper.membershipTier(authProvider),
      profilePhotoUrl: authProvider.userProfile?.profilePhotoUrl,
      invitationsBadgeCount: invitationsProvider.invitationsBadgeCount,
      onMenuSelected: onMenuSelected,
    );
  }

  static void openDrawer(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    context.read<AuthProvider>().refreshUserProfile();
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
          _navigateTo(context, AppRoutes.profile);
        case DrawerMenuId.tickets:
          _navigateTo(context, AppRoutes.myTickets);
        case DrawerMenuId.favorites:
          _navigateTo(context, AppRoutes.myFavorites);
        case DrawerMenuId.invitations:
          _navigateTo(context, AppRoutes.myInvitations);
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

  static void _navigateTo(BuildContext context, String routeName) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == routeName) {
      return;
    }

    Navigator.of(context).pushReplacementNamed(routeName);
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
