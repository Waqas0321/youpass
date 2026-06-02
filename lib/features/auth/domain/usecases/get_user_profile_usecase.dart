import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class GetUserProfileUseCase {
  GetUserProfileUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<UserProfileEntity> call() {
    return authRepository.refreshUserProfile();
  }
}
