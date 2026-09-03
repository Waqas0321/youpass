import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_brand_label_widget.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_constants.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_thumb_widget.dart';

class FiestaModeToggleWidget extends StatefulWidget {
  const FiestaModeToggleWidget({
    super.key,
    required this.isFiestaMode,
    required this.onToggle,
  });

  final bool isFiestaMode;
  final VoidCallback onToggle;

  @override
  State<FiestaModeToggleWidget> createState() => _FiestaModeToggleWidgetState();
}

class _FiestaModeToggleWidgetState extends State<FiestaModeToggleWidget> {
  double? _dragProgress;

  double get _restProgress => widget.isFiestaMode ? 1 : 0;

  double get _progress => _dragProgress ?? _restProgress;

  void _onDragUpdate(DragUpdateDetails details, double travel) {
    if (travel <= 0) {
      return;
    }
    final next = (_progress + details.delta.dx / travel).clamp(0.0, 1.0);
    setState(() => _dragProgress = next);
  }

  void _onDragEnd() {
    final shouldBeOn = _progress >= 0.5;
    setState(() => _dragProgress = null);
    if (shouldBeOn != widget.isFiestaMode) {
      widget.onToggle();
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final trackWidth = layout.spacing(132);
    final trackHeight = layout.spacing(42);
    final thumbSize = layout.spacing(36);
    final horizontalPad = layout.spacing(4);
    final travel = (trackWidth - horizontalPad * 2 - thumbSize).clamp(1.0, 200.0);
    final dragging = _dragProgress != null;
    final on = _progress >= 0.5;
    final brandColor = on ? AppColors.homeAccentYellow : AppColors.homeBlack;
    final trackColor = on ? AppColors.homeBlack : const Color(0xFFF2F2F2);
    // When ON, avoid a gold track stroke — it stacked with the thumb ring (double circle).
    final borderColor =
        on ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0);
    final badgeLabel = on
        ? AppStrings.brandBadgeOn(l10n)
        : AppStrings.brandBadgeOff(l10n);
    final modeLabel = AppStrings.brandModeFiesta(l10n);
    final thumbAlignment = Alignment.lerp(
      Alignment.centerLeft,
      Alignment.centerRight,
      _progress,
    )!;
    final labelAlignment = Alignment.lerp(
      Alignment.centerRight,
      Alignment.centerLeft,
      _progress,
    )!;
    final duration = dragging
        ? Duration.zero
        : FiestaModeToggleConstants.toggleDuration;

    return Semantics(
      button: true,
      label: modeLabel,
      toggled: widget.isFiestaMode,
      child: GestureDetector(
        onTap: widget.onToggle,
        onHorizontalDragUpdate: (details) => _onDragUpdate(details, travel),
        onHorizontalDragEnd: (_) => _onDragEnd(),
        onHorizontalDragCancel: _onDragEnd,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: duration,
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
                duration: duration,
                curve: Curves.easeInOut,
                alignment: labelAlignment,
                child: FiestaModeToggleBrandLabelWidget(
                  color: brandColor,
                  fontSize: layout.fontSize(13),
                ),
              ),
              AnimatedAlign(
                duration: duration,
                curve: Curves.easeInOut,
                alignment: thumbAlignment,
                child: FiestaModeToggleThumbWidget(
                  size: thumbSize,
                  isFiestaMode: on,
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
