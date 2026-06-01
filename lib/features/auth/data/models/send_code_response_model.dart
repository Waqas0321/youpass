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
  });

  factory SendCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return SendCodeResponseModel(
      message: json['message'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      purpose: json['purpose'] as String? ?? '',
      channel: json['channel'] as String? ?? 'whatsapp',
      expiresInSeconds: _readInt(json['expires_in_seconds']),
      resendAvailableInSeconds: _readInt(json['resend_available_in_seconds']),
      phoneDisplay: json['phone_display'] as String? ?? json['phone'] as String? ?? '',
      accountExists: json['account_exists'] as bool?,
    );
  }

  static int _readInt(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return 0;
  }
}
