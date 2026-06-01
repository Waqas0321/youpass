import 'package:youpass/l10n/app_localizations.dart';

class OtpDeliveryMessage {
  OtpDeliveryMessage._();

  static String sentConfirmation(AppLocalizations l10n, String channel) {
    if (channel.toLowerCase() == 'whatsapp') {
      return l10n.codeSentWhatsApp;
    }
    return l10n.codeSentSms;
  }
}
