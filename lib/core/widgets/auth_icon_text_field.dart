import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_field.dart';
import 'package:youpass/core/widgets/app_text_field_variant.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class AuthIconTextField extends StatelessWidget {
  const AuthIconTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType,
    this.textInputAction,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final fieldRadius = layout.radius(12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, variant: AppTextVariant.label),
        SizedBox(height: layout.spacing(8)),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(fieldRadius),
            border: Border.all(color: AppColors.lightGreyBorder),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: layout.spacing(14)),
                child: Icon(
                  icon,
                  size: layout.fontSize(22),
                  color: AppColors.secondaryGrey.withValues(alpha: 0.7),
                ),
              ),
              Expanded(
                child: AppTextField(
                  controller: controller,
                  hintText: hintText,
                  variant: AppTextFieldVariant.borderless,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: layout.spacing(12),
                    vertical: layout.spacing(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
