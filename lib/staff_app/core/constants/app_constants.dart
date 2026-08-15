import 'package:youpass/staff_app/core/config/api_config.dart';

class AppConstants {
  AppConstants._();

  static const String appName = 'YouPass';

  static String get productionApiV1Url => ApiConfig.productionApiV1Url;

  static String get devTunnelApiV1Url => ApiConfig.devTunnelApiV1Url;

  static String get localApiV1Url => ApiConfig.localApiV1Url;

  static String get apiBaseUrl => ApiConfig.apiBaseUrl;

  /// Logs every API request/response in debug builds.
  static const bool logApiResponsesToConsole = true;

  static const String staffTokenKey = 'staff_auth_token';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const double countryPickerSheetHeightFactor = 0.85;
}
