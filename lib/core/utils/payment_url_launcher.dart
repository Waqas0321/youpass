import 'package:url_launcher/url_launcher.dart';

class PaymentUrlLauncher {
  PaymentUrlLauncher._();

  static Future<bool> openExternalUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return false;
    }

    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
