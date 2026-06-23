import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/presentation/party_drinks/data/party_drink_catalog.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_calculator.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_purchase_confirmation_factory.dart';
import 'package:youpass/l10n/app_localizations_en.dart';

void main() {
  group('PartyDrinkPurchaseConfirmationFactory', () {
    final l10n = AppLocalizationsEn();

    test('generates six character entry code and qr payload', () {
      final cart = PartyDrinkCartCalculator.summarize(
        {'jager-bomb': 1},
        PartyDrinkCatalog.drinks,
      );
      final confirmation = PartyDrinkPurchaseConfirmationFactory.fromCart(
        cart,
        l10n,
      );

      expect(confirmation.entryCode, hasLength(6));
      expect(
        confirmation.qrPayload,
        'youpass:party-drink:${confirmation.entryCode}',
      );
      expect(confirmation.validityTarget, '1 Jager Bomb');
    });

    test('uses product count when cart has multiple lines', () {
      final cart = PartyDrinkCartCalculator.summarize(
        {
          'piscola': 1,
          'jager-bomb': 1,
        },
        PartyDrinkCatalog.drinks,
      );
      final confirmation = PartyDrinkPurchaseConfirmationFactory.fromCart(
        cart,
        l10n,
      );

      expect(confirmation.validityTarget, '2 products');
    });
  });
}
