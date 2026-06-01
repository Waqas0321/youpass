import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text_field.dart';
import 'package:youpass/core/widgets/app_text_field_variant.dart';
import 'package:youpass/core/widgets/auth_field_container.dart';
import 'package:youpass/core/widgets/auth_field_icon_widget.dart';
import 'package:youpass/core/widgets/auth_labeled_field_widget.dart';

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

    return AuthLabeledFieldWidget(
      label: label,
      child: AuthFieldContainer(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: layout.spacing(14)),
              child: AuthFieldIconWidget(icon: icon),
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
    );
  }
}
