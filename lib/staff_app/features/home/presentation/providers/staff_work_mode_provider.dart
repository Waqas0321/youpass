import 'package:flutter/foundation.dart';

import 'package:youpass/staff_app/features/auth/data/models/staff_session.dart';
import 'package:youpass/staff_app/features/auth/domain/staff_scan_permissions.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_work_mode.dart';

class StaffWorkModeProvider extends ChangeNotifier {
  StaffWorkMode _mode = StaffWorkMode.bar;

  StaffWorkMode get mode => _mode;

  bool get isAccessValidator => _mode == StaffWorkMode.accessValidator;

  void setMode(StaffWorkMode mode) {
    if (_mode == mode) {
      return;
    }
    _mode = mode;
    notifyListeners();
  }

  void syncForProfile(StaffProfile? profile) {
    if (profile == null) {
      setMode(StaffWorkMode.bar);
      return;
    }

    if (!profile.canSwitchScanMode) {
      setMode(profile.preferredWorkMode);
      return;
    }

    if (!profile.isWorkModeAllowed(_mode)) {
      setMode(profile.preferredWorkMode);
    }
  }

  void toggleSupervisorMode() {
    setMode(
      _mode == StaffWorkMode.bar
          ? StaffWorkMode.accessValidator
          : StaffWorkMode.bar,
    );
  }
}
