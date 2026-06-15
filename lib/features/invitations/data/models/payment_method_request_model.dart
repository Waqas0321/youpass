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
    this.expirationMonth,
    this.expirationYear,
    this.setAsDefault = true,
  });

  final String? cardNumber;
  final String? expiry;
  final String? cvv;
  final String? cardholderName;
  final String? paymentMethodId;
  final String? gateway;
  final String? brand;
  final String? lastFour;
  final int? expirationMonth;
  final int? expirationYear;
  final bool setAsDefault;

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
      expirationMonth: entity.expirationMonth,
      expirationYear: entity.expirationYear,
      setAsDefault: entity.setAsDefault,
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
        if (expirationMonth != null) 'expiration_month': expirationMonth,
        if (expirationYear != null) 'expiration_year': expirationYear,
        'set_as_default': setAsDefault,
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
