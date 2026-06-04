import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';

/// Circular icon badge used at the top of YouPass dialogs.
class YouPassDialogIconBadge extends StatelessWidget {
  const YouPassDialogIconBadge({
    super.key,
    required this.icon,
    this.size = 56,
    this.iconSize = 30,
    this.backgroundColor,
    this.iconColor,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? YouPassDialogTheme.iconBadgeBackground(context),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: iconColor ?? YouPassDialogTheme.iconColor(context),
        size: iconSize,
      ),
    );
  }
}
