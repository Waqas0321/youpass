import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/youpass_brand_logo.dart';

/// App-wide YouPass mark — always the official branded logo image.
///
/// Kept as a stable API so existing call sites (app bars, VIP, drawer, etc.)
/// pick up the splash/login brand asset automatically.
class YouPassLogo extends StatelessWidget {
  const YouPassLogo({
    super.key,
    this.fontStyle = FontStyle.normal,
    this.color,
    this.width,
  });

  /// Unused — retained for backward compatibility with older call sites.
  final FontStyle fontStyle;
  final Color? color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return YouPassBrandLogo(
      width: width,
      color: color,
      compact: width == null,
    );
  }
}
