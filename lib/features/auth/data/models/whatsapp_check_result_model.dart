import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/domain/entities/whatsapp_check_result_entity.dart';

class WhatsAppCheckResultModel extends WhatsAppCheckResultEntity {
  const WhatsAppCheckResultModel({
    required super.phone,
    required super.whatsappAvailable,
    required super.deliveryChannel,
    required super.message,
  });

  factory WhatsAppCheckResultModel.fromJson(Map<String, dynamic> json) {
    return WhatsAppCheckResultModel(
      phone: JsonReaders.string(json, 'phone'),
      whatsappAvailable: JsonReaders.boolean(
        json,
        'whatsapp_available',
        fallback: true,
      ),
      deliveryChannel: JsonReaders.string(
        json,
        'delivery_channel',
        fallback: 'whatsapp',
      ),
      message: JsonReaders.string(json, 'message'),
    );
  }
}
