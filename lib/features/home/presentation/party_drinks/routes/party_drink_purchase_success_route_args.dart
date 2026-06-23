import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_calculator.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_purchase_confirmation_factory.dart';
import 'package:youpass/l10n/app_localizations.dart';

class PartyDrinkPurchaseSuccessRouteArgs {
  const PartyDrinkPurchaseSuccessRouteArgs({
    required this.confirmations,
    this.initialIndex = 0,
  });

  final List<PartyDrinkPurchaseConfirmation> confirmations;
  final int initialIndex;

  PartyDrinkPurchaseConfirmation get confirmation {
    if (confirmations.isEmpty) {
      return const PartyDrinkPurchaseConfirmation(
        entryCode: '',
        qrPayload: '',
        validityTarget: '',
      );
    }
    final index = initialIndex.clamp(0, confirmations.length - 1);
    return confirmations[index];
  }

  factory PartyDrinkPurchaseSuccessRouteArgs.fromCart(
    PartyDrinkCartSummary cart,
    AppLocalizations l10n,
  ) {
    return PartyDrinkPurchaseSuccessRouteArgs(
      confirmations: [
        PartyDrinkPurchaseConfirmationFactory.fromCart(cart, l10n),
      ],
    );
  }

  factory PartyDrinkPurchaseSuccessRouteArgs.fromConfirmation(
    PartyDrinkPurchaseConfirmation confirmation,
  ) {
    return PartyDrinkPurchaseSuccessRouteArgs(
      confirmations: [confirmation],
    );
  }

  factory PartyDrinkPurchaseSuccessRouteArgs.fromConfirmations(
    List<PartyDrinkPurchaseConfirmation> confirmations, {
    int initialIndex = 0,
  }) {
    return PartyDrinkPurchaseSuccessRouteArgs(
      confirmations: confirmations,
      initialIndex: initialIndex,
    );
  }
}
