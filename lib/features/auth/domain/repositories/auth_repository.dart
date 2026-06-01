import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/domain/entities/send_code_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<SendCodeResultEntity> sendVerificationCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  });

  Future<SendCodeResultEntity> resendVerificationCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  });

  Future<UserEntity> loginWithPhone({
    required String phone,
    required String countryIsoCode,
    required String code,
  });

  Future<UserEntity> registerAccount(RegisterRequestEntity request);

  Future<void> logout({bool notifyServer = true});

  Future<UserEntity?> getCurrentUser();

  Future<String?> getAccessToken();
}
