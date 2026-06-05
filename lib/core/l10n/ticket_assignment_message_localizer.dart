import 'package:youpass/l10n/app_localizations.dart';

class TicketAssignmentMessageLocalizer {
  TicketAssignmentMessageLocalizer._();

  static String? fromApiError(
    AppLocalizations l10n, {
    String? code,
  }) {
    switch (code) {
      case 'TICKET_ORDER_NOT_FOUND':
        return l10n.errorTicketOrderNotFound;
      case 'TICKET_SLOT_NOT_FOUND':
        return l10n.errorTicketSlotNotFound;
      case 'TICKET_SLOT_NOT_AVAILABLE':
        return l10n.errorTicketSlotNotAvailable;
      case 'WHATSAPP_SEND_FAILED':
        return l10n.errorWhatsAppSendFailed;
      case 'CANNOT_ASSIGN_TO_SELF':
        return l10n.errorCannotAssignToSelf;
      case 'CLAIM_NOT_FOUND':
        return l10n.errorClaimNotFound;
      case 'INVITATION_FORBIDDEN':
        return l10n.errorInvitationForbidden;
    }

    return null;
  }
}
