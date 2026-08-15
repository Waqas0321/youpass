import 'package:flutter/material.dart';
import 'package:youpass/staff_app/core/widgets/app_text_style_resolver.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.variant = AppTextVariant.body,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.height,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  final String data;
  final AppTextVariant variant;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? height;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = AppTextStyleResolver.resolve(
      context,
      variant,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );

    final effectiveStyle =
        style == null ? resolvedStyle : resolvedStyle.merge(style);

    return Text(
      data,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
