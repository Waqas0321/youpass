import 'package:youpass/core/constants/app_constants.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = AppConstants.apiBaseUrl;
  static const String apiV1 = '$baseUrl/api/v1';

  static const String health = '$apiV1/health';
  static const String configCountries = '$apiV1/config/countries';
  static const String sendCode = '$apiV1/auth/send-code';
  static const String resendCode = '$apiV1/auth/resend-code';
  static const String verifyCode = '$apiV1/auth/verify-code';
  static const String login = '$apiV1/auth/login';
  static const String register = '$apiV1/auth/register';
  static const String logout = '$apiV1/auth/logout';
  static const String userProfile = '$apiV1/users/me/profile';
  static const String userWelcomeData = '$apiV1/users/me/welcome-data';
  static const String checkWhatsApp = '$apiV1/auth/check-whatsapp';
}
