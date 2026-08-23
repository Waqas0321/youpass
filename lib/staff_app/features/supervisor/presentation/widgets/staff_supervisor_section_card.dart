import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';

class StaffSupervisorSectionCard extends StatelessWidget {
  const StaffSupervisorSectionCard({
    super.key,
    this.title,
    this.titleWidget,
    required this.child,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget child;

  static const _accent = AppColors.homeAccentYellow;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(layout.spacing(16)),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (titleWidget != null)
            titleWidget!
          else if (title != null)
            AppText(
              title!,
              variant: AppTextVariant.label,
              color: _accent,
              fontWeight: FontWeight.w800,
              fontSize: layout.fontSize(12),
              letterSpacing: 0.9,
            ),
          if (title != null || titleWidget != null)
            SizedBox(height: layout.spacing(14)),
          child,
        ],
      ),
    );
  }
}

class StaffSupervisorDetailRow extends StatelessWidget {
  const StaffSupervisorDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.trailing,
    this.showColon = true,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final Widget? trailing;
  final bool showColon;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final labelText = showColon ? '$label:' : label;

    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: layout.spacing(118),
            child: AppText(
              labelText,
              variant: AppTextVariant.body,
              color: AppColors.secondaryGrey,
              fontSize: layout.fontSize(13),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: AppText(
                    value,
                    variant: AppTextVariant.bodyEmphasis,
                    color: valueColor ?? AppColors.homeBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: layout.fontSize(14),
                  ),
                ),
                if (trailing != null) ...[
                  SizedBox(width: layout.spacing(6)),
                  trailing!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StaffSupervisorHistoryBullet extends StatelessWidget {
  const StaffSupervisorHistoryBullet({
    super.key,
    required this.text,
    this.muted = false,
  });

  final String text;
  final bool muted;

  static const _accent = AppColors.homeAccentYellow;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(6)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: layout.spacing(6)),
            child: Container(
              width: layout.spacing(6),
              height: layout.spacing(6),
              decoration: const BoxDecoration(
                color: _accent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: layout.spacing(10)),
          Expanded(
            child: AppText(
              text,
              variant: AppTextVariant.body,
              color: muted ? AppColors.secondaryGrey : AppColors.homeBlack,
              fontSize: layout.fontSize(14),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
