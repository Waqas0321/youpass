import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';

class StaffTokenStore {
  StaffTokenStore({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<bool> hasSession() async {
    final token = await readToken();
    return token != null && token.isNotEmpty;
  }

  Future<String?> readToken() {
    return _storage.read(key: AppConstants.staffTokenKey);
  }

  Future<void> saveToken(String token) {
    return _storage.write(key: AppConstants.staffTokenKey, value: token);
  }

  Future<void> clearSession() {
    return _storage.delete(key: AppConstants.staffTokenKey);
  }
}
