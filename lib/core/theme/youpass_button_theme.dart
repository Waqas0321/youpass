import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';

class YouPassButtonTheme {
  YouPassButtonTheme._();

  static const double outlineBorderRadius = 28;
  static const double outlineVerticalPadding = 14;
  static const double outlineHorizontalPadding = 24;
  static const double outlineElevation = 3;

  static ButtonStyle outlineElevatedStyle({
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton.styleFrom(
      elevation: outlineElevation,
      shadowColor: AppColors.scrimBase.withValues(alpha: 0.18),
      backgroundColor: AppColors.outlineButtonFill,
      foregroundColor: AppColors.outlineButtonForeground,
      disabledBackgroundColor:
          AppColors.outlineButtonFill.withValues(alpha: 0.6),
      disabledForegroundColor:
          AppColors.outlineButtonForeground.withValues(alpha: 0.45),
      side: const BorderSide(
        color: AppColors.outlineButtonBorder,
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
