import 'package:flutter/material.dart';
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
    final scheme = Theme.of(context).colorScheme;

    return Icon(
      icon,
      size: layout.fontSize(22),
      color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
    );
  }
}
