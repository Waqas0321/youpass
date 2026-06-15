import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';

class DrawerYouPassLogo extends StatelessWidget {
  const DrawerYouPassLogo({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: YouPassLogo(
        fontStyle: FontStyle.normal,
        color: color ?? AppColors.primaryMustard,
      ),
    );
  }
}
