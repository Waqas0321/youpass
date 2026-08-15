import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/home/presentation/providers/staff_work_mode_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_session_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/utils/staff_supervisor_access.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/utils/staff_supervisor_routes.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

void openStaffSupervisorFlow(BuildContext context) {
  final session = context.read<StaffSupervisorSessionProvider>();
  final mode = context.read<StaffWorkModeProvider>().mode;
  final profile = context.read<StaffAuthProvider>().profile;

  if (profile == null || !profile.hasSupervisorAccessForMode(mode)) {
    AppSnackBar.show(context, context.l10n.staffSupervisorAccessDenied);
    return;
  }

  final dashboardRoute = supervisorDashboardRouteForMode(mode);

  if (session.isUnlocked) {
    Navigator.of(context).pushNamed(dashboardRoute);
    return;
  }

  Navigator.of(context).pushNamed(StaffAppRoutes.supervisorPin);
}
