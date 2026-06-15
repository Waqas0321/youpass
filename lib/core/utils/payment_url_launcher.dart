import 'package:url_launcher/url_launcher.dart';

class PaymentUrlLauncher {
  PaymentUrlLauncher._();

  static Future<bool> canOpenExternalUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return false;
    }

    return canLaunchUrl(uri);
  }

  static Future<bool> openExternalUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return false;
    }

    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<bool> openMailto(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return false;
    }

    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
