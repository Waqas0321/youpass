import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService(this.preferences);

  final SharedPreferences preferences;

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
