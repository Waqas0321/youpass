import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/auth_error_extension.dart';
import 'package:youpass/core/l10n/otp_delivery_message.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/presentation/utils/whatsapp_auth_gate.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/routes/app_routes.dart';

class RegisterOtpFlow {
  RegisterOtpFlow._();

  static Future<void> sendCodeAndOpenVerification({
    required BuildContext context,
    required String phoneDigits,
    required String countryIsoCode,
  }) async {
    final l10n = context.l10n;
    final authProvider = context.read<AuthProvider>();

    authProvider.markRegistrationStarted();

    final whatsAppCheck = await authProvider.checkWhatsApp(
      phone: phoneDigits,
      countryIsoCode: countryIsoCode,
      purpose: OtpPurpose.register,
    );

    if (!context.mounted) {
      return;
    }

    if (whatsAppCheck == null) {
      final message =
          authProvider.localizedErrorMessage(l10n) ?? l10n.errorGeneric;
      AppSnackBar.show(context, message);
      return;
    }

    if (!WhatsAppAuthGate.canSendOtp(whatsAppCheck)) {
      final message = WhatsAppAuthGate.unavailableMessage(whatsAppCheck);
      AppSnackBar.show(
        context,
        message.isNotEmpty ? message : l10n.errorWhatsAppRequired,
      );
      return;
    }

    final result = await authProvider.sendVerificationCode(
      phone: phoneDigits,
      countryIsoCode: countryIsoCode,
      purpose: OtpPurpose.register,
    );

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      final message =
          authProvider.localizedErrorMessage(l10n) ?? l10n.errorGeneric;
      AppSnackBar.show(context, message);
      return;
    }

    final args = VerificationRouteArgs(
      phone: phoneDigits,
      countryIsoCode: countryIsoCode,
      purpose: result.effectivePurpose,
      phoneDisplay: result.phoneDisplay,
      resendCooldownSeconds: result.resendAvailableInSeconds,
      expiresInSeconds: result.expiresInSeconds,
      deliveryChannel: 'whatsapp',
      statusMessage: whatsAppCheck.message.isNotEmpty
          ? whatsAppCheck.message
          : OtpDeliveryMessage.sentConfirmation(l10n),
      prefillOtpCode: result.devOtpCode,
    );

    Navigator.of(context).pushNamed(
      AppRoutes.verification,
      arguments: args,
    );
  }
}
