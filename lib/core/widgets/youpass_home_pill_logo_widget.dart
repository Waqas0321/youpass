import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

/// Static YouPass pill shown in the home header when party mode is unavailable.
class YouPassHomePillLogoWidget extends StatelessWidget {
  const YouPassHomePillLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final trackWidth = layout.spacing(132);
    final trackHeight = layout.spacing(42);

    return SizedBox(
      width: trackWidth,
      height: trackHeight,
      child: Image.asset(
        AppAssets.youpassPartyModeOffPill,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        gaplessPlayback: true,
      ),
    );
  }
}
