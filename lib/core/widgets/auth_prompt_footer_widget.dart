import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_link_text.dart';

class AuthPromptFooterWidget extends StatelessWidget {
  const AuthPromptFooterWidget({
    super.key,
    required this.prompt,
    required this.linkLabel,
    required this.onLinkTap,
    this.linkColor = AppColors.primaryMustard,
  });

  final String prompt;
  final String linkLabel;
  final VoidCallback onLinkTap;
  final Color linkColor;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Column(
      children: [
        AppText(
          prompt,
          variant: AppTextVariant.sectionCaption,
          color: AppColors.darkNavy,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: layout.spacing(8)),
        YouPassLinkText(
          label: linkLabel,
          color: linkColor,
          onTap: onLinkTap,
        ),
      ],
    );
  }
}
