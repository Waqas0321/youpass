import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/auth/domain/usecases/get_user_profile_usecase.dart';

import '../../mocks/mock_auth_repository.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetUserProfileUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = GetUserProfileUseCase(mockAuthRepository);
  });

  test('calls repository refreshUserProfile', () async {
    when(() => mockAuthRepository.refreshUserProfile())
        .thenAnswer((_) async => TestFixtures.testUserProfile);

    final profile = await useCase();

    expect(profile, TestFixtures.testUserProfile);
    verify(() => mockAuthRepository.refreshUserProfile()).called(1);
  });

  test('forwards accessTokenOverride to repository', () async {
    when(
      () => mockAuthRepository.refreshUserProfile(
        accessTokenOverride: 'login-token',
      ),
    ).thenAnswer((_) async => TestFixtures.testUserProfile);

    final profile = await useCase(accessTokenOverride: 'login-token');

    expect(profile, TestFixtures.testUserProfile);
    verify(
      () => mockAuthRepository.refreshUserProfile(
        accessTokenOverride: 'login-token',
      ),
    ).called(1);
  });
}
