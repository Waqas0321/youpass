import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/routes/register_draft.dart';

class VerificationRouteArgs {
  const VerificationRouteArgs({
    required this.phone,
    required this.countryIsoCode,
    required this.purpose,
    required this.phoneDisplay,
    required this.resendCooldownSeconds,
    this.expiresInSeconds,
    this.deliveryChannel = 'whatsapp',
    this.statusMessage,
    this.registerDraft,
  });

  final String phone;
  final String countryIsoCode;
  final OtpPurpose purpose;
  final String phoneDisplay;
  final int resendCooldownSeconds;
  final int? expiresInSeconds;
  final String deliveryChannel;
  final String? statusMessage;
  final RegisterDraft? registerDraft;
}
