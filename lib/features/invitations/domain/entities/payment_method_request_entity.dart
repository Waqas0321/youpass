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
    this.expirationMonth,
    this.expirationYear,
    this.setAsDefault = true,
  });

  final String cardNumber;
  final String expiry;
  final String cvv;
  final String cardholderName;
  final String? paymentMethodId;
  final String? gateway;
  final String? brand;
  final String? lastFour;
  final int? expirationMonth;
  final int? expirationYear;
  final bool setAsDefault;

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
        expirationMonth,
        expirationYear,
        setAsDefault,
      ];
}
