import 'package:equatable/equatable.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_section.dart';

class TicketOfferingEntity extends Equatable {
  const TicketOfferingEntity({
    required this.id,
    required this.label,
    required this.price,
    required this.section,
    this.type,
    this.name,
    this.status,
    this.offeringId,
    this.mapsToTier,
    this.mapsToType,
    this.currency = 'CLP',
    this.description,
    this.badgeLabel,
    this.quantity = 0,
    this.vouchersPerTicket = 1,
    this.isSoldOut = false,
    this.isSelectable = true,
  });

  final String id;
  final String label;
  final int price;
  final TicketOfferingSection section;
  final String? type;
  final String? name;
  final String? status;
  final String? offeringId;
  final String? mapsToTier;
  final String? mapsToType;
  final String currency;
  final String? description;
  final String? badgeLabel;
  final int quantity;
  final int vouchersPerTicket;
  final bool isSoldOut;
  final bool isSelectable;

  String get displayName => (name?.trim().isNotEmpty == true ? name!.trim() : label);

  /// MongoDB / checkout id — never use legacy slug alone when offering_id exists.
  String get checkoutOfferingId {
    final mongoId = offeringId?.trim();
    if (mongoId != null && mongoId.isNotEmpty) {
      return mongoId;
    }
    return id;
  }

  bool get isQuantitySelectable => isSelectable && !isSoldOut;

  int get lineTotal => price * quantity;

  int get totalVouchers => quantity * vouchersPerTicket;

  TicketOfferingEntity copyWith({
    int? quantity,
    bool? isSoldOut,
    bool? isSelectable,
  }) {
    return TicketOfferingEntity(
      id: id,
      label: label,
      price: price,
      section: section,
      type: type,
      name: name,
      status: status,
      offeringId: offeringId,
      mapsToTier: mapsToTier,
      mapsToType: mapsToType,
      currency: currency,
      description: description,
      badgeLabel: badgeLabel,
      quantity: quantity ?? this.quantity,
      vouchersPerTicket: vouchersPerTicket,
      isSoldOut: isSoldOut ?? this.isSoldOut,
      isSelectable: isSelectable ?? this.isSelectable,
    );
  }

  @override
  List<Object?> get props => [
        id,
        label,
        price,
        section,
        type,
        name,
        status,
        offeringId,
        mapsToTier,
        mapsToType,
        currency,
        description,
        badgeLabel,
        quantity,
        vouchersPerTicket,
        isSoldOut,
        isSelectable,
      ];
}
