import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class SendCodeUseCase {
  SendCodeUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<void> call({
    required String countryCode,
    required String phoneNumber,
  }) {
    return authRepository.sendVerificationCode(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
    );
  }
}
