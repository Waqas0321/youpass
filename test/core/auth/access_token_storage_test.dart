import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/core/auth/access_token_storage.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/services/storage_service.dart';

import '../../helpers/storage_test_helper.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SecureAccessTokenStorage', () {
    late StorageService storageService;
    late MockFlutterSecureStorage secureStorage;
    late SecureAccessTokenStorage tokenStorage;

    setUp(() async {
      storageService = await StorageTestHelper.createStorageService();
      secureStorage = MockFlutterSecureStorage();
      tokenStorage = SecureAccessTokenStorage(
        secureStorage: secureStorage,
        legacyStorage: storageService,
      );
    });

    tearDown(() async {
      await storageService.clear();
    });

    test('falls back to SharedPreferences when secure plugin is missing',
        () async {
      when(() => secureStorage.read(key: 'access_token')).thenThrow(
        MissingPluginException(
          'No implementation found for method read on channel '
          'plugins.it_nomads.com/flutter_secure_storage',
        ),
      );
      await storageService.saveString(AppConstants.tokenKey, 'eyJ.legacy.token');

      final token = await tokenStorage.read();

      expect(token, 'eyJ.legacy.token');
    });

    test('writes to SharedPreferences when secure plugin is missing', () async {
      when(() => secureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenThrow(MissingPluginException('missing plugin'));

      await tokenStorage.write('eyJ.new.token');

      expect(storageService.getString(AppConstants.tokenKey), 'eyJ.new.token');
    });
  });
}
