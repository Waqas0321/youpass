import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;

    return Column(
      children: [
        AppText(
          strings.createAccountTitle,
          variant: AppTextVariant.title,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: layout.spacing(12)),
        AppText(
          strings.createAccountSubtitle,
          variant: AppTextVariant.body,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
