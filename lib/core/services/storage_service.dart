import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService(this.preferences);

  final SharedPreferences preferences;

  Future<bool> saveBool(String key, bool value) async {
    return preferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return preferences.getBool(key);
  }

  /// Reads a bool preference, falling back to legacy string values like `"true"`.
  bool readBool(String key, {bool defaultValue = false}) {
    try {
      final boolValue = preferences.getBool(key);
      if (boolValue != null) {
        return boolValue;
      }
    } catch (_) {
      // Value was stored with a different type (e.g. legacy string).
    }

    final stringValue = preferences.getString(key);
    if (stringValue == null) {
      return defaultValue;
    }

    return stringValue.toLowerCase() == 'true';
  }

  /// Normalizes a preference to bool storage (handles legacy string values).
  Future<void> migrateToBool(String key, bool value) async {
    try {
      final existing = preferences.getBool(key);
      if (existing == value) {
        return;
      }
    } catch (_) {
      // Legacy value type — rewrite below.
    }

    await preferences.remove(key);
    await preferences.setBool(key, value);
  }

  Future<bool> saveString(String key, String value) async {
    return preferences.setString(key, value);
  }

  String? getString(String key) {
    return preferences.getString(key);
  }

  Future<bool> remove(String key) async {
    return preferences.remove(key);
  }

  Future<bool> clear() async {
    return preferences.clear();
  }
}
