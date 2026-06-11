import 'package:youpass/core/config/auth_product_config_model.dart';

/// Product rules from `GET /config/auth` (auth, registration, commerce).
class AppProductConfig {
  AppProductConfig._();

  static ProductConfigModel _config = ProductConfigModel.defaults;

  static ProductConfigModel get current => _config;
  static AuthProductConfigModel get auth => _config.auth;
  static RegistrationProductConfigModel get registration => _config.registration;
  static CommerceProductConfigModel get commerce => _config.commerce;
  static UiMessagesConfigModel get uiMessages => _config.uiMessages;
  static PostRegistrationConfigModel get postRegistration => _config.postRegistration;

  static void apply(ProductConfigModel? config) {
    _config = config ?? ProductConfigModel.defaults;
  }
}
