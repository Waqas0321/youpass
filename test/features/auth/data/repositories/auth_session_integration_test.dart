import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/auth/access_token_storage.dart';
import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/services/storage_service.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource_impl.dart';
import 'package:youpass/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youpass/features/auth/data/models/auth_session_model.dart';
import 'package:youpass/features/auth/data/models/profile_completeness_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';

import '../../../../helpers/jwt_test_helper.dart';
import '../../../../helpers/storage_test_helper.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late StorageService storageService;
  late MemoryAccessTokenStorage accessTokenStorage;
  late AuthLocalDataSourceImpl localDataSource;
  late AuthRepositoryImpl repository;

  setUp(() async {
    AuthTokenStore.clear();
    storageService = await StorageTestHelper.createStorageService();
    accessTokenStorage = MemoryAccessTokenStorage();
    localDataSource = AuthLocalDataSourceImpl(
      storageService: storageService,
      accessTokenStorage: accessTokenStorage,
    );
  });

  tearDown(() async {
    AuthTokenStore.clear();
    await accessTokenStorage.delete();
    await storageService.clear();
  });

  test('login persists token and cached profile for immediate authenticated use',
      () async {
    final token = JwtTestHelper.validToken(sessionId: 'sess-live');
    final session = AuthSessionModel(
      accessToken: token,
      user: TestFixtures.testUser,
      sessionId: 'sess-live',
      cachedLoginProfile: UserProfileModel(
        id: TestFixtures.testUser.id,
        phone: '+923216548001',
        phoneDisplay: '+923216548001',
        countryCode: 'PK',
        fullName: TestFixtures.testUser.name,
        email: TestFixtures.testUser.email,
        birthdate: '2003-06-02',
        gender: 'male',
        rutOrPassport: '',
        category: 'bronze',
        accountStatus: 'active',
        createdAt: DateTime(2024, 1, 1),
        profileCompleteness: const ProfileCompletenessModel(
          hasPhoto: false,
          hasInstagram: false,
          completionPercentage: 70,
          missingFields: ['profile_photo'],
        ),
      ),
    );

    repository = AuthRepositoryImpl(
      remoteDataSource: _LoginRemoteDataSource(session),
      localDataSource: localDataSource,
    );

    await repository.loginWithPhone(
      phone: TestFixtures.testPhone,
      countryIsoCode: 'PK',
      code: '123456',
    );

    expect(AuthTokenStore.accessToken, token);
    expect(await repository.getAccessToken(), token);

    final cachedProfile = await repository.getCachedUserProfile();
    expect(cachedProfile, isNotNull);
    expect(cachedProfile!.fullName, TestFixtures.testUser.name);
  });
}

class _LoginRemoteDataSource implements AuthRemoteDataSource {
  _LoginRemoteDataSource(this.session);

  final AuthSessionEntity session;

  @override
  Future<AuthSessionEntity> loginWithPhone({
    required String phone,
    required String countryIsoCode,
    required String code,
  }) async {
    return session;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
