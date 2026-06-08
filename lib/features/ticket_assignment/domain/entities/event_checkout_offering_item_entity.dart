import 'package:equatable/equatable.dart';

class EventCheckoutOfferingItemEntity extends Equatable {
  const EventCheckoutOfferingItemEntity({
    required this.offeringId,
    required this.quantity,
  });

  final String offeringId;
  final int quantity;

  @override
  List<Object?> get props => [offeringId, quantity];
}
