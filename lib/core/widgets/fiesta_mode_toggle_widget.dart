import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_brand_label_widget.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_constants.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_thumb_widget.dart';

class FiestaModeToggleWidget extends StatelessWidget {
  const FiestaModeToggleWidget({
    super.key,
    required this.isFiestaMode,
    required this.onToggle,
  });

  final bool isFiestaMode;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final trackWidth = layout.spacing(132);
    final trackHeight = layout.spacing(42);
    final thumbSize = layout.spacing(34);
    final trackPadding = layout.spacing(4);

    final trackColor =
        isFiestaMode ? AppColors.homeAccentYellow : AppColors.homeBlack;
    final brandColor =
        isFiestaMode ? AppColors.homeBlack : AppColors.homeAccentYellow;

    return Semantics(
      button: true,
      label: isFiestaMode
          ? AppStrings.brandModeFiesta(l10n)
          : AppStrings.brandModeProduction(l10n),
      toggled: isFiestaMode,
      child: GestureDetector(
        onTap: onToggle,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: FiestaModeToggleConstants.toggleDuration,
          curve: Curves.easeInOut,
          width: trackWidth,
          height: trackHeight,
          padding: EdgeInsets.all(trackPadding),
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(trackHeight),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedAlign(
                duration: FiestaModeToggleConstants.toggleDuration,
                curve: Curves.easeInOut,
                alignment: isFiestaMode
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: FiestaModeToggleBrandLabelWidget(
                  color: brandColor,
                  fontSize: layout.fontSize(13),
                ),
              ),
              AnimatedAlign(
                duration: FiestaModeToggleConstants.toggleDuration,
                curve: Curves.easeInOut,
                alignment: isFiestaMode
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: FiestaModeToggleThumbWidget(
                  size: thumbSize,
                  isFiestaMode: isFiestaMode,
                  badgeLabel: isFiestaMode
                      ? AppStrings.brandBadgeOn(l10n)
                      : AppStrings.brandBadgeOff(l10n),
                  modeLabel: isFiestaMode
                      ? AppStrings.brandModeFiesta(l10n)
                      : AppStrings.brandModeProduction(l10n),
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
