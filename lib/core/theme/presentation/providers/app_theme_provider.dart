import 'package:flutter/material.dart';
import 'package:youpass/core/theme/domain/repositories/theme_preference_repository.dart';

class AppThemeProvider extends ChangeNotifier {
  AppThemeProvider(this.themePreferenceRepository) {
    isFiestaMode = themePreferenceRepository.loadFiestaMode();
    themePreferenceRepository.migrateFiestaMode(isFiestaMode);
  }

  final ThemePreferenceRepository themePreferenceRepository;

  bool isFiestaMode = false;

  ThemeMode get themeMode =>
      isFiestaMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> toggleFiestaMode() async {
    await setFiestaMode(!isFiestaMode);
  }

  Future<void> setFiestaMode(bool enabled) async {
    if (isFiestaMode == enabled) {
      return;
    }

    isFiestaMode = enabled;
    await themePreferenceRepository.saveFiestaMode(enabled);
    notifyListeners();
  }
}
