import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/auth_curve_background.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.body,
    this.showBackButton = false,
    this.onBackPressed,
    this.topBar,
  });

  final Widget body;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? topBar;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const AuthCurveBackground(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ?topBar,
                if (showBackButton)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed:
                          onBackPressed ?? () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).colorScheme.onSurface,
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
