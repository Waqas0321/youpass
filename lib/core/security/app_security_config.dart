import 'package:youpass/core/security/security_config_model.dart';

/// In-memory security policy from `/config` (or `/config/security`).
class AppSecurityConfig {
  AppSecurityConfig._();

  static SecurityConfigModel _config = SecurityConfigModel.defaults;

  static SecurityConfigModel get current => _config;

  static void apply(SecurityConfigModel? config) {
    _config = config ?? SecurityConfigModel.defaults;
  }
}
