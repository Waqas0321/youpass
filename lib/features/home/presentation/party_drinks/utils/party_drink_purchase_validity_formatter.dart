import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_calculator.dart';
import 'package:youpass/l10n/app_localizations.dart';

class PartyDrinkPurchaseValidityFormatter {
  PartyDrinkPurchaseValidityFormatter._();

  static String formatTarget(
    AppLocalizations l10n,
    PartyDrinkCartSummary cart,
  ) {
    if (cart.lineItems.length == 1) {
      final line = cart.lineItems.first;
      return '${line.quantity} ${line.drink.displayName(l10n)}';
    }

    return AppStrings.partyDrinkCheckoutProducts(l10n, cart.itemCount);
  }
}
