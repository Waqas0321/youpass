class VerificationRouteArgs {
  const VerificationRouteArgs({
    required this.phone,
    required this.countryIsoCode,
    required this.phoneDisplay,
    required this.resendCooldownSeconds,
    required this.expiresInSeconds,
    this.prefillOtpCode,
  });

  final String phone;
  final String countryIsoCode;
  final String phoneDisplay;
  final int resendCooldownSeconds;
  final int expiresInSeconds;

  /// Dev OTP from API (`dev_otp_code`). WhatsApp SMS autofill uses [AutofillHints.oneTimeCode].
  final String? prefillOtpCode;
}
