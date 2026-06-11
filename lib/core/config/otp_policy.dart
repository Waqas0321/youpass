import 'package:youpass/core/config/app_product_config.dart';
import 'package:youpass/core/constants/otp_constants.dart';

/// OTP UI limits driven by `/config/auth` — not hardcoded in widgets.
class OtpPolicy {
  OtpPolicy._();

  static int get codeLength =>
      AppProductConfig.auth.otpLength > 0
          ? AppProductConfig.auth.otpLength
          : OtpConstants.fallbackCodeLength;

  static int get resendCooldownSeconds =>
      AppProductConfig.auth.otpResendCooldownSeconds > 0
          ? AppProductConfig.auth.otpResendCooldownSeconds
          : OtpConstants.fallbackResendCooldownSeconds;

  static int get otpTtlSeconds {
    final fromConfig = AppProductConfig.auth.otpTtlSeconds;
    return fromConfig > 0 ? fromConfig : OtpConstants.fallbackOtpTtlSeconds;
  }

  static int get maxFailedAttempts => AppProductConfig.auth.otpMaxFailedAttempts;

  static int get blockMinutes => AppProductConfig.auth.otpBlockMinutes;

  static int resolveResendCooldown(int? fromApi) {
    if (fromApi != null && fromApi > 0) {
      return fromApi;
    }
    return resendCooldownSeconds;
  }

  static int resolveOtpTtl(int? fromApi) {
    if (fromApi != null && fromApi > 0) {
      return fromApi;
    }
    return otpTtlSeconds;
  }
}
