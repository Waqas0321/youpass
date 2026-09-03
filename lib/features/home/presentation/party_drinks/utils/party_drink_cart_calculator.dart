import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_item.dart';

class PartyDrinkCartSummary {
  const PartyDrinkCartSummary({
    required this.itemCount,
    required this.totalClp,
    required this.lineItems,
  });

  final int itemCount;
  final int totalClp;
  final List<PartyDrinkCartLineItem> lineItems;

  bool get hasItems => itemCount > 0;

  int get subtotalClp => totalClp;

  /// Drink / product checkout has no service charge (tickets only).
  int get serviceChargeClp => 0;

  int get grandTotalClp => subtotalClp;
}

class PartyDrinkCartLineItem {
  const PartyDrinkCartLineItem({
    required this.drink,
    required this.quantity,
  });

  final PartyDrinkItem drink;
  final int quantity;

  int get subtotalClp => drink.priceClp * quantity;
}

class PartyDrinkCartCalculator {
  PartyDrinkCartCalculator._();

  static const int serviceChargeClp = 0;

  static PartyDrinkCartSummary summarize(
    Map<String, int> quantities,
    List<PartyDrinkItem> drinks,
  ) {
    final lineItems = <PartyDrinkCartLineItem>[];
    var itemCount = 0;
    var totalClp = 0;

    for (final drink in drinks) {
      final quantity = quantities[drink.id] ?? 0;
      if (quantity <= 0) {
        continue;
      }

      lineItems.add(PartyDrinkCartLineItem(drink: drink, quantity: quantity));
      itemCount += quantity;
      totalClp += drink.priceClp * quantity;
    }

    return PartyDrinkCartSummary(
      itemCount: itemCount,
      totalClp: totalClp,
      lineItems: lineItems,
    );
  }
}
