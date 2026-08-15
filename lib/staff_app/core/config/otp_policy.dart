import 'package:youpass/staff_app/core/constants/otp_constants.dart';

class OtpPolicy {
  OtpPolicy._();

  static int get codeLength => OtpConstants.fallbackCodeLength;

  static int get resendCooldownSeconds => OtpConstants.fallbackResendCooldownSeconds;

  static int get otpTtlSeconds => OtpConstants.fallbackOtpTtlSeconds;

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
