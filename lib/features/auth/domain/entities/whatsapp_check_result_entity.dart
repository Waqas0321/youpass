import 'package:equatable/equatable.dart';

class WhatsAppCheckResultEntity extends Equatable {
  const WhatsAppCheckResultEntity({
    required this.phone,
    required this.whatsappAvailable,
    required this.deliveryChannel,
    required this.message,
  });

  final String phone;
  final bool whatsappAvailable;
  final String deliveryChannel;
  final String message;

  @override
  List<Object?> get props => [
        phone,
        whatsappAvailable,
        deliveryChannel,
        message,
      ];
}
