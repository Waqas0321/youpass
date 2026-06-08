import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

class AuthFieldDividerWidget extends StatelessWidget {
  const AuthFieldDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);

    return Container(
      width: 1,
      height: layout.spacing(28),
      color: theme.cardBorder,
    );
  }
}
