import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/widgets/app_scaffold.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';
import 'package:youpass/features/auth/routes/welcome_route_args.dart';
import 'package:youpass/routes/app_routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.args});

  final WelcomeRouteArgs args;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    final seconds = widget.args.welcome.durationSeconds;
    _navigationTimer = Timer(
      Duration(seconds: seconds > 0 ? seconds : 2),
      _openHome,
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  void _openHome() {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final welcome = widget.args.welcome;

    return AppScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const YouPassLogo(),
              const SizedBox(height: 40),
              AppText(
                welcome.title,
                variant: AppTextVariant.title,
                textAlign: TextAlign.center,
                color: AppColors.darkNavy,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(height: 16),
              AppText(
                welcome.subtitle,
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
