import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/features/auth/data/models/auth_session_model.dart';
import 'package:youpass/features/auth/data/models/profile_completeness_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import '../../mocks/mock_auth_local_datasource.dart';
import '../../mocks/mock_auth_remote_datasource.dart';
import '../../../../helpers/auth_test_helper.dart';
import '../../../../helpers/jwt_test_helper.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late AuthRepositoryImpl repository;

  setUpAll(AuthTestHelper.registerFallbacks);

  setUp(() {
    AuthTokenStore.clear();
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
    when(() => mockLocalDataSource.cacheUser(any())).thenAnswer((_) async {});
    when(() => mockLocalDataSource.cacheToken(any())).thenAnswer((_) async {});
  });

  tearDown(AuthTokenStore.clear);

  group('loginWithPhone', () {
    test('persists session user and token', () async {
      const session = AuthSessionModel(
        accessToken: TestFixtures.testToken,
        user: TestFixtures.testUser,
        sessionId: 'sess-1',
      );

      when(
        () => mockRemoteDataSource.loginWithPhone(
          phone: any(named: 'phone'),
          countryIsoCode: any(named: 'countryIsoCode'),
          code: any(named: 'code'),
        ),
      ).thenAnswer((_) async => session);
      when(() => mockLocalDataSource.cacheUser(any())).thenAnswer((_) async {});
      when(() => mockLocalDataSource.cacheToken(any())).thenAnswer((_) async {});

      final result = await repository.loginWithPhone(
        phone: TestFixtures.testPhone,
        countryIsoCode: 'CL',
        code: '123456',
      );

      expect(result, session);
      expect(AuthTokenStore.accessToken, TestFixtures.testToken);
      verify(() => mockLocalDataSource.cacheUser(TestFixtures.testUser)).called(1);
      verify(() => mockLocalDataSource.cacheToken(TestFixtures.testToken)).called(1);
    });

    test('caches profile from login user payload', () async {
      final session = AuthSessionModel(
        accessToken: TestFixtures.testToken,
        user: TestFixtures.testUser,
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
            hasInstagram: true,
            completionPercentage: 80,
            missingFields: ['profile_photo'],
          ),
          instagramUsername: 'Waqas0321',
        ),
      );

      when(
        () => mockRemoteDataSource.loginWithPhone(
          phone: any(named: 'phone'),
          countryIsoCode: any(named: 'countryIsoCode'),
          code: any(named: 'code'),
        ),
      ).thenAnswer((_) async => session);
      when(() => mockLocalDataSource.cacheUser(any())).thenAnswer((_) async {});
      when(() => mockLocalDataSource.cacheToken(any())).thenAnswer((_) async {});
      when(() => mockLocalDataSource.cacheUserProfile(any()))
          .thenAnswer((_) async {});

      await repository.loginWithPhone(
        phone: TestFixtures.testPhone,
        countryIsoCode: 'PK',
        code: '123456',
      );

      final captured = verify(
        () => mockLocalDataSource.cacheUserProfile(captureAny()),
      ).captured.single as UserProfileModel;

      expect(captured.instagramUsername, 'Waqas0321');
      expect(captured.birthdate, '2003-06-02');
    });

    test('normalizes Bearer prefix before persisting token', () async {
      final session = AuthSessionModel(
        accessToken: '  Bearer ${TestFixtures.testToken}  ',
        user: TestFixtures.testUser,
      );

      when(
        () => mockRemoteDataSource.loginWithPhone(
          phone: any(named: 'phone'),
          countryIsoCode: any(named: 'countryIsoCode'),
          code: any(named: 'code'),
        ),
      ).thenAnswer((_) async => session);
      when(() => mockLocalDataSource.cacheUser(any())).thenAnswer((_) async {});
      when(() => mockLocalDataSource.cacheToken(any())).thenAnswer((_) async {});

      await repository.loginWithPhone(
        phone: TestFixtures.testPhone,
        countryIsoCode: 'CL',
        code: '123456',
      );

      expect(AuthTokenStore.accessToken, TestFixtures.testToken);
      verify(() => mockLocalDataSource.cacheToken(TestFixtures.testToken)).called(1);
    });

    test('throws when login response has no access token', () async {
      const session = AuthSessionModel(
        accessToken: '',
        user: TestFixtures.testUser,
      );

      when(
        () => mockRemoteDataSource.loginWithPhone(
          phone: any(named: 'phone'),
          countryIsoCode: any(named: 'countryIsoCode'),
          code: any(named: 'code'),
        ),
      ).thenAnswer((_) async => session);

      await expectLater(
        repository.loginWithPhone(
          phone: TestFixtures.testPhone,
          countryIsoCode: 'CL',
          code: '123456',
        ),
        throwsA(
          isA<ApiException>().having(
            (error) => error.code,
            'code',
            'MISSING_ACCESS_TOKEN',
          ),
        ),
      );
    });
  });

  group('getAccessToken', () {
    test('returns in-memory token before disk cache', () async {
      AuthTokenStore.setSession(accessToken: JwtTestHelper.validToken());

      final token = await repository.getAccessToken();

      expect(token, JwtTestHelper.validToken());
      verifyNever(() => mockLocalDataSource.getCachedToken());
    });
  });

  group('refreshUserProfile', () {
    test('forwards accessTokenOverride to remote datasource', () async {
      when(
        () => mockRemoteDataSource.fetchUserProfile(
          accessTokenOverride: 'fresh-token',
        ),
      ).thenAnswer((_) async => TestFixtures.testUserProfile);
      when(() => mockLocalDataSource.cacheUserProfile(any()))
          .thenAnswer((_) async {});

      final profile = await repository.refreshUserProfile(
        accessTokenOverride: 'fresh-token',
      );

      expect(profile, TestFixtures.testUserProfile);
    });
  });

  group('uploadProfilePhoto', () {
    test('forwards accessTokenOverride to remote datasource', () async {
      when(
        () => mockRemoteDataSource.uploadProfilePhoto(
          '/tmp/photo.jpg',
          accessTokenOverride: 'fresh-token',
        ),
      ).thenAnswer((_) async => TestFixtures.testUserProfile);
      when(() => mockLocalDataSource.cacheUserProfile(any()))
          .thenAnswer((_) async {});

      final profile = await repository.uploadProfilePhoto(
        '/tmp/photo.jpg',
        accessTokenOverride: 'fresh-token',
      );

      expect(profile, TestFixtures.testUserProfile);
    });
  });

  group('sendVerificationCode', () {
    test('delegates to remote datasource', () async {
      when(
        () => mockRemoteDataSource.sendVerificationCode(
          phone: any(named: 'phone'),
          countryIsoCode: any(named: 'countryIsoCode'),
          purpose: any(named: 'purpose'),
        ),
      ).thenAnswer((_) async => TestFixtures.testSendCodeResult);

      final result = await repository.sendVerificationCode(
        phone: TestFixtures.testPhone,
        countryIsoCode: 'CL',
        purpose: OtpPurpose.login,
      );

      expect(result, TestFixtures.testSendCodeResult);
    });
  });

  group('logout', () {
    test('clears local cache', () async {
      when(() => mockLocalDataSource.getCachedToken())
          .thenAnswer((_) async => null);
      when(() => mockLocalDataSource.clearCache()).thenAnswer((_) async {});

      await repository.logout();

      verify(() => mockLocalDataSource.clearCache()).called(1);
    });
  });

  group('getCurrentUser', () {
    test('returns cached user from local datasource', () async {
      when(() => mockLocalDataSource.getCachedUser())
          .thenAnswer((_) async => TestFixtures.testUser);

      final result = await repository.getCurrentUser();

      expect(result, TestFixtures.testUser);
    });
  });
}
