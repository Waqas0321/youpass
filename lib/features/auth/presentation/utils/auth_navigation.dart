import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/presentation/utils/post_registration_flow_helper.dart';
import 'package:youpass/features/auth/routes/welcome_route_args.dart';
import 'package:youpass/routes/app_routes.dart';

class AuthNavigation {
  AuthNavigation._();

  static void completeOneTimeLogin(
    BuildContext context, {
    required OtpPurpose purpose,
  }) {
    final authProvider = context.read<AuthProvider>();

    if (purpose == OtpPurpose.register) {
      final session = authProvider.consumeLastRegistrationSession();
      if (session != null) {
        final navigation = PostRegistrationFlowHelper.resolveNavigation(session);
        if (navigation.showWelcomeScreen && navigation.shouldNavigateToHome) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.welcome,
            (_) => false,
            arguments: WelcomeRouteArgs(
              welcome: PostRegistrationFlowHelper.resolveWelcome(session),
              navigation: navigation,
              registrationStartedAtMs: authProvider.registrationStartedAtMs,
              analyticsSource: authProvider.registrationAnalyticsSource,
            ),
          );
          return;
        }
      }
    }

    if (purpose == OtpPurpose.deleteAccount &&
        authProvider.userProfile?.accountStatus == 'pending_deletion') {
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
      return;
    }

    final route =
        purpose == OtpPurpose.deleteAccount ? AppRoutes.login : AppRoutes.home;

    Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
  }
}
