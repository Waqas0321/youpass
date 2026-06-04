import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';

import '../../mocks/mock_auth_repository.dart';
import '../../../../helpers/auth_test_helper.dart';
import '../../../../helpers/jwt_test_helper.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthProvider authProvider;

  setUpAll(AuthTestHelper.registerFallbacks);

  setUp(() {
    AuthTokenStore.clear();
    mockAuthRepository = MockAuthRepository();
    authProvider = AuthTestHelper.buildAuthProvider(mockAuthRepository);
  });

  tearDown(AuthTokenStore.clear);

  group('checkAuthStatus', () {
    test('sets authenticated when token and profile refresh succeed', () async {
      when(() => mockAuthRepository.getAccessToken())
          .thenAnswer((_) async => JwtTestHelper.validToken());
      when(() => mockAuthRepository.getCachedUserProfile())
          .thenAnswer((_) async => null);
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => TestFixtures.testUser);
      when(() => mockAuthRepository.refreshUserProfile())
          .thenAnswer((_) async => TestFixtures.testUserProfile);
      when(
        () => mockAuthRepository.refreshUserProfile(
          accessTokenOverride: any(named: 'accessTokenOverride'),
        ),
      ).thenAnswer((_) async => TestFixtures.testUserProfile);

      await authProvider.checkAuthStatus();

      expect(authProvider.status, AuthStatus.authenticated);
      expect(authProvider.currentUser?.id, TestFixtures.testUserProfile.id);
      expect(authProvider.userProfile, TestFixtures.testUserProfile);
    });

    test('sets unauthenticated when no token', () async {
      when(() => mockAuthRepository.getAccessToken())
          .thenAnswer((_) async => null);

      await authProvider.checkAuthStatus();

      expect(authProvider.status, AuthStatus.unauthenticated);
      expect(authProvider.currentUser, isNull);
    });

    test('clears stale session on SESSION_INVALID', () async {
      final token = JwtTestHelper.validToken();
      AuthTokenStore.setSession(accessToken: token);

      when(() => mockAuthRepository.getAccessToken())
          .thenAnswer((_) async => token);
      when(() => mockAuthRepository.getCachedUserProfile())
          .thenAnswer((_) async => TestFixtures.testUserProfile);
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => TestFixtures.testUser);
      when(
        () => mockAuthRepository.refreshUserProfile(
          accessTokenOverride: any(named: 'accessTokenOverride'),
        ),
      ).thenThrow(
        ApiException(
          code: 'SESSION_INVALID',
          message: 'Session is no longer valid',
          statusCode: 401,
        ),
      );
      when(() => mockAuthRepository.logout(notifyServer: any(named: 'notifyServer')))
          .thenAnswer((_) async {});

      await authProvider.checkAuthStatus();

      expect(authProvider.status, AuthStatus.unauthenticated);
      verify(
        () => mockAuthRepository.logout(notifyServer: false),
      ).called(1);
    });
  });

  group('loginWithPhone', () {
    test('returns true and sets user when login succeeds with cached profile',
        () async {
      when(
        () => mockAuthRepository.loginWithPhone(
          phone: any(named: 'phone'),
          countryIsoCode: any(named: 'countryIsoCode'),
          code: any(named: 'code'),
        ),
      ).thenAnswer((_) async => TestFixtures.testAuthSession);
      when(() => mockAuthRepository.getCachedUserProfile())
          .thenAnswer((_) async => TestFixtures.testUserProfile);

      final success = await authProvider.loginWithPhone(
        phone: TestFixtures.testPhone,
        countryIsoCode: 'CL',
        code: '123456',
      );

      expect(success, isTrue);
      expect(authProvider.status, AuthStatus.authenticated);
      expect(authProvider.userProfile, TestFixtures.testUserProfile);
      verifyNever(
        () => mockAuthRepository.refreshUserProfile(
          accessTokenOverride: any(named: 'accessTokenOverride'),
        ),
      );
    });

    test('fetches profile remotely when login cache is empty', () async {
      when(
        () => mockAuthRepository.loginWithPhone(
          phone: any(named: 'phone'),
          countryIsoCode: any(named: 'countryIsoCode'),
          code: any(named: 'code'),
        ),
      ).thenAnswer((_) async => TestFixtures.testAuthSession);
      when(() => mockAuthRepository.getCachedUserProfile())
          .thenAnswer((_) async => null);
      when(
        () => mockAuthRepository.refreshUserProfile(
          accessTokenOverride: any(named: 'accessTokenOverride'),
        ),
      ).thenAnswer((_) async => TestFixtures.testUserProfile);

      final success = await authProvider.loginWithPhone(
        phone: TestFixtures.testPhone,
        countryIsoCode: 'CL',
        code: '123456',
      );

      expect(success, isTrue);
      expect(authProvider.userProfile, TestFixtures.testUserProfile);
      verify(
        () => mockAuthRepository.refreshUserProfile(
          accessTokenOverride: any(named: 'accessTokenOverride'),
        ),
      ).called(1);
    });
  });

  group('refreshUserProfile', () {
    test('clears session on SESSION_INVALID', () async {
      final token = JwtTestHelper.validToken();
      AuthTokenStore.setSession(accessToken: token);
      authProvider.status = AuthStatus.authenticated;
      authProvider.currentUser = TestFixtures.testUser;

      when(
        () => mockAuthRepository.refreshUserProfile(
          accessTokenOverride: any(named: 'accessTokenOverride'),
        ),
      ).thenThrow(
        ApiException(
          code: 'SESSION_INVALID',
          message: 'Session is no longer valid',
          statusCode: 401,
        ),
      );
      when(() => mockAuthRepository.logout(notifyServer: any(named: 'notifyServer')))
          .thenAnswer((_) async {});

      final profile = await authProvider.refreshUserProfile();

      expect(profile, isNull);
      expect(authProvider.status, AuthStatus.unauthenticated);
      verify(
        () => mockAuthRepository.logout(notifyServer: false),
      ).called(1);
    });
  });

  group('uploadProfilePhoto', () {
    test('clears session on SESSION_INVALID', () async {
      final token = JwtTestHelper.validToken();
      AuthTokenStore.setSession(accessToken: token);
      authProvider.status = AuthStatus.authenticated;
      authProvider.currentUser = TestFixtures.testUser;
      authProvider.userProfile = TestFixtures.testUserProfile;

      when(
        () => mockAuthRepository.uploadProfilePhoto(
          '/tmp/photo.jpg',
          accessTokenOverride: token,
        ),
      ).thenThrow(
        ApiException(
          code: 'SESSION_INVALID',
          message: 'Session is no longer valid',
          statusCode: 401,
        ),
      );
      when(() => mockAuthRepository.logout(notifyServer: any(named: 'notifyServer')))
          .thenAnswer((_) async {});

      final success = await authProvider.uploadProfilePhoto('/tmp/photo.jpg');

      expect(success, isFalse);
      expect(authProvider.status, AuthStatus.unauthenticated);
      verify(
        () => mockAuthRepository.logout(notifyServer: false),
      ).called(1);
    });

    test('uploads successfully with token override', () async {
      final token = JwtTestHelper.validToken();
      AuthTokenStore.setSession(accessToken: token);

      when(() => mockAuthRepository.getAccessToken())
          .thenAnswer((_) async => token);
      when(
        () => mockAuthRepository.uploadProfilePhoto(
          '/tmp/photo.jpg',
          accessTokenOverride: token,
        ),
      ).thenAnswer((_) async => TestFixtures.testUserProfile);

      final success = await authProvider.uploadProfilePhoto('/tmp/photo.jpg');

      expect(success, isTrue);
      expect(authProvider.userProfile, TestFixtures.testUserProfile);
    });
  });

  group('sendVerificationCode', () {
    test('returns send code result on success', () async {
      when(
        () => mockAuthRepository.sendVerificationCode(
          phone: any(named: 'phone'),
          countryIsoCode: any(named: 'countryIsoCode'),
          purpose: any(named: 'purpose'),
        ),
      ).thenAnswer((_) async => TestFixtures.testSendCodeResult);

      final result = await authProvider.sendVerificationCode(
        phone: TestFixtures.testPhone,
        countryIsoCode: 'CL',
        purpose: OtpPurpose.login,
      );

      expect(result, TestFixtures.testSendCodeResult);
      expect(authProvider.errorMessage, isNull);
    });
  });

  group('logout', () {
    test('clears user and sets unauthenticated', () async {
      when(() => mockAuthRepository.logout()).thenAnswer((_) async {});
      authProvider.currentUser = TestFixtures.testUser;
      authProvider.status = AuthStatus.authenticated;

      await authProvider.logout();

      expect(authProvider.currentUser, isNull);
      expect(authProvider.status, AuthStatus.unauthenticated);
      verify(() => mockAuthRepository.logout()).called(1);
    });
  });
}
