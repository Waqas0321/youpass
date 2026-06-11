import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';
import 'package:youpass/features/auth/domain/entities/change_phone_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/delete_account_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/otp_delivery_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/domain/entities/send_code_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';
import 'package:youpass/features/auth/domain/entities/whatsapp_check_result_entity.dart';

abstract class AuthRemoteDataSource {
  Future<WhatsAppCheckResultEntity> checkWhatsApp({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  });

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

  Future<AuthSessionEntity> loginWithPhone({
    required String phone,
    required String countryIsoCode,
    required String code,
  });

  Future<AuthSessionEntity> registerAccount(RegisterRequestEntity request);

  Future<void> logoutRemote({String? accessTokenOverride});

  Future<UserProfileEntity> fetchUserProfile({String? accessTokenOverride});

  Future<UserProfileEntity> uploadProfilePhoto(
    String filePath, {
    String? accessTokenOverride,
  });

  Future<OtpDeliveryResultEntity> requestDeleteAccount();

  Future<DeleteAccountResultEntity> confirmDeleteAccount({
    required String code,
  });

  Future<OtpDeliveryResultEntity> requestChangePhone({
    required String newPhone,
    required String newCountryCode,
  });

  Future<ChangePhoneResultEntity> verifyChangePhone({
    required String newPhone,
    required String newCountryCode,
    required String code,
  });
}
