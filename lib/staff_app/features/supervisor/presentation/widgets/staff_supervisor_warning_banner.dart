import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';

class StaffSupervisorWarningBanner extends StatelessWidget {
  const StaffSupervisorWarningBanner({
    super.key,
    required this.title,
    required this.body,
    this.iconColor,
    this.backgroundColor,
    this.borderColor,
  });

  final String title;
  final String body;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final accent = iconColor ?? StaffSupervisorDesign.accent;

    return Container(
      padding: EdgeInsets.all(layout.spacing(14)),
      decoration: BoxDecoration(
        color: backgroundColor ?? StaffSupervisorDesign.warningBackground,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        border: Border.all(color: (borderColor ?? accent).withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: accent, size: layout.spacing(22)),
          SizedBox(width: layout.spacing(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  variant: AppTextVariant.label,
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(12),
                  letterSpacing: 0.8,
                ),
                SizedBox(height: layout.spacing(4)),
                AppText(
                  body,
                  variant: AppTextVariant.body,
                  color: AppColors.homeBlack,
                  fontSize: layout.fontSize(13),
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
