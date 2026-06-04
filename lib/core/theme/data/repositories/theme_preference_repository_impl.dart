import 'package:youpass/core/services/storage_service.dart';
import 'package:youpass/core/theme/constants/theme_storage_keys.dart';
import 'package:youpass/core/theme/domain/repositories/theme_preference_repository.dart';

class ThemePreferenceRepositoryImpl implements ThemePreferenceRepository {
  ThemePreferenceRepositoryImpl(this.storageService);

  final StorageService storageService;

  @override
  bool loadFiestaMode() {
    return storageService.readBool(ThemeStorageKeys.fiestaMode);
  }

  @override
  Future<void> saveFiestaMode(bool enabled) {
    return storageService.saveBool(ThemeStorageKeys.fiestaMode, enabled);
  }

  @override
  Future<void> migrateFiestaMode(bool enabled) {
    return storageService.migrateToBool(ThemeStorageKeys.fiestaMode, enabled);
  }
}
