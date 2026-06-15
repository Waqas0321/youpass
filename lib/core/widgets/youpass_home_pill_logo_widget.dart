import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_brand_label_widget.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_thumb_widget.dart';

/// Static production-state YouPass pill shown in the home header.
class YouPassHomePillLogoWidget extends StatelessWidget {
  const YouPassHomePillLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final trackWidth = layout.spacing(132);
    final trackHeight = layout.spacing(42);
    final thumbSize = layout.spacing(34);
    final trackPadding = layout.spacing(4);

    return SizedBox(
      width: trackWidth,
      height: trackHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.homeBlack,
          borderRadius: BorderRadius.circular(trackHeight),
        ),
        child: Padding(
          padding: EdgeInsets.all(trackPadding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: FiestaModeToggleBrandLabelWidget(
                  color: AppColors.homeAccentYellow,
                  fontSize: layout.fontSize(13),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FiestaModeToggleThumbWidget(
                  size: thumbSize,
                  isFiestaMode: false,
                  badgeLabel: AppStrings.brandBadgeOff(l10n),
                  modeLabel: AppStrings.brandModeProduction(l10n),
                  layout: layout,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
