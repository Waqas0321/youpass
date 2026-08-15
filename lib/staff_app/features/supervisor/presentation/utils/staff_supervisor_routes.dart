import 'package:youpass/staff_app/features/home/domain/models/staff_work_mode.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

String supervisorDashboardRouteForMode(StaffWorkMode mode) {
  return switch (mode) {
    StaffWorkMode.bar => StaffAppRoutes.supervisorDashboard,
    StaffWorkMode.accessValidator => StaffAppRoutes.supervisorAccessDashboard,
  };
}
