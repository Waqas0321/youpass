import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/youpass_brand_logo.dart';

/// Official YouPass brand mark for the side drawer header.
class DrawerYouPassLogo extends StatelessWidget {
  const DrawerYouPassLogo({
    super.key,
    this.color,
  });

  /// Unused — kept for call-site compatibility. The official asset keeps
  /// its brand colors so it does not look like a placeholder text logo.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    // Match the enlarged auth/login brand mark as closely as the drawer allows.
    final logoWidth = (layout.width * 0.5).clamp(200.0, 280.0);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: YouPassBrandLogo(width: logoWidth),
    );
  }
}
