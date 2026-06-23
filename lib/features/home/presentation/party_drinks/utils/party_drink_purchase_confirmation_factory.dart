import 'dart:math';

import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_calculator.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_purchase_validity_formatter.dart';
import 'package:youpass/l10n/app_localizations.dart';

class PartyDrinkPurchaseConfirmation {
  const PartyDrinkPurchaseConfirmation({
    required this.entryCode,
    required this.qrPayload,
    required this.validityTarget,
    this.orderId,
    this.lineId,
  });

  final String entryCode;
  final String qrPayload;
  final String validityTarget;
  final String? orderId;
  final String? lineId;
}

class PartyDrinkPurchaseConfirmationFactory {
  PartyDrinkPurchaseConfirmationFactory._();

  static const _codeChars = '0123456789ABCDEF';
  static final _random = Random();

  static PartyDrinkPurchaseConfirmation fromCart(
    PartyDrinkCartSummary cart,
    AppLocalizations l10n,
  ) {
    final entryCode = _generateEntryCode();

    return PartyDrinkPurchaseConfirmation(
      entryCode: entryCode,
      qrPayload: 'youpass:party-drink:$entryCode',
      validityTarget: PartyDrinkPurchaseValidityFormatter.formatTarget(
        l10n,
        cart,
      ),
    );
  }

  static String _generateEntryCode() {
    return List.generate(
      6,
      (_) => _codeChars[_random.nextInt(_codeChars.length)],
    ).join();
  }
}
