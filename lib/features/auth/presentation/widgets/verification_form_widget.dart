import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/youpass_primary_button.dart';
import 'package:youpass/features/auth/presentation/widgets/otp_input_widget.dart';

class VerificationFormWidget extends StatelessWidget {
  const VerificationFormWidget({
    super.key,
    required this.otpController,
    required this.isCodeComplete,
    required this.onOtpChanged,
    required this.onValidate,
    this.isLoading = false,
    this.isBlocked = false,
  });

  final TextEditingController otpController;
  final bool isCodeComplete;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onValidate;
  final bool isLoading;
  final bool isBlocked;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OtpInputWidget(
          controller: otpController,
          onChanged: onOtpChanged,
        ),
        SizedBox(height: layout.spacing(28)),
        YouPassPrimaryButton(
          label: context.l10n.validateCodeButton,
          onPressed: isCodeComplete && !isBlocked ? onValidate : null,
          isEnabled: isCodeComplete && !isBlocked,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
