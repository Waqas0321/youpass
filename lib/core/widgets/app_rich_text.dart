import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/app_text_style_resolver.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class AppRichText extends StatelessWidget {
  const AppRichText({
    super.key,
    required this.children,
    this.variant = AppTextVariant.body,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final List<InlineSpan> children;
  final AppTextVariant variant;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  static TextSpan span(
    BuildContext context,
    String text, {
    AppTextVariant variant = AppTextVariant.body,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextSpan(
      text: text,
      style: AppTextStyleResolver.resolve(
        context,
        variant,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      text: TextSpan(
        style: AppTextStyleResolver.resolve(context, variant),
        children: children,
      ),
    );
  }
}
