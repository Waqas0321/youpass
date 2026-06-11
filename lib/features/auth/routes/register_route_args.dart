class RegisterRouteArgs {
  const RegisterRouteArgs({
    this.phone,
    this.countryIsoCode,
    this.phoneDisplay,
    this.resendCooldownSeconds = 60,
    this.expiresInSeconds,
    this.codeAlreadySent = false,
    this.otpCode,
  });

  final String? phone;
  final String? countryIsoCode;
  /// E.164-style display from send-code (e.g. `+92 321 6548001`).
  final String? phoneDisplay;
  final int resendCooldownSeconds;
  final int? expiresInSeconds;
  final bool codeAlreadySent;
  /// OTP collected on the verification screen before the registration wizard.
  final String? otpCode;
}
