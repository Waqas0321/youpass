class StaffSendCodeResponse {
  const StaffSendCodeResponse({
    required this.message,
    required this.phone,
    required this.phoneDisplay,
    required this.expiresInSeconds,
    required this.resendAvailableInSeconds,
    this.devOtpCode,
  });

  final String message;
  final String phone;
  final String phoneDisplay;
  final int expiresInSeconds;
  final int resendAvailableInSeconds;
  final String? devOtpCode;

  factory StaffSendCodeResponse.fromJson(Map<String, dynamic> json) {
    return StaffSendCodeResponse(
      message: json['message'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      phoneDisplay: json['phone_display'] as String? ?? json['phone'] as String? ?? '',
      expiresInSeconds: (json['expires_in_seconds'] as num?)?.toInt() ?? 180,
      resendAvailableInSeconds:
          (json['resend_available_in_seconds'] as num?)?.toInt() ?? 60,
      devOtpCode: json['dev_otp_code'] as String?,
    );
  }
}
