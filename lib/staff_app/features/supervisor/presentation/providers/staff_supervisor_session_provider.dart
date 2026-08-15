import 'package:flutter/foundation.dart';

/// Session gate for supervisor tools after backend PIN validation.
class StaffSupervisorSessionProvider extends ChangeNotifier {
  static const int pinLength = 4;

  bool _isUnlocked = false;

  bool get isUnlocked => _isUnlocked;

  void unlock() {
    if (_isUnlocked) {
      return;
    }
    _isUnlocked = true;
    notifyListeners();
  }

  void lock() {
    if (!_isUnlocked) {
      return;
    }
    _isUnlocked = false;
    notifyListeners();
  }
}
