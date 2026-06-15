import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';

class EventNetworkImage extends StatelessWidget {
  const EventNetworkImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.useShimmerPlaceholder = false,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool useShimmerPlaceholder;

  bool get _hasExplicitSize => width != null || height != null;

  @override
  Widget build(BuildContext context) {
    final resolvedUrl = imageUrl?.trim();
    final Widget image;

    if (resolvedUrl == null || resolvedUrl.isEmpty) {
      image = _buildPlaceholder();
    } else {
      image = _buildNetworkImage(resolvedUrl);
    }

    if (borderRadius == null) {
      return image;
    }

    return ClipRRect(
      borderRadius: borderRadius!,
      child: image,
    );
  }

  Widget _buildNetworkImage(String url) {
    final networkImage = Image.network(
      url,
      fit: fit,
      width: _hasExplicitSize ? width : double.infinity,
      height: _hasExplicitSize ? height : double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return _buildPlaceholder(showProgress: true);
      },
      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
    );

    if (_hasExplicitSize) {
      return networkImage;
    }

    return SizedBox.expand(child: networkImage);
  }

  Widget _buildPlaceholder({bool showProgress = false}) {
    if (showProgress && useShimmerPlaceholder) {
      return YouPassShimmer(
        child: _hasExplicitSize
            ? YouPassShimmerBox(
                width: width,
                height: height,
                borderRadius: 0,
              )
            : const SizedBox.expand(
                child: YouPassShimmerBox(borderRadius: 0),
              ),
      );
    }

    final content = Center(
      child: showProgress
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(
              Icons.image_outlined,
              size: _hasExplicitSize
                  ? ((width ?? height ?? 28) * 0.28).clamp(20.0, 36.0)
                  : 28,
              color: AppColors.secondaryGrey,
            ),
    );

    if (_hasExplicitSize) {
      return ColoredBox(
        color: AppColors.homeDividerGrey,
        child: SizedBox(
          width: width,
          height: height,
          child: content,
        ),
      );
    }

    return ColoredBox(
      color: AppColors.homeDividerGrey,
      child: SizedBox.expand(child: content),
    );
  }
}
