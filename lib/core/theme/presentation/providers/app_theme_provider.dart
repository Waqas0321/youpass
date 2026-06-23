import 'package:flutter/material.dart';
import 'package:youpass/core/theme/domain/repositories/theme_preference_repository.dart';

class AppThemeProvider extends ChangeNotifier {
  AppThemeProvider(this.themePreferenceRepository) {
    // Party Mode is eligibility-gated per session; never restore a saved dark theme.
    isFiestaMode = false;
    themePreferenceRepository.migrateFiestaMode(false);
  }

  final ThemePreferenceRepository themePreferenceRepository;

  bool isFiestaMode = false;

  ThemeMode get themeMode =>
      isFiestaMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> toggleFiestaMode({required bool eligible}) async {
    if (!eligible) {
      if (isFiestaMode) {
        await setFiestaMode(false, eligible: eligible);
      }
      return;
    }

    await setFiestaMode(!isFiestaMode, eligible: eligible);
  }

  Future<void> setFiestaMode(bool enabled, {required bool eligible}) async {
    if (enabled && !eligible) {
      return;
    }

    if (isFiestaMode == enabled) {
      return;
    }

    isFiestaMode = enabled;
    await themePreferenceRepository.saveFiestaMode(false);
    notifyListeners();
  }
}
