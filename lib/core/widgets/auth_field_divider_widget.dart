import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

class AuthFieldDividerWidget extends StatelessWidget {
  const AuthFieldDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Container(
      width: 1,
      height: layout.spacing(28),
      color: AppColors.lightGreyBorder,
    );
  }
}
