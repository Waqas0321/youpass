import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/youpass_primary_button.dart';
import 'package:youpass/features/auth/presentation/widgets/otp_input_widget.dart';

class VerificationFormWidget extends StatelessWidget {
  const VerificationFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const OtpInputWidget(),
        SizedBox(height: layout.spacing(28)),
        YouPassPrimaryButton(
          label: context.l10n.validateCodeButton,
          onPressed: null,
        ),
      ],
    );
  }
}
