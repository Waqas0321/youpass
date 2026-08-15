import 'package:youpass/staff_app/core/network/base_api_service.dart';
import 'package:youpass/staff_app/core/network/staff_api_endpoints.dart';
import 'package:youpass/staff_app/features/auth/data/models/staff_lookup_response.dart';
import 'package:youpass/staff_app/features/auth/data/models/staff_send_code_response.dart';
import 'package:youpass/staff_app/features/auth/data/models/staff_session.dart';

class StaffAuthApiService extends BaseApiService {
  StaffAuthApiService(super.apiClient);

  Future<StaffLookupResponse> lookup({
    required String phone,
    required String countryCode,
  }) {
    return postModel(
      StaffApiEndpoints.lookup,
      body: {
        'phone': phone,
        'country_code': countryCode,
      },
      fromJson: StaffLookupResponse.fromJson,
    );
  }

  Future<StaffSendCodeResponse> sendCode({
    required String phone,
    required String countryCode,
  }) {
    return postModel(
      StaffApiEndpoints.sendCode,
      body: {
        'phone': phone,
        'country_code': countryCode,
      },
      fromJson: StaffSendCodeResponse.fromJson,
    );
  }

  Future<StaffSendCodeResponse> resendCode({
    required String phone,
    required String countryCode,
  }) {
    return postModel(
      StaffApiEndpoints.resendCode,
      body: {
        'phone': phone,
        'country_code': countryCode,
      },
      fromJson: StaffSendCodeResponse.fromJson,
    );
  }

  Future<StaffSession> login({
    required String phone,
    required String countryCode,
    required String code,
  }) {
    return postModel(
      StaffApiEndpoints.login,
      body: {
        'phone': phone,
        'country_code': countryCode,
        'code': code,
      },
      fromJson: StaffSession.fromJson,
    );
  }

  Future<void> logout() {
    return postVoid(StaffApiEndpoints.logout, authenticated: true);
  }

  Future<StaffProfile> fetchMe() {
    return getModel(
      StaffApiEndpoints.me,
      fromJson: StaffProfile.fromJson,
      authenticated: true,
    );
  }
}
