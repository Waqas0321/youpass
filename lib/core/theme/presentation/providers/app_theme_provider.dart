import 'package:flutter/material.dart';
import 'package:youpass/core/theme/domain/repositories/theme_preference_repository.dart';

class AppThemeProvider extends ChangeNotifier {
  AppThemeProvider(this.themePreferenceRepository) {
    // Party Mode is session-scoped; never restore a saved dark theme.
    isFiestaMode = false;
    themePreferenceRepository.migrateFiestaMode(false);
  }

  final ThemePreferenceRepository themePreferenceRepository;

  bool isFiestaMode = false;

  ThemeMode get themeMode =>
      isFiestaMode ? ThemeMode.dark : ThemeMode.light;

  /// Visual Party Mode toggle. Venue/ticket eligibility still gates party
  /// features separately; [eligible] is kept for call-site compatibility.
  Future<void> toggleFiestaMode({bool eligible = true}) async {
    await setFiestaMode(!isFiestaMode, eligible: eligible);
  }

  Future<void> setFiestaMode(bool enabled, {bool eligible = true}) async {
    if (isFiestaMode == enabled) {
      return;
    }

    isFiestaMode = enabled;
    // Prefer not persisting Party Mode across launches.
    await themePreferenceRepository.saveFiestaMode(false);
    notifyListeners();
  }
}
