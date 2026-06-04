abstract class ThemePreferenceRepository {
  bool loadFiestaMode();

  Future<void> saveFiestaMode(bool enabled);

  Future<void> migrateFiestaMode(bool enabled);
}
