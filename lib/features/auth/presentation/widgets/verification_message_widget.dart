import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_rich_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class VerificationMessageWidget extends StatelessWidget {
  const VerificationMessageWidget({
    super.key,
    required this.phoneDisplay,
    this.isSmsChannel = true,
  });

  final String phoneDisplay;
  final bool isSmsChannel;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;
    final channelSuffix = isSmsChannel
        ? strings.verificationCodeSentViaSms
        : strings.verificationCodeSentViaWhatsApp;

    return AppRichText(
      textAlign: TextAlign.center,
      variant: AppTextVariant.body,
      children: [
        AppRichText.span(context, strings.verificationCodeSentPrefix),
        AppRichText.span(
          context,
          phoneDisplay,
          variant: AppTextVariant.bodyEmphasis,
        ),
        AppRichText.span(context, channelSuffix),
        if (!isSmsChannel)
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: EdgeInsets.only(left: layout.spacing(2)),
              child: Icon(
                Icons.chat,
                size: layout.fontSize(16),
                color: AppColors.whatsAppGreen,
              ),
            ),
          ),
      ],
    );
  }
}
