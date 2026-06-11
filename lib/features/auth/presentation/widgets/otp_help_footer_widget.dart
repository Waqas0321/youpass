import 'package:flutter/material.dart';
import 'package:youpass/core/config/app_product_config.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class OtpHelpFooterWidget extends StatelessWidget {
  const OtpHelpFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final helpText = AppProductConfig.uiMessages.whatsappHelp;
    if (helpText == null || helpText.isEmpty) {
      return const SizedBox.shrink();
    }

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
