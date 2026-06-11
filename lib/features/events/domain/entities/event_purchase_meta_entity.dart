import 'package:equatable/equatable.dart';

class EventPurchaseMetaEntity extends Equatable {
  const EventPurchaseMetaEntity({
    required this.serviceFeeRate,
    required this.currency,
    required this.hasTicketOfferings,
    required this.hasVenueLayout,
    this.paymentGateway = 'klap',
    this.countryCode = 'CL',
  });

  final double serviceFeeRate;
  final String currency;
  final bool hasTicketOfferings;
  final bool hasVenueLayout;
  final String paymentGateway;
  final String countryCode;

  @override
  List<Object?> get props => [
        serviceFeeRate,
        currency,
        hasTicketOfferings,
        hasVenueLayout,
        paymentGateway,
        countryCode,
      ];
}
