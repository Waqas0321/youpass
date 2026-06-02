import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';

import '../../mocks/mock_auth_repository.dart';
import '../../../../helpers/auth_test_helper.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthProvider authProvider;

  setUpAll(AuthTestHelper.registerFallbacks);

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authProvider = AuthTestHelper.buildAuthProvider(mockAuthRepository);
  });

  group('checkAuthStatus', () {
    test('sets authenticated when token and profile refresh succeed', () async {
      when(() => mockAuthRepository.getAccessToken())
          .thenAnswer((_) async => TestFixtures.testToken);
      when(() => mockAuthRepository.getCachedUserProfile())
          .thenAnswer((_) async => null);
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => TestFixtures.testUser);
      when(() => mockAuthRepository.refreshUserProfile())
          .thenAnswer((_) async => TestFixtures.testUserProfile);

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
  });

  group('loginWithPhone', () {
    test('returns true and sets user when login succeeds', () async {
      when(
        () => mockAuthRepository.loginWithPhone(
          phone: any(named: 'phone'),
          countryIsoCode: any(named: 'countryIsoCode'),
          code: any(named: 'code'),
        ),
      ).thenAnswer((_) async => TestFixtures.testAuthSession);
      when(() => mockAuthRepository.refreshUserProfile())
          .thenAnswer((_) async => TestFixtures.testUserProfile);

      final success = await authProvider.loginWithPhone(
        phone: TestFixtures.testPhone,
        countryIsoCode: 'CL',
        code: '123456',
      );

      expect(success, isTrue);
      expect(authProvider.status, AuthStatus.authenticated);
      expect(
        authProvider.currentUser,
        TestFixtures.testUserProfile.toUserEntity(),
      );
      expect(authProvider.userProfile, TestFixtures.testUserProfile);
      verify(
        () => mockAuthRepository.loginWithPhone(
          phone: TestFixtures.testPhone,
          countryIsoCode: 'CL',
          code: '123456',
        ),
      ).called(1);
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
