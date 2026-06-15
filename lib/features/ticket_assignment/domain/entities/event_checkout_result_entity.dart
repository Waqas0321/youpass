import 'package:equatable/equatable.dart';

class EventCheckoutResultEntity extends Equatable {
  const EventCheckoutResultEntity({
    required this.orderId,
    required this.eventTitle,
    required this.quantity,
    required this.totalAmount,
    required this.currency,
    required this.availableToAssign,
    this.status = 'paid',
    this.gateway,
    this.ticketId,
    this.seatLabel,
    this.qrUnlockAt,
    this.subtotalAmount,
    this.serviceFeeAmount,
    this.paymentUrl,
    this.stripeClientSecret,
    this.serviceFeeRate,
    this.paymentReference,
    this.eventId,
    this.tableId,
    this.zoneId,
  });

  final String orderId;
  final String eventTitle;
  final int quantity;
  final num totalAmount;
  final String currency;
  final int availableToAssign;
  final String status;
  final String? gateway;
  final String? ticketId;
  final String? seatLabel;
  final DateTime? qrUnlockAt;
  final num? subtotalAmount;
  final num? serviceFeeAmount;
  final String? paymentUrl;
  final String? stripeClientSecret;
  final double? serviceFeeRate;
  final String? paymentReference;
  final String? eventId;
  final String? tableId;
  final String? zoneId;

  bool get isPaid => status == 'paid';

  bool get isPaymentPending => status == 'payment_pending';

  @override
  List<Object?> get props => [
        orderId,
        eventTitle,
        quantity,
        totalAmount,
        currency,
        availableToAssign,
        status,
        gateway,
        ticketId,
        seatLabel,
        qrUnlockAt,
        subtotalAmount,
        serviceFeeAmount,
        paymentUrl,
        stripeClientSecret,
        serviceFeeRate,
        paymentReference,
        eventId,
        tableId,
        zoneId,
      ];
}
