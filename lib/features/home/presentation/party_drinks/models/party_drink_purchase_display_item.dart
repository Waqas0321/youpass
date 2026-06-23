import 'package:youpass/features/home/data/models/event_drink_order_response_model.dart';

class PartyDrinkPurchaseDisplayItem {
  const PartyDrinkPurchaseDisplayItem({
    required this.order,
    required this.line,
  });

  final EventDrinkOrderModel order;
  final EventDrinkOrderLineModel line;

  bool get isRedeemed =>
      line.isRedeemed || order.status == 'redeemed';

  bool get canViewQr => !isRedeemed;

  String get displayOrderId {
    final fromApi = order.displayOrderId;
    if (fromApi != null && fromApi.isNotEmpty) {
      return fromApi;
    }
    final suffix = order.orderId.length >= 5
        ? order.orderId.substring(order.orderId.length - 5).toUpperCase()
        : order.orderId.toUpperCase();
    return '#$suffix';
  }
}
