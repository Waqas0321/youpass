import 'package:flutter/material.dart';

import 'package:youpass/staff_app/routes/app_routes.dart';

const _supervisorRootRoutes = {
  StaffAppRoutes.supervisorPin,
  StaffAppRoutes.supervisorDashboard,
  StaffAppRoutes.supervisorAccessDashboard,
};

/// Leaves the supervisor UI and returns to the staff home stack.
///
/// Does **not** clear the PIN unlock — supervisor stays unlocked for this staff
/// login so re-opening does not ask for PIN again. Logout clears the unlock.
void exitStaffSupervisorMode(BuildContext context) {
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
