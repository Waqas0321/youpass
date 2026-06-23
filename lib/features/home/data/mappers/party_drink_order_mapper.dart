import 'package:youpass/features/home/data/models/event_drink_order_response_model.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_purchase_confirmation_factory.dart';

class PartyDrinkOrderMapper {
  PartyDrinkOrderMapper._();

  static String formatLineValidityTarget(EventDrinkOrderLineModel line) {
    if (line.quantity <= 1) {
      return line.productName;
    }
    return '${line.quantity} ${line.productName}';
  }

  static PartyDrinkPurchaseConfirmation toConfirmationForLine(
    EventDrinkOrderModel order,
    EventDrinkOrderLineModel line,
  ) {
    return PartyDrinkPurchaseConfirmation(
      entryCode: line.entryCode ?? '',
      qrPayload: line.qrPayload ?? line.entryCode ?? '',
      validityTarget: formatLineValidityTarget(line),
      orderId: order.orderId,
      lineId: line.lineId,
    );
  }

  static List<PartyDrinkPurchaseConfirmation> toConfirmations(
    EventDrinkOrderModel order,
  ) {
    return order.lineItems
        .where((line) => line.entryCode?.isNotEmpty ?? false)
        .map((line) => toConfirmationForLine(order, line))
        .toList();
  }
}
