import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_scaffold.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_brand_logo.dart';
import 'package:youpass/features/auth/routes/welcome_route_args.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/routes/app_routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.args});

  final WelcomeRouteArgs args;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Timer? _navigationTimer;
  Future<void>? _homeTransitionFuture;

  @override
  void initState() {
    super.initState();
    final navigation = widget.args.navigation;
    final seconds = widget.args.welcome.durationSeconds > 0
        ? widget.args.welcome.durationSeconds
        : navigation.welcomeDurationSeconds;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeProvider = context.read<HomeProvider>();
      homeProvider.beginPostRegistrationSession(
        registrationStartedAtMs: widget.args.registrationStartedAtMs,
        analyticsSource: widget.args.analyticsSource,
        highlightInvitation: navigation.highlightPendingInvitation ||
            navigation.linkedInvitationsCount > 0,
      );
      _homeTransitionFuture = _prepareHome(homeProvider);
    });

    _navigationTimer = Timer(
      Duration(seconds: seconds > 0 ? seconds : 2),
      _openHome,
    );
  }

  Future<void> _prepareHome(HomeProvider homeProvider) async {
    final feed = await homeProvider.preloadPostRegistrationFeed();
    if (feed != null) {
      await homeProvider.applyPreloadedFeed(
        feed,
        highlightInvitation: widget.args.navigation.highlightPendingInvitation ||
            widget.args.navigation.linkedInvitationsCount > 0,
      );
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  Future<void> _openHome() async {
    if (!mounted) {
      return;
    }

    final homeProvider = context.read<HomeProvider>();
    try {
      await (_homeTransitionFuture ?? Future.value());
    } catch (error, stackTrace) {
      debugPrint('Welcome preload failed: $error\n$stackTrace');
    }

    if (homeProvider.homeFeed == null) {
      try {
        await homeProvider.loadHomeData();
      } catch (error, stackTrace) {
        debugPrint('Welcome home load failed: $error\n$stackTrace');
      }
    }

    if (!mounted) {
      return;
    }

    assert(!widget.args.navigation.openProfile);
    assert(!widget.args.navigation.openHamburgerMenu);

    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final welcome = widget.args.welcome;
    final title = welcome.title.trim().isEmpty
        ? AppStrings.welcomeFallbackTitle(strings)
        : welcome.title;
    final subtitle = welcome.subtitle.trim().isEmpty
        ? AppStrings.welcomeFallbackSubtitle(strings)
        : welcome.subtitle;

    return AppScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const YouPassBrandLogo(),
              const SizedBox(height: 40),
              AppText(
                title,
                variant: AppTextVariant.title,
                textAlign: TextAlign.center,
                color: AppColors.darkNavy,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(height: 16),
              AppText(
                subtitle,
                variant: AppTextVariant.body,
                textAlign: TextAlign.center,
                color: AppColors.profileLabelGrey,
                fontSize: 16,
                height: 1.4,
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
