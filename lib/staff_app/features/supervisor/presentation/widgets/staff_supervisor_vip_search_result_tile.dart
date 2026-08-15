import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_vip_table_result.dart';

class StaffSupervisorVipSearchResultTile extends StatelessWidget {
  const StaffSupervisorVipSearchResultTile({
    super.key,
    required this.layout,
    required this.result,
    required this.onTap,
  });

  final ResponsiveLayout layout;
  final StaffSupervisorVipTableResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final subtitleParts = <String>[
      if (result.purchaseResponsible.isNotEmpty) result.purchaseResponsible,
      if (result.eventName.isNotEmpty) result.eventName,
    ];

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: layout.spacing(14),
          vertical: layout.spacing(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.workspace_premium_outlined,
              size: layout.fontSize(18),
              color: const Color(0xFFD4A044),
            ),
            SizedBox(width: layout.spacing(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    result.tableName,
                    variant: AppTextVariant.bodyEmphasis,
                    color: AppColors.homeBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: layout.fontSize(14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitleParts.isNotEmpty) ...[
                    SizedBox(height: layout.spacing(2)),
                    AppText(
                      subtitleParts.join(' · '),
                      variant: AppTextVariant.body,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: layout.spacing(2)),
                  AppText(
                    '${result.enteredCount} entered · ${result.pendingCount} pending',
                    variant: AppTextVariant.body,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(11),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.secondaryGrey,
              size: layout.spacing(22),
            ),
          ],
        ),
      ),
    );
  }
}
