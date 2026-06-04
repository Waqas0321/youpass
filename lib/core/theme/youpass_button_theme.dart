import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';

class YouPassButtonTheme {
  YouPassButtonTheme._();

  static const double outlineBorderRadius = 28;
  static const double outlineVerticalPadding = 14;
  static const double outlineHorizontalPadding = 24;
  static const double outlineElevation = 3;

  static ButtonStyle outlineElevatedStyle(
    BuildContext context, {
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    final theme = YouPassThemeExtension.of(context);

    return ElevatedButton.styleFrom(
      elevation: outlineElevation,
      shadowColor: AppColors.scrimBase.withValues(alpha: 0.18),
      backgroundColor: theme.outlineButtonFill,
      foregroundColor: theme.outlineButtonForeground,
      disabledBackgroundColor: theme.outlineButtonFill.withValues(alpha: 0.6),
      disabledForegroundColor:
          theme.outlineButtonForeground.withValues(alpha: 0.45),
      side: BorderSide(
        color: theme.outlineButtonBorder,
        width: 1,
      ),
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: outlineHorizontalPadding,
            vertical: outlineVerticalPadding,
          ),
      shape: RoundedRectangleBorder(
        borderRadius:
            borderRadius ?? BorderRadius.circular(outlineBorderRadius),
      ),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
