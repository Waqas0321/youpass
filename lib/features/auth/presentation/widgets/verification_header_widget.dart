import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/auth_header_widget.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/widgets/verification_message_widget.dart';

class VerificationHeaderWidget extends StatelessWidget {
  const VerificationHeaderWidget({
    super.key,
    required this.phoneDisplay,
    this.purpose = OtpPurpose.login,
  });

  final String phoneDisplay;
  final OtpPurpose purpose;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Column(
      children: [
        AuthHeaderWidget(title: context.l10n.verificationCodeTitle),
        SizedBox(height: layout.spacing(12)),
        if (purpose == OtpPurpose.changePhone)
          AppText(
            context.l10n.changePhoneOtpMessage(phoneDisplay),
            variant: AppTextVariant.body,
            textAlign: TextAlign.center,
          )
        else
          VerificationMessageWidget(phoneDisplay: phoneDisplay),
      ],
    );
  }
}
