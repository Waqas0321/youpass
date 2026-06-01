import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/auth/domain/usecases/login_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/logout_usecase.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';

import '../../mocks/mock_auth_repository.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthProvider authProvider;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authProvider = AuthProvider(
      loginUseCase: LoginUseCase(mockAuthRepository),
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

  group('login', () {
    test('returns true and sets user on success', () async {
      when(
        () => mockAuthRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => TestFixtures.testUser);

      final success = await authProvider.login(
        email: TestFixtures.testEmail,
        password: TestFixtures.testPassword,
      );

      expect(success, isTrue);
      expect(authProvider.status, AuthStatus.authenticated);
      expect(authProvider.currentUser, TestFixtures.testUser);
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
