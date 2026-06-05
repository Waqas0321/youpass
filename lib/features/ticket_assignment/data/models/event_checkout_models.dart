import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_result_entity.dart';

class EventCheckoutRequestModel extends EventCheckoutRequestEntity {
  const EventCheckoutRequestModel({
    required super.quantity,
    required super.tier,
    required super.type,
    super.paymentMethodId,
  });

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'tier': tier,
      'type': type,
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
  });

  factory EventCheckoutResultModel.fromJson(Map<String, dynamic> json) {
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
    );
  }

  static int _readInt(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
