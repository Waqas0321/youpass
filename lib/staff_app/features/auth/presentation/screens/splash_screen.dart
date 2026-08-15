import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/routes/app_routes.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

/// Kept for compatibility; unified app splash lives in the customer module.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<void> _bootstrap() async {
    final auth = context.read<StaffAuthProvider>();
    final hasSession = await auth.restoreSession();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(
      hasSession ? StaffAppRoutes.home : AppRoutes.login,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SizedBox.expand());
  }
}
