import 'package:youpass/core/l10n/auth_message_localizer.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/l10n/app_localizations.dart';

extension AuthProviderErrorExtension on AuthProvider {
  String? localizedErrorMessage(AppLocalizations l10n) {
    if (errorCode == null && (errorMessage == null || errorMessage!.isEmpty)) {
      return null;
    }

    return AuthMessageLocalizer.fromApiError(
      l10n,
      code: errorCode,
      fallbackMessage: errorMessage,
      retryAfterSeconds: lastRetryAfterSeconds,
    );
  }
}
