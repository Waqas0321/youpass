import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  RegisterUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<AuthSessionEntity> call(RegisterRequestEntity request) {
    return authRepository.registerAccount(request);
  }
}
