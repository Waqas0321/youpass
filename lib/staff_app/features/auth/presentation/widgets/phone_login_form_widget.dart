import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/country_code_list.dart';
import 'package:youpass/staff_app/core/config/otp_policy.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/l10n/staff_auth_message_localizer.dart';
import 'package:youpass/staff_app/core/locale/locale_sync_helper.dart';
import 'package:youpass/staff_app/core/utils/phone_formatter.dart';
import 'package:youpass/staff_app/core/utils/phone_validators.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/core/widgets/youpass_primary_button.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/auth/presentation/widgets/phone_input_widget.dart';
import 'package:youpass/staff_app/features/auth/routes/verification_route_args.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

class PhoneLoginFormWidget extends StatefulWidget {
  const PhoneLoginFormWidget({
    super.key,
    required this.phoneController,
    required this.phoneInputKey,
  });

  final TextEditingController phoneController;
  final GlobalKey<PhoneInputWidgetState> phoneInputKey;

  @override
  State<PhoneLoginFormWidget> createState() => PhoneLoginFormWidgetState();
}

class PhoneLoginFormWidgetState extends State<PhoneLoginFormWidget> {
  String? _errorMessage;

  TextEditingController get phoneController => widget.phoneController;
  GlobalKey<PhoneInputWidgetState> get phoneInputKey => widget.phoneInputKey;

  String resolvePhoneDigits() {
    return PhoneFormatter.digitsOnly(phoneController.text);
  }

  Future<void> sendCodeAndNavigate() async {
    FocusManager.instance.primaryFocus?.unfocus();

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
      setState(() => _errorMessage = validationError);
      AppSnackBar.show(context, validationError);
      return;
    }

    setState(() => _errorMessage = null);

    final authProvider = context.read<StaffAuthProvider>();
    final result = await authProvider.sendCode(
      phone: phoneDigits,
      countryCode: country.isoCode,
    );

    if (!mounted) {
      return;
    }

    if (result != null) {
      await Navigator.of(context).pushNamed(
        StaffAppRoutes.verification,
        arguments: VerificationRouteArgs(
          phone: phoneDigits,
          countryIsoCode: country.isoCode,
          phoneDisplay: result.phoneDisplay,
          resendCooldownSeconds: OtpPolicy.resolveResendCooldown(
            result.resendAvailableInSeconds,
          ),
          expiresInSeconds: OtpPolicy.resolveOtpTtl(result.expiresInSeconds),
          prefillOtpCode: result.devOtpCode,
        ),
      );
      return;
    }

    final retryAfter = authProvider.retryAfterSeconds;
    final message = StaffAuthMessageLocalizer.fromApiError(
      l10n,
      code: authProvider.errorCode,
      fallbackMessage: authProvider.errorMessage,
      retryAfterSeconds: retryAfter,
    );
    setState(() => _errorMessage = message);
    AppSnackBar.show(context, message);
    if (retryAfter != null && retryAfter > 0) {
      // Cooldown surfaced via snackbar; user can retry after timer.
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final authProvider = context.watch<StaffAuthProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PhoneInputWidget(
          key: phoneInputKey,
          phoneController: phoneController,
          enabled: !authProvider.isSubmitting,
          onCountryChanged: (country) {
            LocaleSyncHelper.applyCountry(context, country);
          },
        ),
        if (_errorMessage != null) ...[
          SizedBox(height: layout.spacing(12)),
          AppText(
            _errorMessage!,
            variant: AppTextVariant.error,
          ),
        ],
        SizedBox(height: layout.spacing(28)),
        YouPassPrimaryButton(
          label: l10n.sendCodeButton,
          isLoading: authProvider.isSubmitting,
          onPressed: sendCodeAndNavigate,
        ),
      ],
    );
  }
}
