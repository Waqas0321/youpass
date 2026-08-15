import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_pin_input_widget.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_form_utils.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';

enum StaffSupervisorPinReasonLayout {
  vertical,
  horizontal,
}

/// Shared PIN + mandatory reason block used across supervisor access screens.
class StaffSupervisorPinReasonForm extends StatelessWidget {
  const StaffSupervisorPinReasonForm({
    super.key,
    required this.pinController,
    required this.reasonController,
    required this.pinLabel,
    required this.reasonLabel,
    required this.reasonHint,
    this.onChanged,
    this.reasonMaxLines = 3,
    this.wrapInCard = true,
    this.reasonHelperText,
    this.layout = StaffSupervisorPinReasonLayout.vertical,
  });

  final TextEditingController pinController;
  final TextEditingController reasonController;
  final String pinLabel;
  final String reasonLabel;
  final String reasonHint;
  final VoidCallback? onChanged;
  final int reasonMaxLines;
  final bool wrapInCard;
  final String? reasonHelperText;
  final StaffSupervisorPinReasonLayout layout;

  @override
  Widget build(BuildContext context) {
    final layoutMetrics = ResponsiveLayout(context);

    if (layout == StaffSupervisorPinReasonLayout.horizontal) {
      return _buildHorizontalContent(layoutMetrics);
    }

    final content = _buildVerticalContent(layoutMetrics);

    if (!wrapInCard) {
      return content;
    }

    return StaffSupervisorSectionCard(child: content);
  }

  Widget _buildVerticalContent(ResponsiveLayout layoutMetrics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          pinLabel,
          variant: AppTextVariant.label,
          color: AppColors.secondaryGrey,
          fontSize: layoutMetrics.fontSize(13),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: layoutMetrics.spacing(10)),
        StaffPinInputWidget(
          controller: pinController,
          style: StaffPinInputStyle.boxes,
          obscureBoxDigits: true,
          autofocus: false,
          expandFullWidth: true,
          onChanged: (_) => onChanged?.call(),
        ),
        SizedBox(height: layoutMetrics.spacing(18)),
        AppText(
          reasonLabel,
          variant: AppTextVariant.label,
          color: AppColors.secondaryGrey,
          fontSize: layoutMetrics.fontSize(13),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: layoutMetrics.spacing(10)),
        TextField(
          controller: reasonController,
          minLines: reasonMaxLines,
          maxLines: reasonMaxLines,
          onChanged: (_) => onChanged?.call(),
          style: TextStyle(
            fontSize: layoutMetrics.fontSize(14),
            color: AppColors.homeBlack,
          ),
          decoration: staffSupervisorInputDecoration(
            layoutMetrics,
            hint: reasonHint,
          ),
        ),
        if (reasonHelperText != null) ...[
          SizedBox(height: layoutMetrics.spacing(8)),
          AppText(
            reasonHelperText!,
            variant: AppTextVariant.body,
            color: AppColors.secondaryGrey,
            fontSize: layoutMetrics.fontSize(12),
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ],
    );
  }

  Widget _buildHorizontalContent(ResponsiveLayout layoutMetrics) {
    final pinBoxSize = layoutMetrics.spacing(36);
    final pinGap = layoutMetrics.spacing(4);
    final pinFieldWidth = pinBoxSize * 4 + pinGap * 3;
    final pinCardWidth =
        pinFieldWidth + layoutMetrics.spacing(_SplitInputCard.compactPadding * 2);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: pinCardWidth,
          child: _SplitInputCard(
            layout: layoutMetrics,
            compact: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _FieldLabel(
                  layout: layoutMetrics,
                  icon: Icons.lock_outline_rounded,
                  label: pinLabel,
                  compact: true,
                ),
                SizedBox(height: layoutMetrics.spacing(8)),
                StaffPinInputWidget(
                  controller: pinController,
                  style: StaffPinInputStyle.boxes,
                  density: StaffPinInputDensity.compact,
                  obscureBoxDigits: true,
                  autofocus: false,
                  mainAxisAlignment: MainAxisAlignment.start,
                  onChanged: (_) => onChanged?.call(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: layoutMetrics.spacing(10)),
        Expanded(
          child: _SplitInputCard(
            layout: layoutMetrics,
            compact: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _FieldLabel(
                  layout: layoutMetrics,
                  icon: Icons.description_outlined,
                  label: reasonLabel,
                  compact: true,
                ),
                SizedBox(height: layoutMetrics.spacing(8)),
                TextField(
                  controller: reasonController,
                  maxLines: 1,
                  onChanged: (_) => onChanged?.call(),
                  style: TextStyle(
                    fontSize: layoutMetrics.fontSize(13),
                    color: AppColors.homeBlack,
                  ),
                  decoration: staffSupervisorInputDecoration(
                    layoutMetrics,
                    hint: reasonHint,
                    compact: true,
                  ),
                ),
                if (reasonHelperText != null) ...[
                  SizedBox(height: layoutMetrics.spacing(6)),
                  AppText(
                    reasonHelperText!,
                    variant: AppTextVariant.body,
                    color: AppColors.secondaryGrey,
                    fontSize: layoutMetrics.fontSize(11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SplitInputCard extends StatelessWidget {
  const _SplitInputCard({
    required this.layout,
    required this.child,
    this.compact = false,
  });

  static const compactPadding = 11.0;

  final ResponsiveLayout layout;
  final Widget child;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final padding = compact ? compactPadding : 14.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(layout.spacing(padding)),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(14)),
        border: Border.all(color: AppColors.homeDividerGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: layout.spacing(8),
            offset: Offset(0, layout.spacing(2)),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({
    required this.layout,
    required this.icon,
    required this.label,
    this.compact = false,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final iconSize = layout.spacing(compact ? 16 : 18);
    final fontSize = layout.fontSize(compact ? 11 : 12);

    return Row(
      children: [
        Icon(
          icon,
          color: StaffSupervisorDesign.accent,
          size: iconSize,
        ),
        SizedBox(width: layout.spacing(compact ? 4 : 6)),
        Expanded(
          child: AppText(
            label,
            variant: AppTextVariant.label,
            color: AppColors.secondaryGrey,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            maxLines: compact ? 1 : 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
