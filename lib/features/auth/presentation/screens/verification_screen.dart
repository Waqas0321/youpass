import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/auth_layout_constants.dart';
import 'package:youpass/core/config/otp_policy.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/auth_error_extension.dart';
import 'package:youpass/core/utils/phone_validators.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/widgets/auth_page_layout.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/presentation/widgets/change_number_footer_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/otp_help_footer_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/resend_code_widget.dart';
import 'package:youpass/features/auth/routes/register_route_args.dart';
import 'package:youpass/routes/app_routes.dart';
import 'package:youpass/features/auth/presentation/widgets/verification_form_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/verification_header_widget.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/features/auth/presentation/utils/auth_navigation.dart';
import 'package:youpass/l10n/app_localizations.dart';

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
  Timer? blockTimer;
  Timer? expiryTimer;
  late int secondsRemaining;
  late int codeExpirySecondsRemaining;
  int blockSecondsRemaining = 0;
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
    secondsRemaining = OtpPolicy.resolveResendCooldown(args.resendCooldownSeconds);
    codeExpirySecondsRemaining =
        OtpPolicy.resolveOtpTtl(args.expiresInSeconds);
    startResendTimer(secondsRemaining);
    startExpiryTimer(codeExpirySecondsRemaining);
  }

  @override
  void dispose() {
    resendTimer?.cancel();
    blockTimer?.cancel();
    expiryTimer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  bool get canResend => secondsRemaining <= 0;
  bool get isVerifyBlocked => blockSecondsRemaining > 0;

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

  void startExpiryTimer(int seconds) {
    expiryTimer?.cancel();
    if (seconds <= 0) {
      setState(() => codeExpirySecondsRemaining = 0);
      return;
    }

    setState(() => codeExpirySecondsRemaining = seconds);
    expiryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (codeExpirySecondsRemaining <= 1) {
        setState(() => codeExpirySecondsRemaining = 0);
        timer.cancel();
        return;
      }

      setState(() => codeExpirySecondsRemaining -= 1);
    });
  }

  void startBlockTimer(int seconds) {
    blockTimer?.cancel();
    if (seconds <= 0) {
      setState(() => blockSecondsRemaining = 0);
      return;
    }

    setState(() => blockSecondsRemaining = seconds);
    blockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (blockSecondsRemaining <= 1) {
        setState(() => blockSecondsRemaining = 0);
        timer.cancel();
        return;
      }

      setState(() => blockSecondsRemaining -= 1);
    });
  }

  void handleOtpChanged(String value) {
    setState(() {
      isCodeComplete = value.length == OtpPolicy.codeLength;
    });
  }

  Future<void> handleResendCode() async {
    final authProvider = context.read<AuthProvider>();

    if (purpose == OtpPurpose.changePhone) {
      final result = await authProvider.requestChangePhone(
        newPhone: args.phone,
        newCountryCode: args.countryIsoCode,
      );
      if (!mounted) {
        return;
      }

      if (result != null) {
        setState(() {
          deliveryChannel = result.channel;
          phoneDisplay = result.phoneDisplay;
          isCodeComplete = false;
        });
        otpController.clear();
        startResendTimer(
          OtpPolicy.resolveResendCooldown(result.resendAvailableInSeconds),
        );
        startExpiryTimer(OtpPolicy.resolveOtpTtl(result.expiresInSeconds));
        return;
      }

      final retryAfter = authProvider.lastRetryAfterSeconds;
      if (retryAfter != null && retryAfter > 0) {
        startResendTimer(retryAfter);
      }

      showLocalizedError(authProvider);
      return;
    }

    if (purpose == OtpPurpose.deleteAccount) {
      final result = await authProvider.requestDeleteAccount();
      if (!mounted) {
        return;
      }

      if (result != null) {
        setState(() {
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
      return;
    }

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
      startResendTimer(
        OtpPolicy.resolveResendCooldown(result.resendAvailableInSeconds),
      );
      startExpiryTimer(
        OtpPolicy.resolveOtpTtl(result.expiresInSeconds),
      );
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
    final bool success;

    if (purpose == OtpPurpose.register) {
      if (args.registerDraft != null) {
        authProvider.markRegistrationStarted();
        success = await completeRegistration(authProvider, code);
      } else {
        if (!mounted) {
          return;
        }
        Navigator.of(context).pushNamed(
          AppRoutes.register,
          arguments: RegisterRouteArgs(
            phone: args.phone,
            countryIsoCode: args.countryIsoCode,
            phoneDisplay: args.phoneDisplay,
            resendCooldownSeconds: args.resendCooldownSeconds,
            expiresInSeconds: args.expiresInSeconds,
            codeAlreadySent: true,
            otpCode: code,
          ),
        );
        return;
      }
    } else if (purpose == OtpPurpose.deleteAccount) {
      success = await authProvider.confirmDeleteAccount(code);
    } else if (purpose == OtpPurpose.changePhone) {
      final changePhoneSuccess = await authProvider.verifyChangePhone(
        newPhone: args.phone,
        newCountryCode: args.countryIsoCode,
        code: code,
      );
      if (!mounted) {
        return;
      }
      if (changePhoneSuccess) {
        AppSnackBar.show(context, l10n.phoneChangeSuccess);
        Navigator.of(context).pop(true);
        return;
      }
      _handleVerificationFailure(authProvider);
      return;
    } else {
      success = await authProvider.loginWithPhone(
        phone: args.phone,
        countryIsoCode: args.countryIsoCode,
        code: code,
      );
    }

    if (!mounted) {
      return;
    }

    if (success) {
      AuthNavigation.completeOneTimeLogin(context, purpose: purpose);
      return;
    }

    _handleVerificationFailure(authProvider);
  }

  void _handleVerificationFailure(AuthProvider authProvider) {
    if (authProvider.errorCode == 'BLOCKED') {
      startBlockTimer(authProvider.lastRetryAfterSeconds ?? 0);
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
        preferredLanguage: context.read<LocaleProvider>().locale.languageCode,
      ),
    );
  }

  String? _resolveInlineError(AppLocalizations l10n, AuthProvider authProvider) {
    if (isVerifyBlocked) {
      return l10n.errorBlockedCountdown(blockSecondsRemaining);
    }

    return authProvider.localizedErrorMessage(l10n);
  }

  void showLocalizedError(AuthProvider authProvider) {
    final message = _resolveInlineError(context.l10n, authProvider);
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
    final localizedError = _resolveInlineError(l10n, authProvider);

    return AuthPageLayout(
      showScaffoldBackButton: true,
      logoTopSpacing: AuthLayoutConstants.compactTop(layout),
      header: VerificationHeaderWidget(
        phoneDisplay: phoneDisplay,
        purpose: purpose,
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
          if (codeExpirySecondsRemaining > 0) ...[
            AppText(
              l10n.otpCodeExpiresIn(codeExpirySecondsRemaining),
              variant: AppTextVariant.body,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: layout.spacing(12)),
          ],
          VerificationFormWidget(
            otpController: otpController,
            isCodeComplete: isCodeComplete,
            isLoading: authProvider.isSubmitting,
            isBlocked: isVerifyBlocked,
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
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const OtpHelpFooterWidget(),
          ChangeNumberFooterWidget(
            onChangeNumber: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
