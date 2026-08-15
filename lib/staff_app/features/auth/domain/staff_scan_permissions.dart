import 'package:youpass/staff_app/features/auth/data/models/staff_session.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_work_mode.dart';

extension StaffProfileScanPermissions on StaffProfile {
  bool get canScanProducts =>
      permissionIds.contains('scan_products') ||
      permissionIds.contains('general_admin');

  bool get canScanTickets =>
      permissionIds.contains('scan_tickets') ||
      permissionIds.contains('general_admin');

  bool get canSwitchScanMode => canScanProducts && canScanTickets;

  bool get hasAnyScanAccess => canScanProducts || canScanTickets;

  bool get hasBarSupervisorAccess =>
      permissionIds.contains('bar_supervisor') ||
      permissionIds.contains('general_admin');

  bool get hasEntrySupervisorAccess =>
      permissionIds.contains('tickets_supervisor') ||
      permissionIds.contains('general_admin');

  bool isWorkModeAllowed(StaffWorkMode mode) {
    return switch (mode) {
      StaffWorkMode.bar => canScanProducts,
      StaffWorkMode.accessValidator => canScanTickets,
    };
  }

  StaffWorkMode get preferredWorkMode {
    if (canScanProducts && !canScanTickets) {
      return StaffWorkMode.bar;
    }
    if (canScanTickets && !canScanProducts) {
      return StaffWorkMode.accessValidator;
    }
    return StaffWorkMode.bar;
  }
}
