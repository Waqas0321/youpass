import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/domain/entities/send_code_result_entity.dart';

class SendCodeResponseModel extends SendCodeResultEntity {
  const SendCodeResponseModel({
    required super.message,
    required super.phone,
    required super.purpose,
    required super.channel,
    required super.expiresInSeconds,
    required super.resendAvailableInSeconds,
    required super.phoneDisplay,
    super.accountExists,
    super.otpLength,
    super.maxResendsPerHour,
    super.maxFailedAttempts,
    super.blockMinutes,
    super.whatsappAvailable,
    super.devOtpCode,
  });

  factory SendCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return SendCodeResponseModel(
      message: JsonReaders.string(json, 'message'),
      phone: JsonReaders.string(json, 'phone'),
      purpose: JsonReaders.string(json, 'purpose'),
      channel: JsonReaders.string(json, 'channel', fallback: 'whatsapp'),
      expiresInSeconds: JsonReaders.integer(json, 'expires_in_seconds', fallback: 180),
      resendAvailableInSeconds: JsonReaders.integer(
        json,
        'resend_available_in_seconds',
        fallback: 60,
      ),
      phoneDisplay: JsonReaders.string(
        json,
        'phone_display',
        fallback: JsonReaders.string(json, 'phone'),
      ),
      accountExists: json['account_exists'] as bool?,
      otpLength: JsonReaders.integer(json, 'otp_length', fallback: 6),
      maxResendsPerHour: JsonReaders.integer(json, 'max_resends_per_hour', fallback: 5),
      maxFailedAttempts: JsonReaders.integer(json, 'max_failed_attempts', fallback: 3),
      blockMinutes: JsonReaders.integer(json, 'block_minutes', fallback: 15),
      whatsappAvailable: json['whatsapp_available'] as bool? ?? true,
      devOtpCode: json['dev_otp_code'] as String?,
    );
  }
}
