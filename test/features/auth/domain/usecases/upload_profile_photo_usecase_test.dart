import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/auth/domain/usecases/upload_profile_photo_usecase.dart';

import '../../../../helpers/test_fixtures.dart';
import '../../mocks/mock_auth_repository.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late UploadProfilePhotoUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = UploadProfilePhotoUseCase(mockAuthRepository);
  });

  test('calls repository uploadProfilePhoto', () async {
    when(
      () => mockAuthRepository.uploadProfilePhoto(
        '/tmp/photo.jpg',
        accessTokenOverride: any(named: 'accessTokenOverride'),
      ),
    ).thenAnswer((_) async => TestFixtures.testUserProfile);

    final profile = await useCase('/tmp/photo.jpg');

    expect(profile, TestFixtures.testUserProfile);
    verify(
      () => mockAuthRepository.uploadProfilePhoto(
        '/tmp/photo.jpg',
        accessTokenOverride: any(named: 'accessTokenOverride'),
      ),
    ).called(1);
  });

  test('forwards accessTokenOverride to repository', () async {
    when(
      () => mockAuthRepository.uploadProfilePhoto(
        '/tmp/photo.jpg',
        accessTokenOverride: 'login-token',
      ),
    ).thenAnswer((_) async => TestFixtures.testUserProfile);

    await useCase('/tmp/photo.jpg', accessTokenOverride: 'login-token');

    verify(
      () => mockAuthRepository.uploadProfilePhoto(
        '/tmp/photo.jpg',
        accessTokenOverride: 'login-token',
      ),
    ).called(1);
  });
}
