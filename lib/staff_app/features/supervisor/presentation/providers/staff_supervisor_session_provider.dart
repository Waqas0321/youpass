import 'package:flutter/foundation.dart';

import 'package:youpass/staff_app/core/storage/staff_token_store.dart';

/// Session gate for supervisor tools after PIN validation.
///
/// Unlock once per staff login (persisted). Leaving the supervisor UI does not
/// re-lock — only logout (or explicit [lock]) does. Offline re-entry uses the
/// local PIN verifier saved after the first successful online unlock.
class StaffSupervisorSessionProvider extends ChangeNotifier {
  StaffSupervisorSessionProvider({StaffTokenStore? tokenStore})
    : _tokenStore = tokenStore ?? StaffTokenStore() {
    restore();
  }

  static const int pinLength = 4;

  final StaffTokenStore _tokenStore;

  bool _isUnlocked = false;
  bool _restoreComplete = false;

  bool get isUnlocked => _isUnlocked;

  bool get restoreComplete => _restoreComplete;

  Future<void> restore() async {
    try {
      final unlocked = await _tokenStore.readSupervisorUnlocked();
      if (unlocked) {
        _isUnlocked = true;
      }
    } finally {
      _restoreComplete = true;
      notifyListeners();
    }
  }

  Future<void> unlock() async {
    _isUnlocked = true;
    await _tokenStore.saveSupervisorUnlocked(true);
    notifyListeners();
  }

  Future<void> lock() async {
    _isUnlocked = false;
    await _tokenStore.saveSupervisorUnlocked(false);
    notifyListeners();
  }
}
