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
    this.actionIcon,
    this.actionSelected = false,
    this.actionLoading = false,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final IconData? actionIcon;
  final bool actionSelected;
  final bool actionLoading;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final actionColor = actionSelected
        ? AppColors.primaryMustard
        : AppColors.homeAccentYellow;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AppText(title, variant: AppTextVariant.sectionTitle),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: actionLoading ? null : onActionTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (actionLoading)
                  SizedBox(
                    width: layout.fontSize(14),
                    height: layout.fontSize(14),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: actionColor,
                    ),
                  )
                else if (actionIcon != null)
                  Icon(
                    actionIcon,
                    size: layout.fontSize(17),
                    color: actionColor,
                  ),
                if (actionLoading || actionIcon != null)
                  SizedBox(width: layout.spacing(5)),
                AppText(
                  actionLabel!,
                  variant: AppTextVariant.bodyEmphasis,
                  color: actionColor,
                  fontSize: layout.fontSize(13),
                ),
                if (actionIcon == null && !actionLoading)
                  Icon(
                    Icons.chevron_right,
                    size: layout.fontSize(16),
                    color: actionColor,
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
