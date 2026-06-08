import 'package:equatable/equatable.dart';

class EventCheckoutResultEntity extends Equatable {
  const EventCheckoutResultEntity({
    required this.orderId,
    required this.eventTitle,
    required this.quantity,
    required this.totalAmount,
    required this.currency,
    required this.availableToAssign,
    this.ticketId,
    this.seatLabel,
    this.qrUnlockAt,
    this.subtotalAmount,
    this.serviceFeeAmount,
  });

  final String orderId;
  final String eventTitle;
  final int quantity;
  final num totalAmount;
  final String currency;
  final int availableToAssign;
  final String? ticketId;
  final String? seatLabel;
  final DateTime? qrUnlockAt;
  final num? subtotalAmount;
  final num? serviceFeeAmount;

  @override
  List<Object?> get props => [
        orderId,
        eventTitle,
        quantity,
        totalAmount,
        currency,
        availableToAssign,
        ticketId,
        seatLabel,
        qrUnlockAt,
        subtotalAmount,
        serviceFeeAmount,
      ];
}
