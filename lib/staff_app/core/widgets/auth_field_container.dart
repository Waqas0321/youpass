import 'package:flutter/material.dart';
import 'package:youpass/staff_app/core/theme/youpass_theme_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';

class AuthFieldContainer extends StatelessWidget {
  const AuthFieldContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.inputFill,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        border: Border.all(color: theme.cardBorder),
      ),
      child: child,
    );
  }
}
