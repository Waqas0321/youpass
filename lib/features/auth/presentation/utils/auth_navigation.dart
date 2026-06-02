import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/routes/welcome_route_args.dart';
import 'package:youpass/routes/app_routes.dart';

class AuthNavigation {
  AuthNavigation._();

  static void completeOneTimeLogin(
    BuildContext context, {
    required OtpPurpose purpose,
  }) {
    final authProvider = context.read<AuthProvider>();
    final welcome = authProvider.consumePendingWelcome();

    if (purpose != OtpPurpose.deleteAccount && welcome != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.welcome,
        (_) => false,
        arguments: WelcomeRouteArgs(welcome: welcome),
      );
      return;
    }

    final route =
        purpose == OtpPurpose.deleteAccount ? AppRoutes.login : AppRoutes.home;

    Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
  }
}
