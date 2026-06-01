import 'package:shared_preferences/shared_preferences.dart';
import 'package:youpass/core/services/storage_service.dart';

class StorageTestHelper {
  static Future<StorageService> createStorageService() async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    return StorageService(preferences);
  }
}
