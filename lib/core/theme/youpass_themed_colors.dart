import 'package:flutter/material.dart';

/// Shared semantic colors for light and dark themes.
class YouPassThemedColors {
  YouPassThemedColors._();

  static Color primaryText(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color secondaryText(BuildContext context) =>
      Theme.of(context).colorScheme.onSurfaceVariant;

  static Color screenBackground(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;
}
