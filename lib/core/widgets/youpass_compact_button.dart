import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class YouPassCompactButton extends StatelessWidget {
  const YouPassCompactButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Material(
      color: AppColors.homeAccentYellow,
      borderRadius: BorderRadius.circular(layout.radius(8)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(layout.radius(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: layout.spacing(10),
            vertical: layout.spacing(6),
          ),
          child: AppText(
            label,
            variant: AppTextVariant.button,
            color: AppColors.homeBlack,
            fontSize: layout.fontSize(10),
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
