import 'package:youpass/core/network/api_client.dart';
import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/api_response_parser.dart';
import 'package:youpass/features/auth/data/models/auth_session_model.dart';
import 'package:youpass/features/auth/data/models/send_code_response_model.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';

class AuthApiService {
  AuthApiService(this.apiClient);

  final ApiClient apiClient;

  Future<SendCodeResponseModel> sendCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) async {
    final response = await apiClient.post(
      ApiEndpoints.sendCode,
      body: _otpRequestBody(
        phone: phone,
        countryIsoCode: countryIsoCode,
        purpose: purpose,
      ),
    );

    return SendCodeResponseModel.fromJson(ApiResponseParser.parseData(response));
  }

  Future<SendCodeResponseModel> resendCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) async {
    final response = await apiClient.post(
      ApiEndpoints.resendCode,
      body: _otpRequestBody(
        phone: phone,
        countryIsoCode: countryIsoCode,
        purpose: purpose,
      ),
    );

    return SendCodeResponseModel.fromJson(ApiResponseParser.parseData(response));
  }

  Future<AuthSessionModel> login({
    required String phone,
    required String countryIsoCode,
    required String code,
  }) async {
    final response = await apiClient.post(
      ApiEndpoints.login,
      body: {
        'phone': phone,
        'country_code': countryIsoCode,
        'code': code,
      },
    );

    return AuthSessionModel.fromJson(ApiResponseParser.parseData(response));
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

    final response = await apiClient.post(
      ApiEndpoints.register,
      body: body,
    );

    return AuthSessionModel.fromJson(ApiResponseParser.parseData(response));
  }

  Future<void> logout() async {
    await apiClient.post(
      ApiEndpoints.logout,
      authenticated: true,
    );
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
