import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';

/// Themed dialog container shared across YouPass modal dialogs.
class YouPassThemedDialogShell extends StatelessWidget {
  const YouPassThemedDialogShell({
    super.key,
    required this.child,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: 28),
    this.padding = const EdgeInsets.fromLTRB(24, 28, 24, 20),
    this.borderRadius = 20,
  });

  final Widget child;
  final EdgeInsets insetPadding;
  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: insetPadding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: YouPassDialogTheme.background(context),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: YouPassDialogTheme.border(context)),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
