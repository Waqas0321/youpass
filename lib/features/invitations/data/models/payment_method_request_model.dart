import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';

class PaymentMethodRequestModel {
  const PaymentMethodRequestModel({
    required this.cardNumber,
    required this.expiry,
    required this.cvv,
    required this.cardholderName,
  });

  final String cardNumber;
  final String expiry;
  final String cvv;
  final String cardholderName;

  factory PaymentMethodRequestModel.fromEntity(
    PaymentMethodRequestEntity entity,
  ) {
    return PaymentMethodRequestModel(
      cardNumber: entity.cardNumber,
      expiry: entity.expiry,
      cvv: entity.cvv,
      cardholderName: entity.cardholderName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'card_number': cardNumber.replaceAll(' ', ''),
      'expiry': expiry,
      'cvv': cvv,
      'cardholder_name': cardholderName,
    };
  }
}
