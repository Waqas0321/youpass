import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/presentation/party_drinks/data/party_drink_catalog.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_calculator.dart';

void main() {
  group('PartyDrinkCartCalculator', () {
    final drinks = PartyDrinkCatalog.drinks;

    test('returns empty summary when no quantities', () {
      final summary = PartyDrinkCartCalculator.summarize({}, drinks);

      expect(summary.hasItems, isFalse);
      expect(summary.itemCount, 0);
      expect(summary.totalClp, 0);
      expect(summary.lineItems, isEmpty);
    });

    test('sums quantities and prices across drinks', () {
      final summary = PartyDrinkCartCalculator.summarize({
        'piscola': 2,
        'jager-bomb': 1,
      }, drinks);

      expect(summary.hasItems, isTrue);
      expect(summary.itemCount, 3);
      expect(summary.totalClp, 14000);
      expect(summary.lineItems, hasLength(2));
    });

    test('includes service charge in grand total', () {
      final summary = PartyDrinkCartCalculator.summarize({'piscola': 1}, drinks);

      expect(summary.subtotalClp, 4500);
      expect(summary.serviceChargeClp, 1000);
      expect(summary.grandTotalClp, 5500);
    });

    test('ignores zero or missing quantities', () {
      final summary = PartyDrinkCartCalculator.summarize({
        'piscola': 0,
        'unknown': 3,
      }, drinks);

      expect(summary.hasItems, isFalse);
      expect(summary.itemCount, 0);
      expect(summary.totalClp, 0);
    });
  });
}
