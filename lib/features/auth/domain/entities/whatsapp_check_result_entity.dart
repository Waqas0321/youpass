import 'package:equatable/equatable.dart';

class WhatsAppCheckResultEntity extends Equatable {
  const WhatsAppCheckResultEntity({
    required this.phone,
    required this.whatsappAvailable,
    required this.canReceiveOtp,
    required this.deliveryChannel,
    required this.message,
    this.messageKey,
    this.authChannel,
    this.smsEnabled = false,
  });

  final String phone;
  final bool whatsappAvailable;
  final bool canReceiveOtp;
  final String deliveryChannel;
  final String message;
  final String? messageKey;
  final String? authChannel;
  final bool smsEnabled;

  bool get isReady => whatsappAvailable && canReceiveOtp;

  @override
  List<Object?> get props => [
        phone,
        whatsappAvailable,
        canReceiveOtp,
        deliveryChannel,
        message,
        messageKey,
        authChannel,
        smsEnabled,
      ];
}
