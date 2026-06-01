import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/auth_layout_constants.dart';
import 'package:youpass/core/constants/otp_constants.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/auth_error_extension.dart';
import 'package:youpass/core/utils/phone_validators.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/widgets/auth_page_layout.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/presentation/widgets/change_number_footer_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/resend_code_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/verification_form_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/verification_header_widget.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/routes/app_routes.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({
    super.key,
    required this.args,
  });

  final VerificationRouteArgs args;

  @override
  State<VerificationScreen> createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  Timer? resendTimer;
  late int secondsRemaining;
  late OtpPurpose purpose;
  late String deliveryChannel;
  late String phoneDisplay;
  bool isCodeComplete = false;

  VerificationRouteArgs get args => widget.args;

  @override
  void initState() {
    super.initState();
    purpose = args.purpose;
    deliveryChannel = args.deliveryChannel;
    phoneDisplay = args.phoneDisplay;
    secondsRemaining = args.resendCooldownSeconds;
    startResendTimer(secondsRemaining);
  }

  @override
  void dispose() {
    resendTimer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  bool get canResend => secondsRemaining <= 0;

  void startResendTimer(int seconds) {
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
      isCodeComplete = value.length == OtpConstants.codeLength;
    });
  }

  Future<void> handleResendCode() async {
    final authProvider = context.read<AuthProvider>();
    final result = await authProvider.resendVerificationCode(
      phone: args.phone,
      countryIsoCode: args.countryIsoCode,
      purpose: purpose,
    );

    if (!mounted) {
      return;
    }

    if (result != null) {
      setState(() {
        purpose = result.effectivePurpose;
        deliveryChannel = result.channel;
        phoneDisplay = result.phoneDisplay;
        isCodeComplete = false;
      });
      otpController.clear();
      startResendTimer(result.resendAvailableInSeconds);
      return;
    }

    final retryAfter = authProvider.lastRetryAfterSeconds;
    if (retryAfter != null && retryAfter > 0) {
      startResendTimer(retryAfter);
    }

    showLocalizedError(authProvider);
  }

  Future<void> handleValidateCode() async {
    final l10n = context.l10n;
    final code = otpController.text.trim();
    final validationError = PhoneValidators.otpCode(l10n, code);

    if (validationError != null) {
      AppSnackBar.show(context, validationError);
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final success = purpose == OtpPurpose.register
        ? await completeRegistration(authProvider, code)
        : await authProvider.loginWithPhone(
            phone: args.phone,
            countryIsoCode: args.countryIsoCode,
            code: code,
          );

    if (!mounted) {
      return;
    }

    if (success) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      return;
    }

    showLocalizedError(authProvider);
  }

  Future<bool> completeRegistration(AuthProvider authProvider, String code) async {
    final draft = args.registerDraft;
    if (draft == null) {
      return false;
    }

    return authProvider.registerAccount(
      RegisterRequestEntity(
        phone: args.phone,
        countryIsoCode: args.countryIsoCode,
        code: code,
        fullName: draft.fullName,
        documentId: draft.documentId,
        birthDate: draft.birthDate,
        gender: draft.gender,
        email: draft.email,
        instagram: draft.instagram,
        acceptTerms: draft.acceptTerms,
      ),
    );
  }

  void showLocalizedError(AuthProvider authProvider) {
    final message = authProvider.localizedErrorMessage(context.l10n);
    if (message == null || message.isEmpty) {
      return;
    }

    AppSnackBar.show(context, message);
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final authProvider = context.watch<AuthProvider>();
    final localizedError = authProvider.localizedErrorMessage(l10n);

    return AuthPageLayout(
      showScaffoldBackButton: true,
      logoTopSpacing: AuthLayoutConstants.compactTop(layout),
      header: VerificationHeaderWidget(
        phoneDisplay: phoneDisplay,
        isSmsChannel: deliveryChannel.toLowerCase() == 'sms',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (args.statusMessage != null && args.statusMessage!.isNotEmpty) ...[
            AppText(
              args.statusMessage!,
              variant: AppTextVariant.body,
              textAlign: TextAlign.center,
              color: AppColors.primaryMustard,
            ),
            SizedBox(height: layout.spacing(16)),
          ],
          VerificationFormWidget(
            otpController: otpController,
            isCodeComplete: isCodeComplete,
            isLoading: authProvider.isSubmitting,
            onOtpChanged: handleOtpChanged,
            onValidate: handleValidateCode,
          ),
          if (localizedError != null) ...[
            SizedBox(height: layout.spacing(12)),
            AppText(
              localizedError,
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
      footer: ChangeNumberFooterWidget(
        onChangeNumber: () => Navigator.of(context).pop(),
      ),
    );
  }
}
