import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_assets.dart';

class AppAssetImage extends StatelessWidget {
  const AppAssetImage({
    super.key,
    this.assetPath = AppAssets.dummyImage,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
  });

  final String assetPath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      assetPath,
      fit: fit,
      width: width,
      height: height,
    );

    if (borderRadius == null) {
      return image;
    }

    return ClipRRect(
      borderRadius: borderRadius!,
      child: image,
    );
  }
}
