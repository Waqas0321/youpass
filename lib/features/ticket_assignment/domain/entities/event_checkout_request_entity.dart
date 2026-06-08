import 'package:equatable/equatable.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_offering_item_entity.dart';

class EventCheckoutRequestEntity extends Equatable {
  const EventCheckoutRequestEntity({
    this.quantity,
    this.tier,
    this.type,
    this.paymentMethodId,
    this.offeringId,
    this.items,
    this.tableId,
    this.zoneId,
  });

  final int? quantity;
  final String? tier;
  final String? type;
  final String? paymentMethodId;
  final String? offeringId;
  final List<EventCheckoutOfferingItemEntity>? items;
  final String? tableId;
  final String? zoneId;

  @override
  List<Object?> get props => [
        quantity,
        tier,
        type,
        paymentMethodId,
        offeringId,
        items,
        tableId,
        zoneId,
      ];
}
