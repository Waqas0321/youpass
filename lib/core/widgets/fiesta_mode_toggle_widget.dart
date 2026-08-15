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
    final thumbSize = layout.spacing(36);
    final horizontalPad = layout.spacing(4);
    final brandColor =
        isFiestaMode ? AppColors.homeAccentYellow : AppColors.homeBlack;
    final trackColor =
        isFiestaMode ? AppColors.homeBlack : const Color(0xFFF2F2F2);
    final borderColor = isFiestaMode
        ? AppColors.homeAccentYellow.withValues(alpha: 0.55)
        : const Color(0xFFE0E0E0);
    final badgeLabel = isFiestaMode
        ? AppStrings.brandBadgeOn(l10n)
        : AppStrings.brandBadgeOff(l10n);
    final modeLabel = AppStrings.brandModeFiesta(l10n);

    return Semantics(
      button: true,
      label: modeLabel,
      toggled: isFiestaMode,
      child: GestureDetector(
        onTap: onToggle,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: FiestaModeToggleConstants.toggleDuration,
          curve: Curves.easeInOut,
          width: trackWidth,
          height: trackHeight,
          padding: EdgeInsets.symmetric(horizontal: horizontalPad),
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(trackHeight),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedAlign(
                duration: FiestaModeToggleConstants.toggleDuration,
                curve: Curves.easeInOut,
                alignment:
                    isFiestaMode ? Alignment.centerLeft : Alignment.centerRight,
                child: FiestaModeToggleBrandLabelWidget(
                  color: brandColor,
                  fontSize: layout.fontSize(13),
                ),
              ),
              AnimatedAlign(
                duration: FiestaModeToggleConstants.toggleDuration,
                curve: Curves.easeInOut,
                alignment:
                    isFiestaMode ? Alignment.centerRight : Alignment.centerLeft,
                child: FiestaModeToggleThumbWidget(
                  size: thumbSize,
                  isFiestaMode: isFiestaMode,
                  badgeLabel: badgeLabel,
                  modeLabel: modeLabel,
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
