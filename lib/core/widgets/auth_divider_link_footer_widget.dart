import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_link_text.dart';

class AuthDividerLinkFooterWidget extends StatelessWidget {
  const AuthDividerLinkFooterWidget({
    super.key,
    required this.caption,
    required this.linkLabel,
    required this.onLinkTap,
    this.linkColor = AppColors.primaryMustard,
  });

  final String caption;
  final String linkLabel;
  final VoidCallback onLinkTap;
  final Color linkColor;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: layout.spacing(12)),
              child: AppText(
                caption,
                variant: AppTextVariant.sectionCaption,
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),
        SizedBox(height: layout.spacing(16)),
        YouPassLinkText(
          label: linkLabel,
          color: linkColor,
          onTap: onLinkTap,
        ),
      ],
    );
  }
}
