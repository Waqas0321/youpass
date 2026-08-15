import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/otp_timer_formatter.dart';
import 'package:youpass/staff_app/core/widgets/app_text_style_resolver.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/core/widgets/youpass_link_text.dart';

class ResendCodeWidget extends StatelessWidget {
  const ResendCodeWidget({
    super.key,
    required this.secondsRemaining,
    required this.canResend,
    required this.onResend,
  });

  final int secondsRemaining;
  final bool canResend;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    if (canResend) {
      return Center(
        child: YouPassLinkText(
          label: context.l10n.resendCodeAction,
          color: AppColors.primaryMustard,
          onTap: onResend,
        ),
      );
    }

    final bodyStyle = AppTextStyleResolver.resolve(context, AppTextVariant.body);
    final timerStyle = AppTextStyleResolver.resolve(context, AppTextVariant.timer);

    return Center(
      child: Text.rich(
        TextSpan(
          style: bodyStyle,
          children: [
            TextSpan(text: context.l10n.resendCodePrefix),
            TextSpan(
              text: OtpTimerFormatter.formatCountdown(secondsRemaining),
              style: timerStyle,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
