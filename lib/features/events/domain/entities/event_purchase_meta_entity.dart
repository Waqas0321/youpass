import 'package:equatable/equatable.dart';

class EventPurchaseMetaEntity extends Equatable {
  const EventPurchaseMetaEntity({
    required this.serviceFeeRate,
    required this.currency,
    required this.hasTicketOfferings,
    required this.hasVenueLayout,
  });

  final double serviceFeeRate;
  final String currency;
  final bool hasTicketOfferings;
  final bool hasVenueLayout;

  @override
  List<Object?> get props => [
        serviceFeeRate,
        currency,
        hasTicketOfferings,
        hasVenueLayout,
      ];
}
