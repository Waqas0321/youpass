import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/home_error_extension.dart';
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
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/home_drawer_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_feed_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_greeting_widget.dart';
import 'package:youpass/features/profile/presentation/utils/account_deletion_actions.dart';
import 'package:youpass/features/profile/presentation/widgets/account_deletion_pending_banner_widget.dart';
import 'package:youpass/features/invitations/presentation/utils/invitation_detail_navigation.dart';
import 'package:youpass/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  static const Duration _badgeRefreshInterval = Duration(seconds: 30);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();
  Timer? _badgeRefreshTimer;
  Locale? lastLocale;
  bool _shownPendingDeletionNotice = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    scrollController.addListener(_handleScroll);
    _startBadgeRefreshTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final homeProvider = context.read<HomeProvider>();
      if (homeProvider.homeFeed == null) {
        homeProvider.loadHomeDataIfNeeded();
      }
      homeProvider.trackRegistrationCompletedIfNeeded();
      _maybeShowPendingDeletionNotice();
      _loadWaitlistOffersIfAuthenticated();
    });
  }

  void _loadWaitlistOffersIfAuthenticated() {
    final authProvider = context.read<AuthProvider>();
    if (authProvider.status == AuthStatus.authenticated) {
      context.read<InvitationsProvider>().ensureLoaded();
    }
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
  void dispose() {
    _badgeRefreshTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    super.dispose();
  }

  void _startBadgeRefreshTimer() {
    _badgeRefreshTimer?.cancel();
    _badgeRefreshTimer = Timer.periodic(_badgeRefreshInterval, (_) {
      _refreshInvitationsBadgeIfAuthenticated();
    });
  }

  void _refreshInvitationsBadgeIfAuthenticated() {
    if (!mounted) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    if (authProvider.status == AuthStatus.authenticated) {
      context.read<InvitationsProvider>().refreshDrawerBadge();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      _refreshInvitationsBadgeIfAuthenticated();
      _loadWaitlistOffersIfAuthenticated();
      _maybeShowPendingDeletionNotice();
    }
  }

  void _maybeShowPendingDeletionNotice() {
    final profile = context.read<AuthProvider>().userProfile;
    if (profile?.isPendingDeletion != true || _shownPendingDeletionNotice) {
      return;
    }

    _shownPendingDeletionNotice = true;
    final strings = context.l10n;
    final days = profile!.daysRemaining ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.profileDeletePendingMessage(strings, days)),
          action: SnackBarAction(
            label: AppStrings.accountDeletionCancelAction(strings),
            onPressed: _handleCancelPendingDeletion,
          ),
        ),
      );
    });
  }

  Future<void> _handleCancelPendingDeletion() async {
    final cancelled = await AccountDeletionActions(context).cancelPendingDeletion();
    if (!cancelled || !mounted) {
      return;
    }
    await context.read<AuthProvider>().refreshUserProfile();
    setState(() => _shownPendingDeletionNotice = false);
  }

  void _handleScroll() {
    if (!scrollController.hasClients || !mounted) {
      return;
    }

    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 240) {
      context.read<HomeProvider>().loadMoreUpcomingIfNeeded();
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final authProvider = context.watch<AuthProvider>();
    final invitationsProvider = context.watch<InvitationsProvider>();
    final layout = ResponsiveLayout(context);
    final drawerFirstName =
        HomeUserDisplayHelper.drawerFirstName(authProvider, context.l10n);
    final drawerMembershipTier =
        HomeUserDisplayHelper.membershipTier(authProvider);
    final headerGreeting = HomeUserDisplayHelper.headerGreetingText(
      authProvider,
      context.l10n,
      apiGreeting: homeProvider.resolveHeaderGreetingFromApi(),
    );
    final upcomingSectionTitle = homeProvider.resolveUpcomingSectionTitle();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawerEnableOpenDragGesture: false,
      drawerScrimColor: DrawerDesignSpec.drawerScrimColor,
      drawer: HomeDrawerWidget(
        firstName: drawerFirstName,
        tier: drawerMembershipTier,
        profilePhotoUrl: authProvider.userProfile?.profilePhotoUrl,
        invitationsBadgeCount: invitationsProvider.invitationsBadgeCount,
        onMenuSelected: handleDrawerMenuSelected,
      ),
      body: SafeArea(
        child:         buildBody(
          homeProvider,
          layout,
          headerGreeting: headerGreeting,
          upcomingSectionTitle: upcomingSectionTitle,
        ),
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
        Navigator.of(context)
            .pushNamed(AppRoutes.myInvitations)
            .then((_) => _refreshInvitationsBadgeIfAuthenticated());
    }
  }

  Widget buildBody(
    HomeProvider homeProvider,
    ResponsiveLayout layout, {
    required String headerGreeting,
    String? upcomingSectionTitle,
  }) {
    if (homeProvider.status == HomeStatus.loading && homeProvider.homeFeed == null) {
      return Column(
        children: [
          HomeTopBarWidget(
            onMenuTap: openDrawer,
            showPartyModeBanner: homeProvider.showPartyModeBanner,
          ),
          Padding(
            padding: layout.screenPadding,
            child: HomeGreetingWidget(greetingText: headerGreeting),
          ),
          SizedBox(height: layout.spacing(8)),
          Expanded(
            child: SingleChildScrollView(
              padding: layout.screenPadding.copyWith(top: 0),
              child: const HomeFeedShimmer(),
            ),
          ),
        ],
      );
    }

    if (homeProvider.status == HomeStatus.error && homeProvider.homeFeed == null) {
      return Column(
        children: [
          HomeTopBarWidget(
            onMenuTap: openDrawer,
            showPartyModeBanner: homeProvider.showPartyModeBanner,
          ),
          Padding(
            padding: layout.screenPadding,
            child: HomeGreetingWidget(greetingText: headerGreeting),
          ),
          Expanded(
            child: Center(
              child: AppText(
                homeProvider.localizedErrorMessage(context.l10n) ??
                    AppStrings.errorGeneric(context.l10n),
                variant: AppTextVariant.error,
              ),
            ),
          ),
        ],
      );
    }

    final feed = homeProvider.homeFeed;
    if (feed == null) {
      return Column(
        children: [
          HomeTopBarWidget(
            onMenuTap: openDrawer,
            showPartyModeBanner: homeProvider.showPartyModeBanner,
          ),
          Padding(
            padding: layout.screenPadding,
            child: HomeGreetingWidget(greetingText: headerGreeting),
          ),
          SizedBox(height: layout.spacing(8)),
          Expanded(
            child: SingleChildScrollView(
              padding: layout.screenPadding.copyWith(top: 0),
              child: const HomeFeedShimmer(),
            ),
          ),
        ],
      );
    }

    final authProvider = context.watch<AuthProvider>();
    final pendingProfile = authProvider.userProfile;
    final showDeletionBanner = pendingProfile?.isPendingDeletion == true;

    return Column(
      children: [
        HomeTopBarWidget(
          onMenuTap: openDrawer,
          showPartyModeBanner: homeProvider.showPartyModeBanner,
        ),
        if (showDeletionBanner) ...[
          Padding(
            padding: layout.screenPadding.copyWith(top: 0, bottom: 0),
            child: AccountDeletionPendingBannerWidget(
              daysRemaining: pendingProfile!.daysRemaining ?? 0,
              deletionScheduledAt: pendingProfile.deletionScheduledAt,
              onCancelTap: _handleCancelPendingDeletion,
            ),
          ),
          SizedBox(height: layout.spacing(12)),
        ],
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => homeProvider.refreshHome(),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: layout.screenPadding,
              child: HomeFeedWidget(
                greetingText: headerGreeting,
                upcomingSectionTitle: upcomingSectionTitle,
                feed: feed,
                highlightPendingInvitation: homeProvider.highlightPendingInvitation,
                pendingInvitationCount: homeProvider.highlightedInvitationCount,
                pendingInvitationTitle: homeProvider.highlightedInvitationTitle,
                onPendingInvitationTap: homeProvider.highlightPendingInvitation
                    ? () {
                        final invitationId = homeProvider.highlightedInvitationId;
                        if (invitationId != null) {
                          final destination =
                              InvitationDetailNavigation.resolveById(invitationId);
                          Navigator.of(context).pushNamed(
                            destination.route,
                            arguments: destination.args,
                          );
                          return;
                        }
                        Navigator.of(context).pushNamed(AppRoutes.myInvitations);
                      }
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
