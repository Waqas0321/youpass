import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

class AuthFieldIconWidget extends StatelessWidget {
  const AuthFieldIconWidget({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Icon(
      icon,
      size: layout.fontSize(22),
      color: AppColors.secondaryGrey.withValues(alpha: 0.7),
    );
  }
}
