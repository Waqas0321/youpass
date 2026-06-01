import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/send_code_result_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class SendCodeUseCase {
  SendCodeUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<SendCodeResultEntity> call({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return authRepository.sendVerificationCode(
      phone: phone,
      countryIsoCode: countryIsoCode,
      purpose: purpose,
    );
  }
}
