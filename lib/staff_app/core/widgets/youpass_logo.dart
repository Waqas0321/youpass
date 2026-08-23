import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/youpass_brand_logo.dart';

/// Staff app YouPass mark — always the official brand image asset.
class YouPassLogo extends StatelessWidget {
  const YouPassLogo({
    super.key,
    this.fontStyle = FontStyle.normal,
    this.color,
    this.width,
    this.compact = true,
  });

  /// Unused — retained for backward compatibility with older call sites.
  final FontStyle fontStyle;
  final Color? color;
  final double? width;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: YouPassBrandLogo(
        width: width,
        color: color,
        compact: compact,
      ),
    );
  }
}
