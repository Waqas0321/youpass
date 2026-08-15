import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/config/otp_policy.dart';
import 'package:youpass/staff_app/core/constants/auth_layout_constants.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/l10n/staff_auth_message_localizer.dart';
import 'package:youpass/staff_app/core/utils/phone_validators.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/core/widgets/auth_page_layout.dart';
import 'package:youpass/staff_app/core/widgets/youpass_link_text.dart';
import 'package:youpass/staff_app/core/widgets/youpass_primary_button.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/home/presentation/utils/sync_staff_work_mode.dart';
import 'package:youpass/staff_app/features/auth/presentation/utils/otp_autofill_helper.dart';
import 'package:youpass/staff_app/features/auth/presentation/widgets/otp_input_widget.dart';
import 'package:youpass/staff_app/features/auth/presentation/widgets/resend_code_widget.dart';
import 'package:youpass/staff_app/features/auth/presentation/widgets/verification_header_widget.dart';
import 'package:youpass/staff_app/features/auth/routes/verification_route_args.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.args});

  final VerificationRouteArgs args;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  Timer? resendTimer;
  late int secondsRemaining;
  bool isCodeComplete = false;

  VerificationRouteArgs get args => widget.args;

  @override
  void initState() {
    super.initState();
    secondsRemaining = OtpPolicy.resolveResendCooldown(args.resendCooldownSeconds);
    _startResendTimer(secondsRemaining);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      applyPrefillOtp(args.prefillOtpCode, autoValidate: true);
    });
  }

  @override
  void dispose() {
    resendTimer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  bool get canResend => secondsRemaining <= 0;

  void applyPrefillOtp(String? code, {bool autoValidate = false}) {
    final normalized = OtpAutofillHelper.normalizePrefillCode(code);
    if (normalized == null) {
      return;
    }

    OtpAutofillHelper.applyToController(otpController, normalized);
    handleOtpChanged(normalized);

    if (autoValidate && mounted) {
      scheduleAutoValidate();
    }
  }

  void scheduleAutoValidate() {
    Future<void>.delayed(const Duration(milliseconds: 350), () {
      if (mounted) {
        handleValidateCode();
      }
    });
  }

  void _startResendTimer(int seconds) {
    resendTimer?.cancel();
    setState(() => secondsRemaining = seconds);

    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (secondsRemaining <= 1) {
        setState(() => secondsRemaining = 0);
        timer.cancel();
        return;
      }

      setState(() => secondsRemaining -= 1);
    });
  }

  void handleOtpChanged(String value) {
    setState(() {
      isCodeComplete = value.length == OtpPolicy.codeLength;
    });
  }

  String _authErrorMessage(StaffAuthProvider authProvider) {
    return StaffAuthMessageLocalizer.fromApiError(
      context.l10n,
      code: authProvider.errorCode,
      fallbackMessage: authProvider.errorMessage,
      retryAfterSeconds: authProvider.retryAfterSeconds,
    );
  }

  Future<void> handleResendCode() async {
    final authProvider = context.read<StaffAuthProvider>();
    final result = await authProvider.resendCode(
      phone: args.phone,
      countryCode: args.countryIsoCode,
    );

    if (!mounted) {
      return;
    }

    if (result != null) {
      otpController.clear();
      setState(() => isCodeComplete = false);
      _startResendTimer(
        OtpPolicy.resolveResendCooldown(result.resendAvailableInSeconds),
      );
      applyPrefillOtp(result.devOtpCode, autoValidate: true);
      return;
    }

    final retryAfter = authProvider.retryAfterSeconds;
    if (retryAfter != null && retryAfter > 0) {
      _startResendTimer(retryAfter);
    }

    if (authProvider.errorCode != null) {
      AppSnackBar.show(context, _authErrorMessage(authProvider));
    }
  }

  Future<void> handleValidateCode() async {
    final l10n = context.l10n;
    final code = otpController.text.trim();
    final validationError = PhoneValidators.otpCode(l10n, code);

    if (validationError != null) {
      AppSnackBar.show(context, validationError);
      return;
    }

    final authProvider = context.read<StaffAuthProvider>();
    final success = await authProvider.login(
      phone: args.phone,
      countryCode: args.countryIsoCode,
      code: code,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      syncStaffWorkModeFromAuth(context);
      Navigator.of(context).pushNamedAndRemoveUntil(
        StaffAppRoutes.home,
        (_) => false,
      );
      return;
    }

    if (authProvider.errorCode != null) {
      AppSnackBar.show(context, _authErrorMessage(authProvider));
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final authProvider = context.watch<StaffAuthProvider>();

    return AuthPageLayout(
      showScaffoldBackButton: true,
      logoTopSpacing: AuthLayoutConstants.compactTop(layout),
      header: VerificationHeaderWidget(phoneDisplay: args.phoneDisplay),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OtpInputWidget(
            controller: otpController,
            onChanged: handleOtpChanged,
            onCompleted: handleValidateCode,
          ),
          SizedBox(height: layout.spacing(28)),
          YouPassPrimaryButton(
            label: l10n.validateCodeButton,
            isLoading: authProvider.isSubmitting,
            isEnabled: isCodeComplete && !authProvider.isSubmitting,
            onPressed: handleValidateCode,
          ),
          if (authProvider.errorCode != null) ...[
            SizedBox(height: layout.spacing(12)),
            AppText(
              _authErrorMessage(authProvider),
              variant: AppTextVariant.error,
            ),
          ],
          SizedBox(height: layout.spacing(20)),
          ResendCodeWidget(
            secondsRemaining: secondsRemaining,
            canResend: canResend && !authProvider.isSubmitting,
            onResend: handleResendCode,
          ),
        ],
      ),
      footer: Center(
        child: YouPassLinkText(
          label: l10n.changeNumberLink,
          color: Theme.of(context).colorScheme.primary,
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
