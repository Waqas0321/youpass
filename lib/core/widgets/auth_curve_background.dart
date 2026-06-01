import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

class AuthCurveBackground extends StatelessWidget {
  const AuthCurveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final curveSize = layout.curveSize;

    return Positioned(
      top: -layout.spacing(40),
      right: -layout.spacing(60),
      child: Container(
        width: curveSize,
        height: curveSize,
        decoration: const BoxDecoration(
          color: AppColors.curveAccent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
