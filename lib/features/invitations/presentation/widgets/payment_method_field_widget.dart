import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';

class PaymentMethodFieldWidget extends StatelessWidget {
  const PaymentMethodFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.icon,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: YouPassDialogTheme.title(context),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          style: TextStyle(color: YouPassThemedColors.primaryText(context)),
          decoration: InputDecoration(
            hintText: hint,
            counterText: '',
            hintStyle: TextStyle(color: YouPassThemedColors.secondaryText(context)),
            prefixIcon: icon == null
                ? null
                : Icon(
                    icon,
                    size: 18,
                    color: YouPassThemedColors.secondaryText(context),
                  ),
            filled: true,
            fillColor: theme.inputFill,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: theme.cardBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: theme.cardBorder),
            ),
          ),
        ),
      ],
    );
  }
}
