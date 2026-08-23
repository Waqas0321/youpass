import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';

class StaffSupervisorAccessToolCard extends StatelessWidget {
  const StaffSupervisorAccessToolCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onActionTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onActionTap;

  static const _accent = AppColors.homeAccentYellow;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        layout.spacing(16),
        layout.spacing(16),
        layout.spacing(14),
        layout.spacing(16),
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(16)),
        border: Border.all(color: AppColors.homeDividerGrey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: layout.spacing(40),
            height: layout.spacing(40),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8EB),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFFDE6B0)),
            ),
            child: Icon(icon, color: _accent, size: layout.spacing(20)),
          ),
          SizedBox(width: layout.spacing(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  variant: AppTextVariant.bodyEmphasis,
                  color: AppColors.homeBlack,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(15),
                ),
                SizedBox(height: layout.spacing(6)),
                AppText(
                  description,
                  variant: AppTextVariant.body,
                  color: AppColors.secondaryGrey,
                  fontSize: layout.fontSize(13),
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          SizedBox(width: layout.spacing(8)),
          TextButton(
            onPressed: onActionTap,
            style: TextButton.styleFrom(
              backgroundColor: _accent,
              foregroundColor: AppColors.backgroundWhite,
              padding: EdgeInsets.symmetric(
                horizontal: layout.spacing(18),
                vertical: layout.spacing(8),
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(layout.radius(20)),
              ),
            ),
            child: AppText(
              actionLabel,
              variant: AppTextVariant.button,
              color: AppColors.backgroundWhite,
              fontWeight: FontWeight.w700,
              fontSize: layout.fontSize(13),
            ),
          ),
        ],
      ),
    );
  }
}
