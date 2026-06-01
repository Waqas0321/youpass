import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Row(
      children: [
        Expanded(
          child: AppText(title, variant: AppTextVariant.sectionTitle),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onActionTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  actionLabel!,
                  variant: AppTextVariant.bodyEmphasis,
                  color: AppColors.homeAccentYellow,
                  fontSize: layout.fontSize(14),
                ),
                Icon(
                  Icons.chevron_right,
                  size: layout.fontSize(18),
                  color: AppColors.homeAccentYellow,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
