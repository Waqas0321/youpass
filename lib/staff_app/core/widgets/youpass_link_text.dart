import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';

class YouPassLinkText extends StatelessWidget {
  const YouPassLinkText({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
    this.underline = true,
  });

  final String label;
  final VoidCallback onTap;
  final Color? color;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    final linkColor = color ?? Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: AppText(
        label,
        variant: AppTextVariant.link,
        color: linkColor,
        style: TextStyle(
          color: linkColor,
          decoration: underline ? TextDecoration.underline : null,
          decorationColor: linkColor,
        ),
      ),
    );
  }
}
