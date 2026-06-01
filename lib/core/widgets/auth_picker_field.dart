import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/auth_field_container.dart';
import 'package:youpass/core/widgets/auth_field_icon_widget.dart';
import 'package:youpass/core/widgets/auth_labeled_field_widget.dart';

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
    final hasValue = value != null && value!.isNotEmpty;

    return AuthLabeledFieldWidget(
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(layout.radius(12)),
          child: AuthFieldContainer(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: layout.spacing(14),
                vertical: layout.spacing(16),
              ),
              child: Row(
                children: [
                  AuthFieldIconWidget(icon: icon),
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
      ),
    );
  }
}
