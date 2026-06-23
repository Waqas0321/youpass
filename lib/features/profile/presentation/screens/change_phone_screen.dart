import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/config/otp_policy.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/auth_error_extension.dart';
import 'package:youpass/core/l10n/otp_delivery_message.dart';
import 'package:youpass/core/locale/locale_sync_helper.dart';
import 'package:youpass/core/utils/phone_formatter.dart';
import 'package:youpass/core/utils/phone_validators.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_primary_button.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/presentation/utils/whatsapp_auth_gate.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_input_widget.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_app_bar_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/routes/app_routes.dart';

class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({super.key});

  @override
  State<ChangePhoneScreen> createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<PhoneInputWidgetState> phoneInputKey =
      GlobalKey<PhoneInputWidgetState>();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> submitNewPhone() async {
    final country =
        phoneInputKey.currentState?.currentCountry ?? CountryCodeList.defaultCountry;
    final phoneDigits = PhoneFormatter.digitsOnly(phoneController.text);
    final l10n = context.l10n;
    final authProvider = context.read<AuthProvider>();
    final currentPhoneDigits = PhoneFormatter.digitsOnly(
      authProvider.userProfile?.phone ?? '',
    );

    final validationError = PhoneValidators.validateNationalNumber(
      l10n,
      phoneDigits,
      isoCode: country.isoCode,
    );
    if (validationError != null) {
      AppSnackBar.show(context, validationError);
      return;
    }

    if (currentPhoneDigits.isNotEmpty && phoneDigits == currentPhoneDigits) {
      AppSnackBar.show(context, l10n.changePhoneSameNumber);
      return;
    }

    final whatsAppCheck = await authProvider.checkWhatsApp(
      phone: phoneDigits,
      countryIsoCode: country.isoCode,
      purpose: OtpPurpose.changePhone,
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

    final result = await authProvider.requestChangePhone(
      newPhone: phoneDigits,
      newCountryCode: country.isoCode,
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

    final verified = await Navigator.of(context).pushNamed<bool>(
      AppRoutes.verification,
      arguments: VerificationRouteArgs(
        phone: phoneDigits,
        countryIsoCode: country.isoCode,
        purpose: OtpPurpose.changePhone,
        phoneDisplay: result.phoneDisplay,
        resendCooldownSeconds: OtpPolicy.resolveResendCooldown(
          result.resendAvailableInSeconds,
        ),
        expiresInSeconds: OtpPolicy.resolveOtpTtl(result.expiresInSeconds),
        deliveryChannel: 'whatsapp',
        statusMessage: whatsAppCheck.message.isNotEmpty
            ? whatsAppCheck.message
            : OtpDeliveryMessage.sentConfirmation(l10n),
        prefillOtpCode: result.devOtpCode,
      ),
    );

    if (!mounted) {
      return;
    }

    if (verified == true) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final authProvider = context.watch<AuthProvider>();
    final profile = authProvider.userProfile;
    final currentPhoneDisplay = profile?.phoneDisplay ?? profile?.phone ?? '';
    final localizedError = authProvider.localizedErrorMessage(l10n);
    final horizontalPadding =
        ProfileDesignSpec.px(context, ProfileDesignSpec.horizontalPadding);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      appBar: ProfileAppBarWidget(
        title: l10n.changePhoneTitle,
        onBack: () => Navigator.of(context).pop(),
        onMenuTap: () => AppDrawerNavigation.openDrawer(context, scaffoldKey),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: layout.spacing(16)),
            AppText(
              l10n.changePhoneSubtitle,
              variant: AppTextVariant.body,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: layout.spacing(24)),
            if (currentPhoneDisplay.isNotEmpty) ...[
              AppText(
                l10n.changePhoneCurrentLabel,
                variant: AppTextVariant.label,
              ),
              SizedBox(height: layout.spacing(6)),
              AppText(
                currentPhoneDisplay,
                variant: AppTextVariant.bodyEmphasis,
              ),
              SizedBox(height: layout.spacing(24)),
            ],
            AppText(
              l10n.changePhoneNewLabel,
              variant: AppTextVariant.label,
            ),
            SizedBox(height: layout.spacing(12)),
            PhoneInputWidget(
              key: phoneInputKey,
              phoneController: phoneController,
              initialCountryIsoCode: profile?.countryCode,
              onCountryChanged: (country) =>
                  LocaleSyncHelper.applyCountry(context, country),
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
              label: l10n.changePhoneContinueButton,
              isLoading: authProvider.isSubmitting,
              onPressed: submitNewPhone,
            ),
            SizedBox(height: layout.spacing(24)),
          ],
        ),
      ),
    );
  }
}
