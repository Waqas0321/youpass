import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_offering_item_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_request_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/vip_purchase_session.dart';

extension VipPurchaseSessionCheckout on VipPurchaseSession {
  EventCheckoutRequestEntity buildCheckoutRequest() {
    if (isVipTablePurchase) {
      final table = selectedTable!;
      final zone = selectedZone!;
      return EventCheckoutRequestEntity(
        tableId: table.id,
        zoneId: zone.id,
        tier: 'vip',
        type: 'vip_table',
      );
    }

    final selected = selectedOfferings;
    if (selected.length == 1) {
      final offering = selected.first;
      return EventCheckoutRequestEntity(
        offeringId: offering.offeringId ?? offering.id,
        quantity: offering.quantity,
        tier: offering.mapsToTier ?? 'general',
        type: offering.mapsToType ?? 'general',
      );
    }

    return EventCheckoutRequestEntity(
      items: selected
          .map(
            (offering) => EventCheckoutOfferingItemEntity(
              offeringId: offering.offeringId ?? offering.id,
              quantity: offering.quantity,
            ),
          )
          .toList(),
    );
  }
}
