import 'package:equatable/equatable.dart';

class OtpDeliveryResultEntity extends Equatable {
  const OtpDeliveryResultEntity({
    required this.message,
    required this.phone,
    required this.phoneDisplay,
    required this.channel,
    required this.expiresInSeconds,
    required this.resendAvailableInSeconds,
    this.devOtpCode,
  });

  final String message;
  final String phone;
  final String phoneDisplay;
  final String channel;
  final int expiresInSeconds;
  final int resendAvailableInSeconds;
  final String? devOtpCode;

  @override
  List<Object?> get props => [
        message,
        phone,
        phoneDisplay,
        channel,
        expiresInSeconds,
        resendAvailableInSeconds,
        devOtpCode,
      ];
}
