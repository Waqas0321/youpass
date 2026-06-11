import 'package:youpass/core/utils/json_readers.dart';

class SecurityConfigModel {
  const SecurityConfigModel({
    this.otpMaxFailedAttempts = 3,
    this.otpBlockMinutes = 15,
    this.otpMaxResendsPerHour = 5,
    this.otpResendCooldownSeconds = 60,
    this.otpTtlMinutes = 3,
    this.jwtExpiresIn = '365d',
    this.oneSessionPerDevice = true,
    this.recaptchaEnabled = false,
    this.recaptchaSiteKey = '',
    this.paymentTokenizationRequired = true,
    this.transport = 'https_only',
    this.otpStorage = 'hashed',
  });

  final int otpMaxFailedAttempts;
  final int otpBlockMinutes;
  final int otpMaxResendsPerHour;
  final int otpResendCooldownSeconds;
  final int otpTtlMinutes;
  final String jwtExpiresIn;
  final bool oneSessionPerDevice;
  final bool recaptchaEnabled;
  final String recaptchaSiteKey;
  final bool paymentTokenizationRequired;
  final String transport;
  final String otpStorage;

  factory SecurityConfigModel.fromJson(Map<String, dynamic> json) {
    return SecurityConfigModel(
      otpMaxFailedAttempts: JsonReaders.integer(
        json,
        'otp_max_failed_attempts',
        fallback: 3,
      ),
      otpBlockMinutes: JsonReaders.integer(
        json,
        'otp_block_minutes',
        fallback: 15,
      ),
      otpMaxResendsPerHour: JsonReaders.integer(
        json,
        'otp_max_resends_per_hour',
        fallback: 5,
      ),
      otpResendCooldownSeconds: JsonReaders.integer(
        json,
        'otp_resend_cooldown_seconds',
        fallback: 60,
      ),
      otpTtlMinutes: JsonReaders.integer(json, 'otp_ttl_minutes', fallback: 3),
      jwtExpiresIn: JsonReaders.string(json, 'jwt_expires_in', fallback: '365d'),
      oneSessionPerDevice: JsonReaders.boolean(
        json,
        'one_session_per_device',
        fallback: true,
      ),
      recaptchaEnabled: JsonReaders.boolean(
        json,
        'recaptcha_enabled',
        fallback: false,
      ),
      recaptchaSiteKey: JsonReaders.string(json, 'recaptcha_site_key'),
      paymentTokenizationRequired: JsonReaders.boolean(
        json,
        'payment_tokenization_required',
        fallback: true,
      ),
      transport: JsonReaders.string(json, 'transport', fallback: 'https_only'),
      otpStorage: JsonReaders.string(json, 'otp_storage', fallback: 'hashed'),
    );
  }

  static const SecurityConfigModel defaults = SecurityConfigModel();
}
