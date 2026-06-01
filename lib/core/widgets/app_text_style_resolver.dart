import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class AppTextStyleResolver {
  AppTextStyleResolver._();

  static TextStyle resolve(
    BuildContext context,
    AppTextVariant variant, {
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    final layout = ResponsiveLayout(context);
    final base = _baseStyle(layout, variant);

    return base.copyWith(
      color: color ?? base.color,
      fontSize: fontSize ?? base.fontSize,
      fontWeight: fontWeight ?? base.fontWeight,
      letterSpacing: letterSpacing ?? base.letterSpacing,
      height: height ?? base.height,
    );
  }

  static TextStyle _baseStyle(ResponsiveLayout layout, AppTextVariant variant) {
    switch (variant) {
      case AppTextVariant.title:
        return TextStyle(
          fontSize: layout.titleFontSize,
          fontWeight: FontWeight.w800,
          color: AppColors.darkNavy,
          letterSpacing: 0.5,
        );
      case AppTextVariant.body:
        return TextStyle(
          fontSize: layout.bodyFontSize,
          height: 1.4,
          color: AppColors.secondaryGrey,
        );
      case AppTextVariant.bodyEmphasis:
        return TextStyle(
          fontSize: layout.bodyFontSize,
          height: 1.4,
          fontWeight: FontWeight.w700,
          color: AppColors.darkNavy,
        );
      case AppTextVariant.label:
        return TextStyle(
          fontSize: layout.labelFontSize,
          fontWeight: FontWeight.w700,
          color: AppColors.darkNavy,
          letterSpacing: 0.8,
        );
      case AppTextVariant.button:
        return TextStyle(
          fontSize: layout.fontSize(15),
          fontWeight: FontWeight.w800,
          color: AppColors.darkNavy,
          letterSpacing: 0.5,
        );
      case AppTextVariant.link:
        return TextStyle(
          fontSize: layout.bodyFontSize,
          fontWeight: FontWeight.w600,
          color: AppColors.linkBlue,
        );
      case AppTextVariant.sectionCaption:
        return TextStyle(
          fontSize: layout.fontSize(11),
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryGrey,
          letterSpacing: 0.5,
        );
      case AppTextVariant.headline:
        return TextStyle(
          fontSize: layout.fontSize(28),
          fontWeight: FontWeight.w700,
          color: AppColors.darkNavy,
        );
      case AppTextVariant.bodyLarge:
        return TextStyle(
          fontSize: layout.fontSize(16),
          color: AppColors.secondaryGrey,
        );
      case AppTextVariant.appBar:
        return TextStyle(
          fontSize: layout.fontSize(18),
          fontWeight: FontWeight.w600,
          color: AppColors.darkNavy,
        );
      case AppTextVariant.listTitle:
        return TextStyle(
          fontSize: layout.fontSize(16),
          fontWeight: FontWeight.w600,
          color: AppColors.darkNavy,
        );
      case AppTextVariant.listTrailing:
        return TextStyle(
          fontSize: layout.fontSize(15),
          fontWeight: FontWeight.w700,
          color: AppColors.secondaryGrey,
        );
      case AppTextVariant.dialCode:
        return TextStyle(
          fontSize: layout.fontSize(15),
          fontWeight: FontWeight.w600,
          color: AppColors.darkNavy,
        );
      case AppTextVariant.emojiMedium:
        return TextStyle(fontSize: layout.fontSize(20));
      case AppTextVariant.emojiLarge:
        return TextStyle(fontSize: layout.fontSize(24));
      case AppTextVariant.otpPlaceholder:
        return TextStyle(
          fontSize: layout.fontSize(18),
          color: AppColors.secondaryGrey.withValues(alpha: 0.5),
        );
      case AppTextVariant.error:
        return TextStyle(
          fontSize: layout.bodyFontSize,
          color: AppColors.darkNavy,
        );
      case AppTextVariant.timer:
        return TextStyle(
          fontSize: layout.bodyFontSize,
          fontWeight: FontWeight.w700,
          color: AppColors.homeAccentYellow,
        );
      case AppTextVariant.greetingTitle:
        return TextStyle(
          fontSize: layout.fontSize(28),
          fontWeight: FontWeight.w800,
          color: AppColors.homeBlack,
        );
      case AppTextVariant.sectionTitle:
        return TextStyle(
          fontSize: layout.fontSize(18),
          fontWeight: FontWeight.w800,
          color: AppColors.homeBlack,
        );
    }
  }
}
