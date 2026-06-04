import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_button_theme.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';

class YouPassOutlineButton extends StatelessWidget {
  const YouPassOutlineButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isEnabled;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);
    final style = YouPassButtonTheme.outlineElevatedStyle(context);
    final effectiveOnPressed =
        isEnabled && !isLoading ? onPressed : null;

    final Widget child;
    if (isLoading) {
      child = SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: theme.outlineButtonForeground,
        ),
      );
    } else if (icon != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label),
        ],
      );
    } else {
      child = Text(label);
    }

    final button = ElevatedButton(
      onPressed: effectiveOnPressed,
      style: style,
      child: child,
    );

    if (!fullWidth) {
      return button;
    }

    return SizedBox(
      width: double.infinity,
      child: button,
    );
  }
}
