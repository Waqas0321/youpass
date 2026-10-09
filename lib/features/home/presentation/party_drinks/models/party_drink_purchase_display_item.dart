import 'package:youpass/features/home/data/models/event_drink_order_response_model.dart';

class PartyDrinkPurchaseDisplayItem {
  const PartyDrinkPurchaseDisplayItem({
    required this.order,
    required this.line,
  });

  final EventDrinkOrderModel order;
  final EventDrinkOrderLineModel line;

  bool get isRedeemed => line.isRedeemed || order.status == 'redeemed';

  bool get canViewQr => !isRedeemed;

  String get displayOrderId {
    final fromApi = order.displayOrderId;
    if (fromApi != null && fromApi.isNotEmpty) {
      return fromApi;
    }
    // Mirrors the backend/admin format: #ORD- + last 7 chars of the order id.
    final suffix = order.orderId.length >= 7
        ? order.orderId.substring(order.orderId.length - 7).toUpperCase()
        : order.orderId.toUpperCase();
    return '#ORD-$suffix';
  }
}
