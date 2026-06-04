import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_theme.dart';

class YouPassShimmerBox extends StatelessWidget {
  const YouPassShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.margin,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: YouPassShimmerTheme.base,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
