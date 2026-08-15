import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract final class LocalePreferenceStore {
  static const _key = 'staff_locale_code';
  static const _storage = FlutterSecureStorage();

  static String? _cachedLanguageCode;

  static String? get languageCode => _cachedLanguageCode;

  static Future<void> ensureLoaded() async {
    _cachedLanguageCode = await _storage.read(key: _key);
  }

  static Future<void> saveLanguageCode(String languageCode) async {
    _cachedLanguageCode = languageCode;
    await _storage.write(key: _key, value: languageCode);
  }
}
