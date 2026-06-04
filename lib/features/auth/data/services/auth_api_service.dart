import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/core/utils/image_mime_utils.dart';
import 'package:youpass/features/auth/data/models/auth_session_model.dart';
import 'package:youpass/features/auth/data/models/check_whatsapp_request_model.dart';
import 'package:youpass/features/auth/data/models/delete_account_result_model.dart';
import 'package:youpass/features/auth/data/models/delete_account_verify_request_model.dart';
import 'package:youpass/features/auth/data/models/login_request_model.dart';
import 'package:youpass/features/auth/data/models/otp_delivery_result_model.dart';
import 'package:youpass/features/auth/data/models/otp_request_model.dart';
import 'package:youpass/features/auth/data/models/register_request_model.dart';
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
  }) {
    return postModel(
      ApiEndpoints.checkWhatsApp,
      body: CheckWhatsAppRequestModel(
        phone: phone,
        countryIsoCode: countryIsoCode,
        purpose: purpose,
      ).toJson(),
      fromJson: WhatsAppCheckResultModel.fromJson,
    );
  }

  Future<SendCodeResponseModel> sendCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return postModel(
      ApiEndpoints.sendCode,
      body: _otpRequest(
        phone: phone,
        countryIsoCode: countryIsoCode,
        purpose: purpose,
      ).toJson(),
      fromJson: SendCodeResponseModel.fromJson,
    );
  }

  Future<SendCodeResponseModel> resendCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return postModel(
      ApiEndpoints.resendCode,
      body: _otpRequest(
        phone: phone,
        countryIsoCode: countryIsoCode,
        purpose: purpose,
      ).toJson(),
      fromJson: SendCodeResponseModel.fromJson,
    );
  }

  Future<AuthSessionModel> login({
    required String phone,
    required String countryIsoCode,
    required String code,
  }) {
    return postModel(
      ApiEndpoints.login,
      body: LoginRequestModel(
        phone: phone,
        countryIsoCode: countryIsoCode,
        code: code,
      ).toJson(),
      fromJson: AuthSessionModel.fromJson,
    );
  }

  Future<AuthSessionModel> register(RegisterRequestEntity request) {
    return postModel(
      ApiEndpoints.register,
      body: RegisterRequestModel.fromEntity(request).toJson(),
      fromJson: AuthSessionModel.fromJson,
    );
  }

  Future<void> logout({String? accessTokenOverride}) {
    return postVoid(
      ApiEndpoints.logout,
      authenticated: true,
      accessTokenOverride: accessTokenOverride,
    );
  }

  Future<UserProfileModel> fetchCurrentUserProfile({
    String? accessTokenOverride,
  }) {
    return getModel(
      ApiEndpoints.usersMe,
      fromJson: UserProfileModel.fromJson,
      authenticated: true,
      accessTokenOverride: accessTokenOverride,
    );
  }

  Future<UserProfileModel> uploadProfilePhoto(
    String filePath, {
    String? accessTokenOverride,
  }) async {
    final data = await postMultipartData(
      ApiEndpoints.userProfilePhoto,
      files: [
        await http.MultipartFile.fromPath(
          'photo',
          filePath,
          contentType: MediaType.parse(ImageMimeUtils.fromPath(filePath)),
        ),
      ],
      authenticated: true,
      accessTokenOverride: accessTokenOverride,
    );

    return UserProfileModel.fromJson(data);
  }

  Future<OtpDeliveryResultModel> requestDeleteAccount() {
    return postModel(
      ApiEndpoints.deleteAccountRequest,
      fromJson: OtpDeliveryResultModel.fromJson,
      authenticated: true,
    );
  }

  Future<DeleteAccountResultModel> confirmDeleteAccount({
    required String code,
  }) {
    return postModel(
      ApiEndpoints.deleteAccountVerify,
      body: DeleteAccountVerifyRequestModel(code: code).toJson(),
      fromJson: DeleteAccountResultModel.fromJson,
      authenticated: true,
    );
  }

  OtpRequestModel _otpRequest({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return OtpRequestModel(
      phone: phone,
      countryIsoCode: countryIsoCode,
      purpose: purpose,
    );
  }
}
