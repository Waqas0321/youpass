import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_rich_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class ResendCodeWidget extends StatelessWidget {
  const ResendCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppRichText(
        variant: AppTextVariant.body,
        children: [
          AppRichText.span(context, context.l10n.resendCodePrefix),
          AppRichText.span(
            context,
            '00:24',
            variant: AppTextVariant.timer,
          ),
        ],
      ),
    );
  }
}
