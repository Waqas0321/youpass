import 'package:equatable/equatable.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';

class SendCodeResultEntity extends Equatable {
  const SendCodeResultEntity({
    required this.message,
    required this.phone,
    required this.purpose,
    required this.channel,
    required this.expiresInSeconds,
    required this.resendAvailableInSeconds,
    required this.phoneDisplay,
    this.accountExists,
  });

  final String message;
  final String phone;
  /// Effective purpose from API (`login` or `register` after send-code).
  final String purpose;
  final String channel;
  final int expiresInSeconds;
  final int resendAvailableInSeconds;
  final String phoneDisplay;
  final bool? accountExists;

  OtpPurpose get effectivePurpose => OtpPurposeParsing.fromApiValue(purpose);

  bool get isSmsChannel => channel.toLowerCase() == 'sms';

  @override
  List<Object?> get props => [
        message,
        phone,
        purpose,
        channel,
        expiresInSeconds,
        resendAvailableInSeconds,
        phoneDisplay,
        accountExists,
      ];
}
