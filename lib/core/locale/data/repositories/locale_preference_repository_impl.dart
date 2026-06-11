import 'package:youpass/core/locale/constants/locale_storage_keys.dart';
import 'package:youpass/core/locale/domain/repositories/locale_preference_repository.dart';
import 'package:youpass/core/services/storage_service.dart';

class LocalePreferenceRepositoryImpl implements LocalePreferenceRepository {
  LocalePreferenceRepositoryImpl(this.storageService);

  final StorageService storageService;

  @override
  String? loadLanguageCode() {
    return storageService.getString(LocaleStorageKeys.languageCode);
  }

  @override
  Future<void> saveLanguageCode(String languageCode) {
    return storageService.saveString(LocaleStorageKeys.languageCode, languageCode);
  }
}
