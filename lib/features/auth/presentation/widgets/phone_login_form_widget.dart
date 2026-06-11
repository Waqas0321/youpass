import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/locale/locale_sync_helper.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/auth_error_extension.dart';
import 'package:youpass/core/l10n/otp_delivery_message.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/core/utils/phone_formatter.dart';
import 'package:youpass/core/utils/phone_validators.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_primary_button.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/presentation/utils/whatsapp_auth_gate.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_input_widget.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/routes/app_routes.dart';

class PhoneLoginFormWidget extends StatefulWidget {
  const PhoneLoginFormWidget({super.key});

  @override
  State<PhoneLoginFormWidget> createState() => PhoneLoginFormWidgetState();
}

class PhoneLoginFormWidgetState extends State<PhoneLoginFormWidget> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<PhoneInputWidgetState> phoneInputKey =
      GlobalKey<PhoneInputWidgetState>();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  String resolvePhoneDigits() {
    return PhoneFormatter.digitsOnly(phoneController.text);
  }

  Future<void> sendCodeAndNavigate() async {
    final country =
        phoneInputKey.currentState?.currentCountry ?? CountryCodeList.defaultCountry;
    final phoneDigits = resolvePhoneDigits();
    final l10n = context.l10n;
    final validationError = PhoneValidators.validateNationalNumber(
      l10n,
      phoneDigits,
      isoCode: country.isoCode,
    );

    if (validationError != null) {
      AppSnackBar.show(context, validationError);
      return;
    }

    final authProvider = context.read<AuthProvider>();

    if (AppConstants.devBypassLoginApi) {
      await authProvider.bypassLoginForTesting();
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      return;
    }

    final whatsAppCheck = await authProvider.checkWhatsApp(
      phone: phoneDigits,
      countryIsoCode: country.isoCode,
      purpose: OtpPurpose.login,
    );

    if (!mounted) {
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
      countryIsoCode: country.isoCode,
      purpose: OtpPurpose.login,
    );

    if (!mounted) {
      return;
    }

    if (result == null) {
      final message =
          authProvider.localizedErrorMessage(l10n) ?? l10n.errorGeneric;
      AppSnackBar.show(context, message);
      return;
    }

    final effectivePurpose = result.effectivePurpose;

    if (effectivePurpose == OtpPurpose.register) {
      Navigator.of(context).pushNamed(
        AppRoutes.verification,
        arguments: VerificationRouteArgs(
          phone: phoneDigits,
          countryIsoCode: country.isoCode,
          purpose: OtpPurpose.register,
          phoneDisplay: result.phoneDisplay,
          resendCooldownSeconds: result.resendAvailableInSeconds,
          expiresInSeconds: result.expiresInSeconds,
          deliveryChannel: 'whatsapp',
          statusMessage: whatsAppCheck.message.isNotEmpty
              ? whatsAppCheck.message
              : OtpDeliveryMessage.sentConfirmation(l10n),
        ),
      );
      return;
    }

    final args = VerificationRouteArgs(
      phone: phoneDigits,
      countryIsoCode: country.isoCode,
      purpose: effectivePurpose,
      phoneDisplay: result.phoneDisplay,
      resendCooldownSeconds: result.resendAvailableInSeconds,
      expiresInSeconds: result.expiresInSeconds,
      deliveryChannel: 'whatsapp',
      statusMessage: whatsAppCheck.message.isNotEmpty
          ? whatsAppCheck.message
          : OtpDeliveryMessage.sentConfirmation(l10n),
    );

    Navigator.of(context).pushNamed(
      AppRoutes.verification,
      arguments: args,
    );
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final authProvider = context.watch<AuthProvider>();
    final localizedError = authProvider.localizedErrorMessage(l10n);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PhoneInputWidget(
          key: phoneInputKey,
          phoneController: phoneController,
          onCountryChanged: (country) => LocaleSyncHelper.applyCountry(context, country),
        ),
        if (localizedError != null) ...[
          SizedBox(height: layout.spacing(12)),
          AppText(
            localizedError,
            variant: AppTextVariant.error,
          ),
        ],
        SizedBox(height: layout.spacing(28)),
        YouPassPrimaryButton(
          label: context.l10n.sendCodeButton,
          isLoading: authProvider.isSubmitting,
          onPressed: sendCodeAndNavigate,
        ),
      ],
    );
  }
}
