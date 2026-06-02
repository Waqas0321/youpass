import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/domain/entities/otp_delivery_result_entity.dart';

class OtpDeliveryResultModel extends OtpDeliveryResultEntity {
  const OtpDeliveryResultModel({
    required super.message,
    required super.phone,
    required super.phoneDisplay,
    required super.channel,
    required super.expiresInSeconds,
    required super.resendAvailableInSeconds,
  });

  factory OtpDeliveryResultModel.fromJson(Map<String, dynamic> json) {
    return OtpDeliveryResultModel(
      message: JsonReaders.string(json, 'message'),
      phone: JsonReaders.string(json, 'phone'),
      phoneDisplay: JsonReaders.string(
        json,
        'phone_display',
        fallback: JsonReaders.string(json, 'phone'),
      ),
      channel: JsonReaders.string(json, 'channel', fallback: 'whatsapp'),
      expiresInSeconds: JsonReaders.integer(json, 'expires_in_seconds'),
      resendAvailableInSeconds: JsonReaders.integer(
        json,
        'resend_available_in_seconds',
      ),
    );
  }
}
