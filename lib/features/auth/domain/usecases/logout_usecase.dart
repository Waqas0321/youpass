import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  LogoutUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<void> call() {
    return authRepository.logout();
  }
}
