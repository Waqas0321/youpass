import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/domain/entities/whatsapp_check_result_entity.dart';

class WhatsAppCheckResultModel extends WhatsAppCheckResultEntity {
  const WhatsAppCheckResultModel({
    required super.phone,
    required super.whatsappAvailable,
    required super.canReceiveOtp,
    required super.deliveryChannel,
    required super.message,
    super.messageKey,
    super.authChannel,
    super.smsEnabled = false,
  });

  factory WhatsAppCheckResultModel.fromJson(Map<String, dynamic> json) {
    final whatsappAvailable = JsonReaders.boolean(
      json,
      'whatsapp_available',
      fallback: true,
    );
    final canReceiveOtp = JsonReaders.boolean(
      json,
      'can_receive_otp',
      fallback: whatsappAvailable,
    );

    return WhatsAppCheckResultModel(
      phone: JsonReaders.string(json, 'phone'),
      whatsappAvailable: whatsappAvailable,
      canReceiveOtp: canReceiveOtp,
      deliveryChannel: JsonReaders.string(
        json,
        'delivery_channel',
        fallback: 'whatsapp',
      ),
      message: JsonReaders.string(json, 'message'),
      messageKey: JsonReaders.nullableString(json, 'message_key'),
      authChannel: JsonReaders.nullableString(json, 'auth_channel'),
      smsEnabled: JsonReaders.boolean(json, 'sms_enabled', fallback: false),
    );
  }
}
