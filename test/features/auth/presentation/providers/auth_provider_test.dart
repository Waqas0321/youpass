import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/usecases/login_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/logout_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/register_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/resend_code_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/send_code_usecase.dart';
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
    authProvider = AuthProvider(
      sendCodeUseCase: SendCodeUseCase(mockAuthRepository),
      resendCodeUseCase: ResendCodeUseCase(mockAuthRepository),
      loginUseCase: LoginUseCase(mockAuthRepository),
      registerUseCase: RegisterUseCase(mockAuthRepository),
      logoutUseCase: LogoutUseCase(mockAuthRepository),
      authRepository: mockAuthRepository,
    );
  });

  group('checkAuthStatus', () {
    test('sets authenticated when user exists', () async {
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => TestFixtures.testUser);

      await authProvider.checkAuthStatus();

      expect(authProvider.status, AuthStatus.authenticated);
      expect(authProvider.currentUser, TestFixtures.testUser);
    });

    test('sets unauthenticated when no user', () async {
      when(() => mockAuthRepository.getCurrentUser()).thenAnswer((_) async => null);

      await authProvider.checkAuthStatus();

      expect(authProvider.status, AuthStatus.unauthenticated);
      expect(authProvider.currentUser, isNull);
    });
  });

  group('loginWithPhone', () {
    test('returns true and sets user on success', () async {
      when(
        () => mockAuthRepository.loginWithPhone(
          phone: any(named: 'phone'),
          countryIsoCode: any(named: 'countryIsoCode'),
          code: any(named: 'code'),
        ),
      ).thenAnswer((_) async => TestFixtures.testUser);

      final success = await authProvider.loginWithPhone(
        phone: TestFixtures.testPhone,
        countryIsoCode: 'CL',
        code: '123456',
      );

      expect(success, isTrue);
      expect(authProvider.status, AuthStatus.authenticated);
      expect(authProvider.currentUser, TestFixtures.testUser);
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
