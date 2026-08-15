import 'package:youpass/staff_app/features/auth/data/models/staff_session.dart';
import 'package:youpass/staff_app/features/auth/domain/staff_scan_permissions.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_work_mode.dart';

extension StaffProfileSupervisorAccess on StaffProfile {
  bool get hasSupervisorAccess =>
      hasBarSupervisorAccess || hasEntrySupervisorAccess;

  bool hasSupervisorAccessForMode(StaffWorkMode mode) {
    return switch (mode) {
      StaffWorkMode.bar => hasBarSupervisorAccess,
      StaffWorkMode.accessValidator => hasEntrySupervisorAccess,
    };
  }

  /// Drawer is for supervisor tools and bar/tickets switching only.
  bool shouldShowMenuDrawer(StaffWorkMode mode) {
    return canSwitchScanMode || hasSupervisorAccessForMode(mode);
  }
}
