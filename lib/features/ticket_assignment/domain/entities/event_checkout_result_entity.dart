import 'package:equatable/equatable.dart';

class EventCheckoutResultEntity extends Equatable {
  const EventCheckoutResultEntity({
    required this.orderId,
    required this.eventTitle,
    required this.quantity,
    required this.totalAmount,
    required this.currency,
    required this.availableToAssign,
  });

  final String orderId;
  final String eventTitle;
  final int quantity;
  final num totalAmount;
  final String currency;
  final int availableToAssign;

  @override
  List<Object?> get props => [
        orderId,
        eventTitle,
        quantity,
        totalAmount,
        currency,
        availableToAssign,
      ];
}
