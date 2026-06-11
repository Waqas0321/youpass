import 'package:youpass/features/auth/domain/entities/whatsapp_check_result_entity.dart';

class WhatsAppAuthGate {
  WhatsAppAuthGate._();

  static bool canSendOtp(WhatsAppCheckResultEntity check) {
    return check.canReceiveOtp;
  }

  static String unavailableMessage(WhatsAppCheckResultEntity check) {
    if (check.message.trim().isNotEmpty) {
      return check.message.trim();
    }
    return '';
  }
}
