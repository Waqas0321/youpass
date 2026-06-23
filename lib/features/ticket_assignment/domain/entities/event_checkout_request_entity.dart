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
    this.lockId,
  });

  final int? quantity;
  final String? tier;
  final String? type;
  final String? paymentMethodId;
  final String? offeringId;
  final List<EventCheckoutOfferingItemEntity>? items;
  final String? tableId;
  final String? zoneId;
  final String? lockId;

  EventCheckoutRequestEntity copyWith({
    int? quantity,
    String? tier,
    String? type,
    String? paymentMethodId,
    String? offeringId,
    List<EventCheckoutOfferingItemEntity>? items,
    String? tableId,
    String? zoneId,
    String? lockId,
  }) {
    return EventCheckoutRequestEntity(
      quantity: quantity ?? this.quantity,
      tier: tier ?? this.tier,
      type: type ?? this.type,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      offeringId: offeringId ?? this.offeringId,
      items: items ?? this.items,
      tableId: tableId ?? this.tableId,
      zoneId: zoneId ?? this.zoneId,
      lockId: lockId ?? this.lockId,
    );
  }

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
        lockId,
      ];
}
