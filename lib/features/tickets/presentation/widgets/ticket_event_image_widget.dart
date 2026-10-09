import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/app_asset_image.dart';
import 'package:youpass/core/widgets/event_network_image.dart';

class TicketEventImageWidget extends StatelessWidget {
  const TicketEventImageWidget({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  bool get _usesNetwork {
    final value = imagePath.trim().toLowerCase();
    return value.startsWith('http://') || value.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    // No event image: neutral placeholder (same as home), not the stock dummy photo.
    if (_usesNetwork || imagePath.trim().isEmpty) {
      return EventNetworkImage(
        imageUrl: imagePath,
        width: width,
        height: height,
        fit: fit,
        borderRadius: borderRadius,
      );
    }

    return AppAssetImage(
      assetPath: imagePath,
      width: width,
      height: height,
      fit: fit,
      borderRadius: borderRadius,
    );
  }
}
