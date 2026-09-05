import 'package:youpass/core/l10n/auth_message_localizer.dart';
import 'package:youpass/core/l10n/ticket_assignment_message_localizer.dart';
import 'package:youpass/core/l10n/vip_checkout_message_localizer.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/features/waitlist/presentation/utils/waitlist_message_localizer.dart';
import 'package:youpass/l10n/app_localizations.dart';

class AppMessageLocalizer {
  AppMessageLocalizer._();

  static String fromApiError(
    AppLocalizations l10n, {
    String? code,
    String? fallbackMessage,
    int? retryAfterSeconds,
  }) {
    final waitlistMessage = WaitlistMessageLocalizer.fromApiError(
      l10n,
      code: code,
    );
    if (waitlistMessage != null) {
      return waitlistMessage;
    }

    final ticketAssignmentMessage = TicketAssignmentMessageLocalizer.fromApiError(
      l10n,
      code: code,
    );
    if (ticketAssignmentMessage != null) {
      return ticketAssignmentMessage;
    }

    final vipCheckoutMessage = VipCheckoutMessageLocalizer.fromApiError(
      l10n,
      code: code,
    );
    if (vipCheckoutMessage != null) {
      return vipCheckoutMessage;
    }

    return AuthMessageLocalizer.fromApiError(
      l10n,
      code: code,
      fallbackMessage: fallbackMessage,
      retryAfterSeconds: retryAfterSeconds,
    );
  }

  static String fromError(AppLocalizations l10n, Object error) {
    if (error is ApiException) {
      return fromApiError(
        l10n,
        code: error.code,
        fallbackMessage: error.message,
        retryAfterSeconds: error.retryAfterSeconds,
      );
    }

    return l10n.errorGeneric;
  }
}
