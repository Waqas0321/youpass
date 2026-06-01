import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/auth/domain/usecases/login_usecase.dart';
import '../../mocks/mock_auth_repository.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginUseCase loginUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  test('calls repository login with email and password', () async {
    when(
      () => mockAuthRepository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => TestFixtures.testUser);

    final result = await loginUseCase(
      email: TestFixtures.testEmail,
      password: TestFixtures.testPassword,
    );

    expect(result, TestFixtures.testUser);
    verify(
      () => mockAuthRepository.login(
        email: TestFixtures.testEmail,
        password: TestFixtures.testPassword,
      ),
    ).called(1);
  });
}
