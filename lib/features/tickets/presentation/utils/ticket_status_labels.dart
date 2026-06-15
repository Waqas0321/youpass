import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_display_status.dart';
import 'package:youpass/l10n/app_localizations.dart';

class TicketStatusLabels {
  TicketStatusLabels._();

  static String label(AppLocalizations strings, TicketDisplayStatus status) {
    switch (status) {
      case TicketDisplayStatus.active:
        return AppStrings.ticketsStatusActive(strings);
      case TicketDisplayStatus.validated:
        return AppStrings.ticketsStatusValidated(strings);
      case TicketDisplayStatus.expired:
        return AppStrings.ticketsStatusExpired(strings);
      case TicketDisplayStatus.cancelled:
        return AppStrings.ticketsStatusCancelled(strings);
      case TicketDisplayStatus.refunded:
        return AppStrings.ticketsStatusRefunded(strings);
    }
  }
}
