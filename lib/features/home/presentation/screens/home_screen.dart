import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_loader.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/home_top_bar_widget.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/home/presentation/utils/home_feed_factory.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);

    if (lastLocale != locale) {
      lastLocale = locale;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        loadHomeFeed();
      });
    }
  }

  void loadHomeFeed() {
    final feed = HomeFeedFactory.create(context.l10n);
    context.read<HomeProvider>().setHomeFeed(feed);
  }

  String resolveUserName() {
    final user = context.read<AuthProvider>().currentUser;
    final rawName = user?.name.trim();

    if (rawName == null || rawName.isEmpty) {
      return AppStrings.defaultGuestName(context.l10n);
    }

    if (rawName.length == 1) {
      return rawName.toUpperCase();
    }

    return rawName[0].toUpperCase() + rawName.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final layout = ResponsiveLayout(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.backgroundWhite,
      drawer: HomeDrawerWidget(
        userName: resolveUserName(),
        onMenuSelected: handleDrawerMenuSelected,
      ),
      body: SafeArea(
        child: buildBody(homeProvider, layout),
      ),
    );
  }

  void openDrawer() {
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

  Widget buildBody(HomeProvider homeProvider, ResponsiveLayout layout) {
    if (homeProvider.status == HomeStatus.loading) {
      return const Center(child: AppLoader());
    }

    if (homeProvider.status == HomeStatus.error) {
      return Center(
        child: AppText(
          homeProvider.errorMessage ?? AppStrings.errorGeneric(context.l10n),
          variant: AppTextVariant.error,
        ),
      );
    }

    final feed = homeProvider.homeFeed;
    if (feed == null) {
      return const Center(child: AppLoader());
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
              userName: resolveUserName(),
              feed: feed,
            ),
          ),
        ),
      ],
    );
  }
}
