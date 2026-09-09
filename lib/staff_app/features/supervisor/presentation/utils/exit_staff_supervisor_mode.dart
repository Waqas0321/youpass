import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_session_provider.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

const _supervisorRootRoutes = {
  StaffAppRoutes.supervisorPin,
  StaffAppRoutes.supervisorDashboard,
  StaffAppRoutes.supervisorAccessDashboard,
};

/// Locks the supervisor session and returns to the staff home stack.
void exitStaffSupervisorMode(BuildContext context) {
  context.read<StaffSupervisorSessionProvider>().lock();

  final navigator = Navigator.of(context);
  if (!navigator.canPop()) {
    return;
  }

  var didPopNamedRoot = false;
  navigator.popUntil((route) {
    final name = route.settings.name;
    if (name != null && _supervisorRootRoutes.contains(name)) {
      didPopNamedRoot = true;
      return false;
    }
    return true;
  });

  // Fallback for routes created without RouteSettings.name (older builds /
  // unnamed MaterialPageRoute). PIN is pushReplacement'd by the dashboard, so
  // a single pop returns to home.
  if (!didPopNamedRoot && navigator.canPop()) {
    navigator.pop();
  }
}
