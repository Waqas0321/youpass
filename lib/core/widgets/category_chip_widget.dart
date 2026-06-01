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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(24)),
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.homeAccentYellow : AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(layout.radius(24)),
            border: Border.all(
              color: isSelected
                  ? AppColors.homeAccentYellow
                  : AppColors.lightGreyBorder,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: layout.spacing(16),
              vertical: layout.spacing(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: layout.fontSize(18),
                  color: isSelected
                      ? AppColors.backgroundWhite
                      : AppColors.secondaryGrey,
                ),
                SizedBox(width: layout.spacing(8)),
                AppText(
                  label,
                  variant: AppTextVariant.bodyEmphasis,
                  color: isSelected
                      ? AppColors.backgroundWhite
                      : AppColors.homeBlack,
                  fontSize: layout.fontSize(14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
