import 'package:youpass/features/auth/domain/entities/otp_delivery_result_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class RequestDeleteAccountUseCase {
  RequestDeleteAccountUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<OtpDeliveryResultEntity> call() {
    return authRepository.requestDeleteAccount();
  }
}
