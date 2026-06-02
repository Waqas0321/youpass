import 'package:youpass/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youpass/features/auth/data/services/auth_api_service.dart';
import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';
import 'package:youpass/features/auth/domain/entities/delete_account_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/otp_delivery_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/domain/entities/send_code_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';
import 'package:youpass/features/auth/domain/entities/whatsapp_check_result_entity.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.authApiService);

  final AuthApiService authApiService;

  @override
  Future<WhatsAppCheckResultEntity> checkWhatsApp({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return authApiService.checkWhatsApp(
      phone: phone,
      countryIsoCode: countryIsoCode,
      purpose: purpose,
    );
  }

  @override
  Future<SendCodeResultEntity> sendVerificationCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return authApiService.sendCode(
      phone: phone,
      countryIsoCode: countryIsoCode,
      purpose: purpose,
    );
  }

  @override
  Future<SendCodeResultEntity> resendVerificationCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return authApiService.resendCode(
      phone: phone,
      countryIsoCode: countryIsoCode,
      purpose: purpose,
    );
  }

  @override
  Future<AuthSessionEntity> loginWithPhone({
    required String phone,
    required String countryIsoCode,
    required String code,
  }) {
    return authApiService.login(
      phone: phone,
      countryIsoCode: countryIsoCode,
      code: code,
    );
  }

  @override
  Future<AuthSessionEntity> registerAccount(RegisterRequestEntity request) {
    return authApiService.register(request);
  }

  @override
  Future<void> logoutRemote() {
    return authApiService.logout();
  }

  @override
  Future<UserProfileEntity> fetchUserProfile() {
    return authApiService.fetchCurrentUserProfile();
  }

  @override
  Future<OtpDeliveryResultEntity> requestDeleteAccount() {
    return authApiService.requestDeleteAccount();
  }

  @override
  Future<DeleteAccountResultEntity> confirmDeleteAccount({
    required String code,
  }) {
    return authApiService.confirmDeleteAccount(code: code);
  }
}
