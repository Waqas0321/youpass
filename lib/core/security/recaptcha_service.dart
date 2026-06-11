import 'package:youpass/core/security/app_security_config.dart';
import 'package:youpass/core/utils/app_logger.dart';

/// Obtains reCAPTCHA tokens for secured endpoints when enabled on the server.
///
/// Mobile token acquisition requires a reCAPTCHA Enterprise / WebView integration.
/// When disabled on the server, returns `null` and requests proceed without a token.
abstract class RecaptchaService {
  Future<String?> tokenFor(String action);
}

class RecaptchaServiceImpl implements RecaptchaService {
  @override
  Future<String?> tokenFor(String action) async {
    final security = AppSecurityConfig.current;
    if (!security.recaptchaEnabled) {
      return null;
    }

    if (security.recaptchaSiteKey.isEmpty) {
      AppLogger.warning(
        'reCAPTCHA enabled but site key missing — omitting token',
        tag: 'Security',
      );
      return null;
    }

    // Integration point: wire google_recaptcha_v3 / Enterprise SDK here.
    AppLogger.warning(
      'reCAPTCHA enabled ($action) but mobile token provider is not configured',
      tag: 'Security',
    );
    return null;
  }
}
