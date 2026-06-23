import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_quantities.dart';

void main() {
  group('PartyDrinkCartQuantities', () {
    test('read returns zero for missing drink', () {
      expect(PartyDrinkCartQuantities.read({}, 'piscola'), 0);
    });

    test('adjust increments and decrements quantities', () {
      final quantities = <String, int>{};

      PartyDrinkCartQuantities.adjust(quantities, 'piscola', 1);
      expect(quantities['piscola'], 1);

      PartyDrinkCartQuantities.adjust(quantities, 'piscola', 1);
      expect(quantities['piscola'], 2);

      PartyDrinkCartQuantities.adjust(quantities, 'piscola', -1);
      expect(quantities['piscola'], 1);

      PartyDrinkCartQuantities.adjust(quantities, 'piscola', -1);
      expect(quantities.containsKey('piscola'), isFalse);
    });

    test('copy creates an independent map', () {
      final original = {'piscola': 2};
      final copied = PartyDrinkCartQuantities.copy(original);

      copied['piscola'] = 5;
      expect(original['piscola'], 2);
    });
  });
}
