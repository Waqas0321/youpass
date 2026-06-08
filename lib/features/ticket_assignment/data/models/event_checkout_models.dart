import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_result_entity.dart';

class EventCheckoutRequestModel extends EventCheckoutRequestEntity {
  const EventCheckoutRequestModel({
    super.quantity,
    super.tier,
    super.type,
    super.paymentMethodId,
    super.offeringId,
    super.items,
    super.tableId,
    super.zoneId,
  });

  Map<String, dynamic> toJson() {
    if (tableId != null && tableId!.isNotEmpty) {
      return {
        'table_id': tableId,
        if (zoneId != null && zoneId!.isNotEmpty) 'zone_id': zoneId,
        'tier': tier ?? 'vip',
        'type': type ?? 'vip_table',
        if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
      };
    }

    if (items != null && items!.length > 1) {
      return {
        'items': items!
            .map(
              (item) => {
                'offering_id': item.offeringId,
                'quantity': item.quantity,
              },
            )
            .toList(),
        if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
      };
    }

    if (offeringId != null && offeringId!.isNotEmpty) {
      return {
        'offering_id': offeringId,
        'quantity': quantity ?? items?.first.quantity ?? 1,
        if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
      };
    }

    if (items != null && items!.length == 1) {
      final item = items!.first;
      return {
        'offering_id': item.offeringId,
        'quantity': item.quantity,
        if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
      };
    }

    return {
      'quantity': quantity ?? 1,
      'tier': tier ?? 'general',
      'type': type ?? 'general',
      if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
    };
  }
}

class EventCheckoutResultModel extends EventCheckoutResultEntity {
  const EventCheckoutResultModel({
    required super.orderId,
    required super.eventTitle,
    required super.quantity,
    required super.totalAmount,
    required super.currency,
    required super.availableToAssign,
    super.ticketId,
    super.seatLabel,
    super.qrUnlockAt,
    super.subtotalAmount,
    super.serviceFeeAmount,
  });

  factory EventCheckoutResultModel.fromJson(Map<String, dynamic> json) {
    final qrUnlockRaw =
        json['qr_unlock_at']?.toString() ?? json['qrUnlockAt']?.toString();

    return EventCheckoutResultModel(
      orderId: json['order_id']?.toString() ?? json['orderId']?.toString() ?? '',
      eventTitle:
          json['event_title']?.toString() ?? json['eventTitle']?.toString() ?? '',
      quantity: _readInt(json['quantity']),
      totalAmount: json['total_amount'] ?? json['totalAmount'] ?? 0,
      currency: json['currency']?.toString() ?? 'CLP',
      availableToAssign: _readInt(
        json['available_to_assign'] ?? json['availableToAssign'],
      ),
      ticketId: json['ticket_id']?.toString() ?? json['ticketId']?.toString(),
      seatLabel:
          json['seat_label']?.toString() ?? json['seatLabel']?.toString(),
      qrUnlockAt:
          qrUnlockRaw == null ? null : DateTime.tryParse(qrUnlockRaw),
      subtotalAmount: json['subtotal_amount'] ?? json['subtotalAmount'],
      serviceFeeAmount: json['service_fee_amount'] ?? json['serviceFeeAmount'],
    );
  }

  static int _readInt(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
