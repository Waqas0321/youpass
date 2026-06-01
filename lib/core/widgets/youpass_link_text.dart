import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class YouPassLinkText extends StatelessWidget {
  const YouPassLinkText({
    super.key,
    required this.label,
    required this.onTap,
    this.color = AppColors.linkBlue,
    this.underline = true,
  });

  final String label;
  final VoidCallback onTap;
  final Color color;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppText(
        label,
        variant: AppTextVariant.link,
        color: color,
        style: TextStyle(
          color: color,
          decoration: underline ? TextDecoration.underline : null,
          decorationColor: color,
        ),
      ),
    );
  }
}
