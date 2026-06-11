import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';

class PaymentMethodRequestModel {
  const PaymentMethodRequestModel({
    this.cardNumber,
    this.expiry,
    this.cvv,
    this.cardholderName,
    this.paymentMethodId,
    this.gateway,
    this.brand,
    this.lastFour,
  });

  final String? cardNumber;
  final String? expiry;
  final String? cvv;
  final String? cardholderName;
  final String? paymentMethodId;
  final String? gateway;
  final String? brand;
  final String? lastFour;

  factory PaymentMethodRequestModel.fromEntity(
    PaymentMethodRequestEntity entity,
  ) {
    return PaymentMethodRequestModel(
      cardNumber: entity.cardNumber,
      expiry: entity.expiry,
      cvv: entity.cvv,
      cardholderName: entity.cardholderName,
      paymentMethodId: entity.paymentMethodId,
      gateway: entity.gateway,
      brand: entity.brand,
      lastFour: entity.lastFour,
    );
  }

  Map<String, dynamic> toJson() {
    if (paymentMethodId != null && paymentMethodId!.isNotEmpty) {
      return {
        'payment_method_id': paymentMethodId,
        if (gateway != null && gateway!.isNotEmpty) 'gateway': gateway,
        if (brand != null && brand!.isNotEmpty) 'brand': brand,
        if (lastFour != null && lastFour!.isNotEmpty) 'last_four': lastFour,
        if (cardholderName != null && cardholderName!.isNotEmpty)
          'cardholder_name': cardholderName,
      };
    }

    return {
      'card_number': cardNumber?.replaceAll(' ', '') ?? '',
      'expiry': expiry ?? '',
      'cvv': cvv ?? '',
      'cardholder_name': cardholderName ?? '',
    };
  }
}
