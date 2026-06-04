import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';
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

    await authProvider.checkAuthStatus();
    if (!mounted) {
      return;
    }

    if (authProvider.status == AuthStatus.authenticated) {
      await Future.wait([
        homeProvider.loadHomeDataIfNeeded(),
        invitationsProvider.refreshDrawerBadge(),
      ]);
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
                Transform.scale(
                  scale: 1.35,
                  child: const YouPassLogo(),
                ),
                SizedBox(height: layout.spacing(16)),
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
