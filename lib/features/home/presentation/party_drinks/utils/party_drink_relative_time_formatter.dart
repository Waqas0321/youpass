import 'package:youpass/l10n/app_localizations.dart';

class PartyDrinkRelativeTimeFormatter {
  PartyDrinkRelativeTimeFormatter._();

  static String format(AppLocalizations l10n, String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) {
      return l10n.partyDrinkPurchasesJustNow;
    }

    final parsed = DateTime.tryParse(isoDate);
    if (parsed == null) {
      return l10n.partyDrinkPurchasesJustNow;
    }

    final diff = DateTime.now().difference(parsed.toLocal());
    if (diff.inMinutes < 1) {
      return l10n.partyDrinkPurchasesJustNow;
    }
    if (diff.inMinutes < 60) {
      return l10n.partyDrinkPurchasesMinutesAgo(diff.inMinutes);
    }
    if (diff.inHours < 24) {
      return l10n.partyDrinkPurchasesHoursAgo(diff.inHours);
    }
    return l10n.partyDrinkPurchasesDaysAgo(diff.inDays);
  }
}
