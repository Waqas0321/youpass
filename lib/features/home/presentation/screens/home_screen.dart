import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/home_top_bar_widget.dart';
import 'package:youpass/core/widgets/shimmer/home_feed_shimmer.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
import 'package:youpass/features/home/presentation/utils/home_user_display_helper.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/home_drawer_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_feed_widget.dart';
import 'package:youpass/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Locale? lastLocale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<HomeProvider>().loadHomeDataIfNeeded();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);

    if (lastLocale != null && lastLocale != locale) {
      lastLocale = locale;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        context.read<HomeProvider>().loadHomeData();
      });
      return;
    }

    lastLocale ??= locale;
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final authProvider = context.watch<AuthProvider>();
    final invitationsProvider = context.watch<InvitationsProvider>();
    final layout = ResponsiveLayout(context);
    final drawerFullName =
        HomeUserDisplayHelper.drawerFullName(authProvider, context.l10n);
    final greetingName =
        HomeUserDisplayHelper.greetingName(authProvider, context.l10n);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.backgroundWhite,
      drawer: HomeDrawerWidget(
        fullName: drawerFullName,
        profilePhotoUrl: authProvider.userProfile?.profilePhotoUrl,
        invitationsBadgeCount: invitationsProvider.invitationsBadgeCount,
        onMenuSelected: handleDrawerMenuSelected,
      ),
      body: SafeArea(
        child: buildBody(homeProvider, layout, greetingName),
      ),
    );
  }

  void openDrawer() {
    context.read<AuthProvider>().refreshUserProfile();
    context.read<InvitationsProvider>().refreshDrawerBadge();
    scaffoldKey.currentState?.openDrawer();
  }

  void handleDrawerMenuSelected(DrawerMenuId menuId) {
    switch (menuId) {
      case DrawerMenuId.profile:
        Navigator.of(context).pushNamed(AppRoutes.profile);
      case DrawerMenuId.tickets:
        Navigator.of(context).pushNamed(AppRoutes.myTickets);
      case DrawerMenuId.favorites:
        Navigator.of(context).pushNamed(AppRoutes.myFavorites);
      case DrawerMenuId.invitations:
        Navigator.of(context).pushNamed(AppRoutes.myInvitations);
    }
  }

  Widget buildBody(
    HomeProvider homeProvider,
    ResponsiveLayout layout,
    String greetingName,
  ) {
    if (homeProvider.status == HomeStatus.loading && homeProvider.homeFeed == null) {
      return Column(
        children: [
          HomeTopBarWidget(onMenuTap: openDrawer),
          Expanded(
            child: SingleChildScrollView(
              padding: layout.screenPadding,
              child: const HomeFeedShimmer(),
            ),
          ),
        ],
      );
    }

    if (homeProvider.status == HomeStatus.error && homeProvider.homeFeed == null) {
      return Center(
        child: AppText(
          homeProvider.errorMessage ?? AppStrings.errorGeneric(context.l10n),
          variant: AppTextVariant.error,
        ),
      );
    }

    final feed = homeProvider.homeFeed;
    if (feed == null) {
      return Column(
        children: [
          HomeTopBarWidget(onMenuTap: openDrawer),
          Expanded(
            child: SingleChildScrollView(
              padding: layout.screenPadding,
              child: const HomeFeedShimmer(),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        HomeTopBarWidget(
          onMenuTap: openDrawer,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: layout.screenPadding,
            child: HomeFeedWidget(
              userName: greetingName,
              feed: feed,
            ),
          ),
        ),
      ],
    );
  }
}
