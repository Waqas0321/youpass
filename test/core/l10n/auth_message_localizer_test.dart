import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/l10n/auth_message_localizer.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/l10n/app_localizations.dart';

void main() {
  test('maps API error codes to English messages', () {
    final l10n = lookupAppLocalizations(AppLocale.english);

    expect(
      AuthMessageLocalizer.fromApiError(
        l10n,
        code: 'USER_NOT_FOUND',
      ),
      'No account found for this number',
    );

    expect(
      AuthMessageLocalizer.fromApiError(
        l10n,
        code: 'RESEND_COOLDOWN',
        retryAfterSeconds: 51,
      ),
      'Resend code in 51 seconds',
    );
  });

  test('maps incorrect code fallback to localized message', () {
    final l10n = lookupAppLocalizations(AppLocale.english);

    expect(
      AuthMessageLocalizer.fromApiError(
        l10n,
        fallbackMessage: 'Código incorrecto',
      ),
      'Incorrect code',
    );
  });
}
