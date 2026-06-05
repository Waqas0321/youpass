import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_provider.dart';
import 'package:youpass/l10n/app_localizations.dart';

extension TicketsProviderErrorExtension on TicketsProvider {
  String? localizedUpcomingErrorMessage(AppLocalizations l10n) {
    if (upcomingErrorMessage == null || upcomingErrorMessage!.trim().isEmpty) {
      return null;
    }

    return AppMessageLocalizer.fromApiError(
      l10n,
      code: errorCode,
      fallbackMessage: upcomingErrorMessage,
    );
  }

  String? localizedPastErrorMessage(AppLocalizations l10n) {
    if (pastErrorMessage == null || pastErrorMessage!.trim().isEmpty) {
      return null;
    }

    return AppMessageLocalizer.fromApiError(
      l10n,
      code: errorCode,
      fallbackMessage: pastErrorMessage,
    );
  }
}
