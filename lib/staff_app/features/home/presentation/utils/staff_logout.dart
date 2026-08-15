import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/home/presentation/providers/staff_work_mode_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_session_provider.dart';
import 'package:youpass/routes/app_routes.dart';

Future<void> performStaffLogout(BuildContext context) async {
  final navigator = Navigator.of(context);
  final authProvider = context.read<StaffAuthProvider>();
  final supervisorSession = context.read<StaffSupervisorSessionProvider>();
  final workMode = context.read<StaffWorkModeProvider>();

  await authProvider.logout();

  supervisorSession.lock();
  workMode.syncForProfile(null);

  navigator.pushNamedAndRemoveUntil(
    AppRoutes.login,
    (_) => false,
  );
}
