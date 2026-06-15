import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
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
    this.leadingEmoji,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final String? leadingEmoji;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);
    final chipRadius = layout.radius(20);
    final foregroundColor = isSelected
        ? theme.chipSelectedForeground
        : theme.chipUnselectedForeground;
    final fillColor = isSelected
        ? theme.chipSelectedBackground
        : theme.chipUnselectedBackground;
    final borderColor = isSelected
        ? theme.chipSelectedBackground
        : theme.chipUnselectedBorder;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(chipRadius),
        child: Ink(
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(chipRadius),
            border: Border.all(color: borderColor),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: layout.spacing(16),
              vertical: layout.spacing(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingEmoji != null)
                  AppText(
                    leadingEmoji!,
                    variant: AppTextVariant.emojiMedium,
                    fontSize: layout.fontSize(16),
                  )
                else
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
