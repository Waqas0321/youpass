import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/whatsapp_check_result_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class CheckWhatsAppUseCase {
  CheckWhatsAppUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<WhatsAppCheckResultEntity> call({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return authRepository.checkWhatsApp(
      phone: phone,
      countryIsoCode: countryIsoCode,
      purpose: purpose,
    );
  }
}
