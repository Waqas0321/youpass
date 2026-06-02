import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  LoginUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<AuthSessionEntity> call({
    required String phone,
    required String countryIsoCode,
    required String code,
  }) {
    return authRepository.loginWithPhone(
      phone: phone,
      countryIsoCode: countryIsoCode,
      code: code,
    );
  }
}
