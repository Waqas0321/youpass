import 'package:equatable/equatable.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_entity.dart';

class TicketTypesBundleEntity extends Equatable {
  const TicketTypesBundleEntity({
    required this.eventId,
    required this.serviceFeeRate,
    required this.offerings,
    this.currency = 'CLP',
    this.currencyDecimals,
  });

  final String eventId;
  final double serviceFeeRate;
  final List<TicketOfferingEntity> offerings;
  final String currency;
  final int? currencyDecimals;

  @override
  List<Object?> get props =>
      [eventId, serviceFeeRate, offerings, currency, currencyDecimals];
}
