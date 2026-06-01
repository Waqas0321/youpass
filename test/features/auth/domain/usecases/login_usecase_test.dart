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

  test('calls repository loginWithPhone', () async {
    when(
      () => mockAuthRepository.loginWithPhone(
        phone: any(named: 'phone'),
        countryIsoCode: any(named: 'countryIsoCode'),
        code: any(named: 'code'),
      ),
    ).thenAnswer((_) async => TestFixtures.testUser);

    final result = await loginUseCase(
      phone: TestFixtures.testPhone,
      countryIsoCode: 'CL',
      code: '123456',
    );

    expect(result, TestFixtures.testUser);
    verify(
      () => mockAuthRepository.loginWithPhone(
        phone: TestFixtures.testPhone,
        countryIsoCode: 'CL',
        code: '123456',
      ),
    ).called(1);
  });
}
