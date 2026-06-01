import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/services/storage_service.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource_impl.dart';
import '../../../../helpers/storage_test_helper.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late StorageService storageService;
  late AuthLocalDataSourceImpl dataSource;

  setUp(() async {
    storageService = await StorageTestHelper.createStorageService();
    dataSource = AuthLocalDataSourceImpl(storageService);
  });

  tearDown(() async {
    await storageService.clear();
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

  test('clearCache removes user and token', () async {
    await dataSource.cacheUser(TestFixtures.testUser);
    await dataSource.cacheToken(TestFixtures.testToken);

    await dataSource.clearCache();

    expect(await dataSource.getCachedUser(), isNull);
    expect(await dataSource.getCachedToken(), isNull);
    expect(storageService.getString(AppConstants.userKey), isNull);
  });
}
