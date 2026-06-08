import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_rich_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class RegisterTermsWidget extends StatelessWidget {
  const RegisterTermsWidget({
    super.key,
    required this.isAccepted,
    required this.onChanged,
  });

  final bool isAccepted;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;
    final theme = YouPassThemeExtension.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: layout.spacing(24),
          height: layout.spacing(24),
          child: Checkbox(
            value: isAccepted,
            onChanged: (value) => onChanged(value ?? false),
            activeColor: AppColors.primaryMustard,
            checkColor: AppColors.darkNavy,
            side: BorderSide(color: theme.cardBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(layout.radius(4)),
            ),
          ),
        ),
        SizedBox(width: layout.spacing(10)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: layout.spacing(2)),
            child: AppRichText(
              variant: AppTextVariant.body,
              children: [
                AppRichText.span(context, strings.termsPrefix),
                AppRichText.span(
                  context,
                  strings.termsLink,
                  variant: AppTextVariant.timer,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
