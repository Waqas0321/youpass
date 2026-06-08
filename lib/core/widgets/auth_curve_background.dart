import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

class AuthCurveBackground extends StatelessWidget {
  const AuthCurveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);
    final curveSize = layout.curveSize;

    return Positioned(
      top: -layout.spacing(40),
      right: -layout.spacing(60),
      child: Container(
        width: curveSize,
        height: curveSize,
        decoration: BoxDecoration(
          color: theme.authCurveAccent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
