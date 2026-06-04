import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/auth/access_token_storage.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/services/storage_service.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource_impl.dart';
import '../../../../helpers/storage_test_helper.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late StorageService storageService;
  late MemoryAccessTokenStorage accessTokenStorage;
  late AuthLocalDataSourceImpl dataSource;

  setUp(() async {
    storageService = await StorageTestHelper.createStorageService();
    accessTokenStorage = MemoryAccessTokenStorage();
    dataSource = AuthLocalDataSourceImpl(
      storageService: storageService,
      accessTokenStorage: accessTokenStorage,
    );
  });

  tearDown(() async {
    await storageService.clear();
    await accessTokenStorage.delete();
  });

  test('cacheUser and getCachedUser round-trip user data', () async {
    await dataSource.cacheUser(TestFixtures.testUser);

    final cached = await dataSource.getCachedUser();

    expect(cached, TestFixtures.testUser);
  });

  test('cacheToken and getCachedToken round-trip token', () async {
    await dataSource.cacheToken(TestFixtures.testToken);

    final token = await dataSource.getCachedToken();

    expect(token, TestFixtures.testToken);
  });

  test('cacheToken normalizes Bearer prefix before saving', () async {
    await dataSource.cacheToken('Bearer eyJ.saved.token');

    expect(await dataSource.getCachedToken(), 'eyJ.saved.token');
    expect(storageService.getString(AppConstants.tokenKey), isNull);
  });

  test('cacheSessionId and clearSessionId manage session key', () async {
    await dataSource.cacheSessionId('sess-123');
    expect(storageService.getString(AppConstants.sessionIdKey), 'sess-123');

    await dataSource.clearSessionId();
    expect(storageService.getString(AppConstants.sessionIdKey), isNull);
  });

  test('clearCache removes user and token', () async {
    await dataSource.cacheUser(TestFixtures.testUser);
    await dataSource.cacheToken(TestFixtures.testToken);

    await dataSource.clearCache();

    expect(await dataSource.getCachedUser(), isNull);
    expect(await dataSource.getCachedToken(), isNull);
    expect(storageService.getString(AppConstants.userKey), isNull);
  });
}
