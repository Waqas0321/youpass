import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class AuthPickerField extends StatelessWidget {
  const AuthPickerField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.onTap,
    this.value,
  });

  final String label;
  final String hintText;
  final IconData icon;
  final VoidCallback onTap;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final fieldRadius = layout.radius(12);
    final hasValue = value != null && value!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, variant: AppTextVariant.label),
        SizedBox(height: layout.spacing(8)),
        Material(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(fieldRadius),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(fieldRadius),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(fieldRadius),
                border: Border.all(color: AppColors.lightGreyBorder),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: layout.spacing(14),
                vertical: layout.spacing(16),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: layout.fontSize(22),
                    color: AppColors.secondaryGrey.withValues(alpha: 0.7),
                  ),
                  SizedBox(width: layout.spacing(12)),
                  Expanded(
                    child: AppText(
                      hasValue ? value! : hintText,
                      variant: AppTextVariant.body,
                      color: hasValue
                          ? AppColors.darkNavy
                          : AppColors.secondaryGrey.withValues(alpha: 0.6),
                      fontWeight:
                          hasValue ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: layout.fontSize(22),
                    color: AppColors.secondaryGrey.withValues(alpha: 0.8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
