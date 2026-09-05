import 'package:youpass/l10n/app_localizations.dart';

class WaitlistMessageLocalizer {
  WaitlistMessageLocalizer._();

  static String? fromApiError(AppLocalizations l10n, {String? code}) {
    switch (code) {
      case 'ALREADY_HAS_COURTESY':
        return l10n.waitlistAlreadyHasCourtesy;
      case 'ALREADY_ON_WAITLIST':
        return l10n.waitlistAlreadyOnWaitlist;
      case 'WAITLIST_DISABLED':
        return l10n.waitlistDisabled;
      case 'WAITLIST_NOT_AVAILABLE':
        return l10n.waitlistNotAvailable;
      default:
        return null;
    }
  }
}
