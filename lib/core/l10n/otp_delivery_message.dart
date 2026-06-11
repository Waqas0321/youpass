import 'package:youpass/l10n/app_localizations.dart';

class OtpDeliveryMessage {
  OtpDeliveryMessage._();

  /// YouPass delivers OTP exclusively via WhatsApp Business.
  static String sentConfirmation(AppLocalizations l10n) {
    return l10n.codeSentWhatsApp;
  }
}
