import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/core/widgets/auth_header_widget.dart';

class VerificationHeaderWidget extends StatelessWidget {
  const VerificationHeaderWidget({
    super.key,
    required this.phoneDisplay,
  });

  final String phoneDisplay;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;

    return Column(
      children: [
        AuthHeaderWidget(title: l10n.verificationCodeTitle),
        SizedBox(height: layout.spacing(12)),
        AppText(
          '${l10n.verificationCodeSentPrefix}$phoneDisplay${l10n.verificationCodeSentViaWhatsApp}',
          variant: AppTextVariant.body,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: layout.spacing(4)),
        Icon(
          Icons.chat,
          size: layout.fontSize(16),
          color: AppColors.whatsAppGreen,
        ),
      ],
    );
  }
}
