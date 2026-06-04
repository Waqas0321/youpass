import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/l10n/app_localizations.dart';

extension InvitationsProviderErrorExtension on InvitationsProvider {
  String? localizedErrorMessage(AppLocalizations l10n) {
    if (errorCode == null && (errorMessage == null || errorMessage!.isEmpty)) {
      return null;
    }

    return AppMessageLocalizer.fromApiError(
      l10n,
      code: errorCode,
      fallbackMessage: errorMessage,
    );
  }
}
