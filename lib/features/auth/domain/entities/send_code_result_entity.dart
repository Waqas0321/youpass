import 'package:equatable/equatable.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';

class SendCodeResultEntity extends Equatable {
  const SendCodeResultEntity({
    required this.message,
    required this.phone,
    required this.purpose,
    required this.channel,
    required this.expiresInSeconds,
    required this.resendAvailableInSeconds,
    required this.phoneDisplay,
    this.accountExists,
    this.otpLength,
    this.maxResendsPerHour,
    this.maxFailedAttempts,
    this.blockMinutes,
    this.whatsappAvailable,
    this.devOtpCode,
  });

  final String message;
  final String phone;
  final String purpose;
  final String channel;
  final int expiresInSeconds;
  final int resendAvailableInSeconds;
  final String phoneDisplay;
  final bool? accountExists;
  final int? otpLength;
  final int? maxResendsPerHour;
  final int? maxFailedAttempts;
  final int? blockMinutes;
  final bool? whatsappAvailable;
  /// Present only when the backend runs with TWILIO_MOCK=true (local dev).
  final String? devOtpCode;

  OtpPurpose get effectivePurpose => OtpPurposeParsing.fromApiValue(purpose);

  @override
  List<Object?> get props => [
        message,
        phone,
        purpose,
        channel,
        expiresInSeconds,
        resendAvailableInSeconds,
        phoneDisplay,
        accountExists,
        otpLength,
        maxResendsPerHour,
        maxFailedAttempts,
        blockMinutes,
        whatsappAvailable,
        devOtpCode,
      ];
}
