import 'package:equatable/equatable.dart';

class PaymentMethodRequestEntity extends Equatable {
  const PaymentMethodRequestEntity({
    required this.cardNumber,
    required this.expiry,
    required this.cvv,
    required this.cardholderName,
  });

  final String cardNumber;
  final String expiry;
  final String cvv;
  final String cardholderName;

  @override
  List<Object?> get props => [cardNumber, expiry, cvv, cardholderName];
}
