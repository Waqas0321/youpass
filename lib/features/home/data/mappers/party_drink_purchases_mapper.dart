import 'package:youpass/features/home/data/models/event_drink_order_response_model.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_purchase_display_item.dart';

class PartyDrinkPurchasesMapper {
  PartyDrinkPurchasesMapper._();

  static List<PartyDrinkPurchaseDisplayItem> flattenOrders(
    List<EventDrinkOrderModel> orders,
  ) {
    final items = <PartyDrinkPurchaseDisplayItem>[];

    for (final order in orders) {
      if (order.lineItems.isEmpty) {
        continue;
      }

      for (final line in order.lineItems) {
        items.add(PartyDrinkPurchaseDisplayItem(order: order, line: line));
      }
    }

    return items;
  }
}
