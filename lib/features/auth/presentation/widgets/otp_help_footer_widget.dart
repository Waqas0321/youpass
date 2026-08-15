import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class OtpHelpFooterWidget extends StatelessWidget {
  const OtpHelpFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final helpText = context.l10n.otpWhatsAppHelp;
    final layout = ResponsiveLayout(context);

    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(16)),
      child: AppText(
        helpText,
        variant: AppTextVariant.body,
        textAlign: TextAlign.center,
      ),
    );
  }
}
