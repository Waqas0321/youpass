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
    this.actionSemanticLabel,
    this.onActionTap,
    this.actionIcon,
    this.actionIconSize,
    this.actionSelected = false,
    this.actionLoading = false,
  });

  final String title;
  final String? actionLabel;
  final String? actionSemanticLabel;
  final VoidCallback? onActionTap;
  final IconData? actionIcon;
  final double? actionIconSize;
  final bool actionSelected;
  final bool actionLoading;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final actionColor = actionSelected
        ? AppColors.primaryMustard
        : AppColors.homeAccentYellow;
    final hasAction =
        actionLabel != null || actionIcon != null || actionLoading;
    final iconSize = actionIconSize ?? layout.fontSize(17);
    final showActionLabel = actionLabel != null && actionLabel!.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AppText(title, variant: AppTextVariant.sectionTitle),
        ),
        if (hasAction)
          Semantics(
            button: true,
            label: actionSemanticLabel ?? actionLabel,
            toggled: actionSelected,
            child: GestureDetector(
              onTap: actionLoading ? null : onActionTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (actionLoading)
                    SizedBox(
                      width: iconSize,
                      height: iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: actionColor,
                      ),
                    )
                  else if (actionIcon != null)
                    Icon(
                      actionIcon,
                      size: iconSize,
                      color: actionColor,
                    ),
                  if (showActionLabel) ...[
                    if (actionLoading || actionIcon != null)
                      SizedBox(width: layout.spacing(5)),
                    AppText(
                      actionLabel!,
                      variant: AppTextVariant.bodyEmphasis,
                      color: actionColor,
                      fontSize: layout.fontSize(13),
                    ),
                  ],
                  if (actionIcon == null && !actionLoading && showActionLabel)
                    Icon(
                      Icons.chevron_right,
                      size: layout.fontSize(16),
                      color: actionColor,
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
