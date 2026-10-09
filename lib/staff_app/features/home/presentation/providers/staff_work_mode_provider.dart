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

  String? _profileId;

  void syncForProfile(StaffProfile? profile) {
    if (profile == null) {
      _profileId = null;
      setMode(StaffWorkMode.bar);
      return;
    }

    // A newly signed-in staff member starts in their role's mode (door vs bar);
    // later syncs keep whatever mode they switched to.
    if (_profileId != profile.id) {
      _profileId = profile.id;
      setMode(profile.preferredWorkMode);
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
