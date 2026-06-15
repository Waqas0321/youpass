import 'package:youpass/l10n/app_localizations.dart';

class VipCheckoutMessageLocalizer {
  VipCheckoutMessageLocalizer._();

  static String? fromApiError(
    AppLocalizations l10n, {
    String? code,
  }) {
    switch (code) {
      case 'INSUFFICIENT_STOCK':
        return l10n.errorCheckoutInsufficientStock;
      case 'TICKET_OFFERING_SOLD_OUT':
        return l10n.errorCheckoutOfferingSoldOut;
      case 'TABLE_LOCK_REQUIRED':
        return l10n.errorCheckoutTableLockRequired;
      case 'TABLE_NOT_AVAILABLE':
        return l10n.errorCheckoutTableNotAvailable;
      case 'TABLE_LOCKED':
        return l10n.errorCheckoutTableLocked;
      case 'TICKET_OFFERING_NOT_FOUND':
        return l10n.errorCheckoutOfferingNotFound;
    }

    return null;
  }
}
