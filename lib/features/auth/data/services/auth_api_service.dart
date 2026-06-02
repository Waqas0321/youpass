import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/auth/data/models/auth_session_model.dart';
import 'package:youpass/features/auth/data/models/delete_account_result_model.dart';
import 'package:youpass/features/auth/data/models/otp_delivery_result_model.dart';
import 'package:youpass/features/auth/data/models/send_code_response_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/auth/data/models/whatsapp_check_result_model.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';

class AuthApiService extends BaseApiService {
  AuthApiService(super.apiClient);

  Future<WhatsAppCheckResultModel> checkWhatsApp({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) async {
    final data = await postData(
      ApiEndpoints.checkWhatsApp,
      body: {
        'phone': phone,
        'country_code': countryIsoCode,
        'purpose': purpose.apiValue,
      },
    );

    return WhatsAppCheckResultModel.fromJson(data);
  }

  Future<SendCodeResponseModel> sendCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) async {
    final data = await postData(
      ApiEndpoints.sendCode,
      body: _otpRequestBody(
        phone: phone,
        countryIsoCode: countryIsoCode,
        purpose: purpose,
      ),
    );

    return SendCodeResponseModel.fromJson(data);
  }

  Future<SendCodeResponseModel> resendCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) async {
    final data = await postData(
      ApiEndpoints.resendCode,
      body: _otpRequestBody(
        phone: phone,
        countryIsoCode: countryIsoCode,
        purpose: purpose,
      ),
    );

    return SendCodeResponseModel.fromJson(data);
  }

  Future<AuthSessionModel> login({
    required String phone,
    required String countryIsoCode,
    required String code,
  }) async {
    final data = await postData(
      ApiEndpoints.login,
      body: {
        'phone': phone,
        'country_code': countryIsoCode,
        'code': code,
      },
    );

    return AuthSessionModel.fromJson(data);
  }

  Future<AuthSessionModel> register(RegisterRequestEntity request) async {
    final body = <String, dynamic>{
      'phone': request.phone,
      'country_code': request.countryIsoCode,
      'code': request.code,
      'full_name': request.fullName,
      'rut_or_passport': request.documentId,
      'email': request.email,
      'birthdate': request.birthDate,
      'gender': request.gender,
      'accept_terms': request.acceptTerms,
    };

    final instagram = request.instagram.trim();
    if (instagram.isNotEmpty) {
      body['instagram_username'] = instagram;
    }

    final data = await postData(
      ApiEndpoints.register,
      body: body,
    );

    return AuthSessionModel.fromJson(data);
  }

  Future<void> logout() {
    return postVoid(
      ApiEndpoints.logout,
      authenticated: true,
    );
  }

  Future<UserProfileModel> fetchCurrentUserProfile() async {
    final data = await getData(
      ApiEndpoints.usersMe,
      authenticated: true,
    );

    return UserProfileModel.fromJson(data);
  }

  Future<OtpDeliveryResultModel> requestDeleteAccount() async {
    final data = await postData(
      ApiEndpoints.deleteAccountRequest,
      authenticated: true,
    );

    return OtpDeliveryResultModel.fromJson(data);
  }

  Future<DeleteAccountResultModel> confirmDeleteAccount({
    required String code,
  }) async {
    final data = await postData(
      ApiEndpoints.deleteAccountVerify,
      body: {'code': code},
      authenticated: true,
    );

    return DeleteAccountResultModel.fromJson(data);
  }

  Map<String, String> _otpRequestBody({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return {
      'phone': phone,
      'country_code': countryIsoCode,
      'purpose': purpose.apiValue,
    };
  }
}
