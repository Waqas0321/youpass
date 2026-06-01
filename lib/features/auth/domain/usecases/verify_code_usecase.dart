import 'package:youpass/features/auth/domain/entities/user_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class VerifyCodeUseCase {
  VerifyCodeUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<UserEntity> call({
    required String countryCode,
    required String phoneNumber,
    required String code,
  }) {
    return authRepository.verifyCode(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      code: code,
    );
  }
}
