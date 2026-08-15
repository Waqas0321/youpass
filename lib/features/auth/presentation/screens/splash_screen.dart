import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/locale/locale_sync_helper.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_brand_logo.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _minSplashDuration = Duration(milliseconds: 3500);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bootstrap();
    });
  }

  Future<void> bootstrap() async {
    final authProvider = context.read<AuthProvider>();
    final homeProvider = context.read<HomeProvider>();
    final invitationsProvider = context.read<InvitationsProvider>();
    final splashStartedAt = DateTime.now();

    await authProvider.checkAuthStatus();
    if (!mounted) {
      return;
    }

    // Apply profile language before the remaining splash delay so the
    // subtitle and first Home frame match the user's preferred language.
    if (authProvider.userProfile != null) {
      LocaleSyncHelper.applyProfile(context, authProvider.userProfile!);
    }

    final profileCountry = authProvider.userProfile?.countryCode;
    if (authProvider.status == AuthStatus.authenticated) {
      homeProvider.seedSessionCountry(profileCountry);
      await Future.wait([
        homeProvider.loadHomeDataIfNeeded(),
        invitationsProvider.refreshDrawerBadge(),
      ]);
    }

    if (!mounted) {
      return;
    }

    final elapsed = DateTime.now().difference(splashStartedAt);
    final remaining = _minSplashDuration - elapsed;
    if (remaining > Duration.zero) {
      await Future<void>.delayed(remaining);
    }

    if (!mounted) {
      return;
    }

    final route = authProvider.status == AuthStatus.authenticated
        ? AppRoutes.home
        : AppRoutes.login;

    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final layout = ResponsiveLayout(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: layout.spacing(40)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                YouPassBrandLogo(
                  width: (layout.width * 0.72).clamp(220.0, 300.0),
                ),
                SizedBox(height: layout.spacing(8)),
                AppText(
                  AppStrings.homeDiscoverSubtitle(strings),
                  variant: AppTextVariant.body,
                  textAlign: TextAlign.center,
                  color: AppColors.secondaryGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
