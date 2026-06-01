import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/auth/domain/usecases/logout_usecase.dart';
import '../../mocks/mock_auth_repository.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late LogoutUseCase logoutUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    logoutUseCase = LogoutUseCase(mockAuthRepository);
  });

  test('calls repository logout', () async {
    when(() => mockAuthRepository.logout()).thenAnswer((_) async {});

    await logoutUseCase();

    verify(() => mockAuthRepository.logout()).called(1);
  });
}
