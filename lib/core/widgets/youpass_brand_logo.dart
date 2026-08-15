import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

/// Official YouPass wordmark image (same asset as splash).
///
/// The source PNG is square with large empty padding, so this widget uses a
/// short viewport + [BoxFit.cover] to show only the brand glyph band.
class YouPassBrandLogo extends StatelessWidget {
  const YouPassBrandLogo({
    super.key,
    this.width,
    this.color,
    this.compact = false,
  });

  final double? width;
  final Color? color;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final logoWidth = width ??
        (compact
            ? layout.spacing(200).clamp(180.0, 230.0)
            : (layout.width * 0.55).clamp(180.0, 240.0));
    final logoHeight = logoWidth * 0.32;

    Widget image = Image.asset(
      AppAssets.youpassLogo,
      fit: BoxFit.cover,
      alignment: const Alignment(0, -0.08),
      filterQuality: FilterQuality.high,
      gaplessPlayback: true,
    );

    final tint = color;
    if (tint != null && tint != AppColors.primaryMustard) {
      image = ColorFiltered(
        colorFilter: ColorFilter.mode(tint, BlendMode.srcATop),
        child: image,
      );
    }

    return SizedBox(
      width: logoWidth,
      height: logoHeight,
      child: image,
    );
  }
}
