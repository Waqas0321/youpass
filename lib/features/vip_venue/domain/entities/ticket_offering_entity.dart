import 'package:equatable/equatable.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_section.dart';

class TicketOfferingEntity extends Equatable {
  const TicketOfferingEntity({
    required this.id,
    required this.label,
    required this.price,
    required this.section,
    this.offeringId,
    this.mapsToTier,
    this.mapsToType,
    this.currency = 'CLP',
    this.description,
    this.badgeLabel,
    this.quantity = 0,
    this.vouchersPerTicket = 1,
  });

  final String id;
  final String label;
  final int price;
  final TicketOfferingSection section;
  final String? offeringId;
  final String? mapsToTier;
  final String? mapsToType;
  final String currency;
  final String? description;
  final String? badgeLabel;
  final int quantity;
  final int vouchersPerTicket;

  int get lineTotal => price * quantity;

  int get totalVouchers => quantity * vouchersPerTicket;

  TicketOfferingEntity copyWith({int? quantity}) {
    return TicketOfferingEntity(
      id: id,
      label: label,
      price: price,
      section: section,
      offeringId: offeringId,
      mapsToTier: mapsToTier,
      mapsToType: mapsToType,
      currency: currency,
      description: description,
      badgeLabel: badgeLabel,
      quantity: quantity ?? this.quantity,
      vouchersPerTicket: vouchersPerTicket,
    );
  }

  @override
  List<Object?> get props => [
        id,
        label,
        price,
        section,
        offeringId,
        mapsToTier,
        mapsToType,
        currency,
        description,
        badgeLabel,
        quantity,
        vouchersPerTicket,
      ];
}
