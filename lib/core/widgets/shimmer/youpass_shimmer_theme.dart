import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';

class YouPassShimmerTheme {
  YouPassShimmerTheme._();

  static const Duration duration = Duration(milliseconds: 1300);

  static Color baseFor(BuildContext context) {
    return YouPassThemeExtension.of(context).shimmerBase;
  }

  static Color highlightFor(BuildContext context) {
    return YouPassThemeExtension.of(context).shimmerHighlight;
  }
}
