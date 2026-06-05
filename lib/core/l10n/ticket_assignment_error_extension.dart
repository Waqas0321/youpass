import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_provider.dart';
import 'package:youpass/l10n/app_localizations.dart';

extension TicketAssignmentProviderErrorExtension on TicketAssignmentProvider {
  String? localizedErrorMessage(AppLocalizations l10n) {
    if (errorMessage == null || errorMessage!.trim().isEmpty) {
      return null;
    }

    return AppMessageLocalizer.fromApiError(
      l10n,
      code: errorCode,
      fallbackMessage: errorMessage,
    );
  }
}
