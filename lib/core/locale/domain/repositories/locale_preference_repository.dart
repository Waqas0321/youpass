abstract class LocalePreferenceRepository {
  String? loadLanguageCode();

  Future<void> saveLanguageCode(String languageCode);
}
