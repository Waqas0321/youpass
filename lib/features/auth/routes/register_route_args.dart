class RegisterRouteArgs {
  const RegisterRouteArgs({
    this.phone,
    this.countryIsoCode,
    this.phoneDisplay,
    this.resendCooldownSeconds = 60,
    this.codeAlreadySent = false,
  });

  final String? phone;
  final String? countryIsoCode;
  /// E.164-style display from send-code (e.g. `+92 321 6548001`).
  final String? phoneDisplay;
  final int resendCooldownSeconds;
  final bool codeAlreadySent;
}
