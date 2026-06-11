import 'package:equatable/equatable.dart';

class PaymentMethodRequestEntity extends Equatable {
  const PaymentMethodRequestEntity({
    this.cardNumber = '',
    this.expiry = '',
    this.cvv = '',
    this.cardholderName = '',
    this.paymentMethodId,
    this.gateway,
    this.brand,
    this.lastFour,
  });

  final String cardNumber;
  final String expiry;
  final String cvv;
  final String cardholderName;
  final String? paymentMethodId;
  final String? gateway;
  final String? brand;
  final String? lastFour;

  bool get isTokenized =>
      paymentMethodId != null && paymentMethodId!.trim().isNotEmpty;

  @override
  List<Object?> get props => [
        cardNumber,
        expiry,
        cvv,
        cardholderName,
        paymentMethodId,
        gateway,
        brand,
        lastFour,
      ];
}
