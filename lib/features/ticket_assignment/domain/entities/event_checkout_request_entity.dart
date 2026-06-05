import 'package:equatable/equatable.dart';

class EventCheckoutRequestEntity extends Equatable {
  const EventCheckoutRequestEntity({
    required this.quantity,
    required this.tier,
    required this.type,
    this.paymentMethodId,
  });

  final int quantity;
  final String tier;
  final String type;
  final String? paymentMethodId;

  @override
  List<Object?> get props => [quantity, tier, type, paymentMethodId];
}
