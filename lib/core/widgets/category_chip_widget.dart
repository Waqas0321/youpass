import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class CategoryChipWidget extends StatelessWidget {
  const CategoryChipWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final chipRadius = layout.radius(20);
    final selectedFill = AppColors.primaryMustard;
    final unselectedBorder = AppColors.lightGreyBorder;
    final foregroundColor =
        isSelected ? AppColors.backgroundWhite : AppColors.homeBlack;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(chipRadius),
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected ? selectedFill : AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(chipRadius),
            border: Border.all(
              color: isSelected ? selectedFill : unselectedBorder,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: layout.spacing(16),
              vertical: layout.spacing(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: layout.fontSize(16),
                  color: foregroundColor,
                ),
                SizedBox(width: layout.spacing(8)),
                AppText(
                  label,
                  variant: AppTextVariant.bodyEmphasis,
                  color: foregroundColor,
                  fontSize: layout.fontSize(14),
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
