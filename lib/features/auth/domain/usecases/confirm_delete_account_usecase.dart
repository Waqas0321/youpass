import 'package:youpass/features/auth/domain/entities/delete_account_result_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class ConfirmDeleteAccountUseCase {
  ConfirmDeleteAccountUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<DeleteAccountResultEntity> call(String code) {
    return authRepository.confirmDeleteAccount(code: code);
  }
}
