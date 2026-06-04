import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class UploadProfilePhotoUseCase {
  UploadProfilePhotoUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<UserProfileEntity> call(
    String filePath, {
    String? accessTokenOverride,
  }) {
    return authRepository.uploadProfilePhoto(
      filePath,
      accessTokenOverride: accessTokenOverride,
    );
  }
}
