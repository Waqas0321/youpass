import 'package:equatable/equatable.dart';

class EventAvailabilityEntity extends Equatable {
  const EventAvailabilityEntity({
    required this.isSoldOut,
    required this.hasGeneralTickets,
    required this.hasVipTickets,
  });

  final bool isSoldOut;
  final bool hasGeneralTickets;
  final bool hasVipTickets;

  bool get hasAnyTickets => hasGeneralTickets || hasVipTickets;

  @override
  List<Object?> get props => [isSoldOut, hasGeneralTickets, hasVipTickets];
}
