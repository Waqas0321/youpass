import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/theme/youpass_theme_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_field_variant.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.validator,
    this.variant = AppTextFieldVariant.outlined,
    this.obscureText = false,
    this.keyboardType,
    this.readOnly = false,
    this.enabled = true,
    this.maxLength,
    this.onChanged,
    this.inputFormatters,
    this.textInputAction,
    this.autofocus = false,
    this.contentPadding,
    this.enableInteractiveSelection = true,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final AppTextFieldVariant variant;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool enabled;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final bool enableInteractiveSelection;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);
    final scheme = Theme.of(context).colorScheme;
    final fieldStyle = TextStyle(
      fontSize: layout.fontSize(16),
      color: scheme.onSurface,
      fontWeight: FontWeight.w500,
    );
    final hintStyle = TextStyle(
      fontSize: layout.fontSize(16),
      color: scheme.onSurfaceVariant.withValues(alpha: 0.6),
    );
    final decoration = _buildDecoration(context, layout, theme, hintStyle);
    final field = TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      readOnly: readOnly,
      enabled: enabled,
      maxLength: maxLength,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      autofocus: autofocus,
      enableInteractiveSelection: enableInteractiveSelection,
      style: fieldStyle,
      decoration: decoration,
    );

    if (labelText == null) {
      return field;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(labelText!, variant: AppTextVariant.label),
        SizedBox(height: layout.spacing(8)),
        field,
      ],
    );
  }

  InputDecoration _buildDecoration(
    BuildContext context,
    ResponsiveLayout layout,
    YouPassThemeExtension theme,
    TextStyle hintStyle,
  ) {
    final radius = BorderRadius.circular(layout.radius(12));
    final padding = contentPadding ??
        EdgeInsets.symmetric(
          horizontal: layout.spacing(12),
          vertical: layout.spacing(16),
        );

    switch (variant) {
      case AppTextFieldVariant.borderless:
        return InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: padding,
          counterText: '',
        );
      case AppTextFieldVariant.outlined:
        return InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          filled: true,
          fillColor: theme.inputFill,
          contentPadding: padding,
          border: OutlineInputBorder(
            borderRadius: radius,
            borderSide: BorderSide(color: theme.cardBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: BorderSide(color: theme.cardBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(
              color: AppColors.primaryMustard,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: Colors.red),
          ),
          counterText: '',
        );
    }
  }
}
