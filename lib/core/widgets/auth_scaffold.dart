import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/auth_curve_background.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.body,
    this.showBackButton = false,
    this.onBackPressed,
  });

  final Widget body;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Stack(
          children: [
            const AuthCurveBackground(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showBackButton)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed:
                          onBackPressed ?? () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.darkNavy,
                        size: layout.iconSize,
                      ),
                    ),
                  ),
                Expanded(child: body),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
