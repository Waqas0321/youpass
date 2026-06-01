import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/routes/register_draft.dart';

class VerificationRouteArgs {
  const VerificationRouteArgs({
    required this.phone,
    required this.countryIsoCode,
    required this.purpose,
    required this.phoneDisplay,
    required this.resendCooldownSeconds,
    this.deliveryChannel = 'sms',
    this.statusMessage,
    this.registerDraft,
  });

  final String phone;
  final String countryIsoCode;
  final OtpPurpose purpose;
  final String phoneDisplay;
  final int resendCooldownSeconds;
  final String deliveryChannel;
  final String? statusMessage;
  final RegisterDraft? registerDraft;

  bool get isSmsChannel => deliveryChannel.toLowerCase() == 'sms';
}
