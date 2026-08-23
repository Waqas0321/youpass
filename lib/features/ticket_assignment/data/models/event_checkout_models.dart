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
    super.lockId,
  });

  Map<String, dynamic> toJson() {
    if (tableId != null && tableId!.isNotEmpty) {
      return {
        'table_id': tableId,
        if (zoneId != null && zoneId!.isNotEmpty) 'zone_id': zoneId,
        'tier': tier ?? 'vip',
        'type': type ?? 'vip_table',
        if (lockId != null && lockId!.isNotEmpty) 'lock_id': lockId,
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
    super.status = 'paid',
    super.gateway,
    super.ticketId,
    super.seatLabel,
    super.qrUnlockAt,
    super.subtotalAmount,
    super.serviceFeeAmount,
    super.paymentUrl,
    super.stripeClientSecret,
    super.serviceFeeRate,
    super.paymentReference,
    super.eventId,
    super.tableId,
    super.zoneId,
  });

  factory EventCheckoutResultModel.fromJson(Map<String, dynamic> json) {
    final qrUnlockRaw =
        json['qr_unlock_at']?.toString() ?? json['qrUnlockAt']?.toString();
    final stripeRaw = json['stripe'];
    String? stripeClientSecret;
    if (stripeRaw is Map<String, dynamic>) {
      stripeClientSecret = stripeRaw['client_secret']?.toString() ??
          stripeRaw['clientSecret']?.toString();
    }

    final kushkiRaw = json['kushki'];
    final klapRaw = json['klap'];
    final nestedPaymentUrl = kushkiRaw is Map<String, dynamic>
        ? kushkiRaw['payment_url']?.toString() ??
            kushkiRaw['paymentUrl']?.toString()
        : klapRaw is Map<String, dynamic>
            ? klapRaw['payment_url']?.toString() ??
                klapRaw['paymentUrl']?.toString()
            : null;

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
      status: json['status']?.toString() ?? 'paid',
      gateway: json['gateway']?.toString(),
      ticketId: json['ticket_id']?.toString() ?? json['ticketId']?.toString(),
      seatLabel:
          json['seat_label']?.toString() ?? json['seatLabel']?.toString(),
      qrUnlockAt:
          qrUnlockRaw == null ? null : DateTime.tryParse(qrUnlockRaw),
      subtotalAmount: json['subtotal_amount'] ?? json['subtotalAmount'],
      serviceFeeAmount: json['service_fee_amount'] ?? json['serviceFeeAmount'],
      paymentUrl: json['payment_url']?.toString() ??
          json['paymentUrl']?.toString() ??
          nestedPaymentUrl,
      stripeClientSecret: stripeClientSecret,
      serviceFeeRate: _readDouble(json['service_fee_rate'] ?? json['serviceFeeRate']),
      paymentReference: json['payment_reference']?.toString() ??
          json['paymentReference']?.toString(),
      eventId: json['event_id']?.toString() ?? json['eventId']?.toString(),
      tableId: json['table_id']?.toString() ?? json['tableId']?.toString(),
      zoneId: json['zone_id']?.toString() ?? json['zoneId']?.toString(),
    );
  }

  static double? _readDouble(Object? value) {
    if (value is num) {
      return value.toDouble();
    }
    return null;
  }

  static int _readInt(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class EventCheckoutConfirmRequestModel {
  const EventCheckoutConfirmRequestModel({
    required this.orderId,
    this.paymentIntentId,
  });

  final String orderId;
  final String? paymentIntentId;

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      if (paymentIntentId != null && paymentIntentId!.isNotEmpty)
        'payment_intent_id': paymentIntentId,
    };
  }
}
