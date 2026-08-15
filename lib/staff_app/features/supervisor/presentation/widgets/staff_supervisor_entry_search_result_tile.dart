import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_search_result.dart';

/// Rich search result row: guest name, event · code, status dot, chevron.
class StaffSupervisorEntrySearchResultTile extends StatelessWidget {
  const StaffSupervisorEntrySearchResultTile({
    super.key,
    required this.layout,
    required this.result,
    required this.onTap,
  });

  final ResponsiveLayout layout;
  final StaffSupervisorEntrySearchResult result;
  final VoidCallback onTap;

  Color _statusColor() {
    switch (result.status) {
      case StaffSupervisorEntryStatus.validated:
        return const Color(0xFF22C55E);
      case StaffSupervisorEntryStatus.pending:
        return const Color(0xFFF59E0B);
      case StaffSupervisorEntryStatus.used:
        return const Color(0xFF64748B);
      case StaffSupervisorEntryStatus.error:
      case StaffSupervisorEntryStatus.blocked:
        return const Color(0xFFEF4444);
    }
  }

  @override
  Widget build(BuildContext context) {
    final subtitleParts = <String>[
      if (result.eventTitle.isNotEmpty) result.eventTitle,
      if (result.qrId.isNotEmpty) result.qrId,
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
              Icons.confirmation_number_outlined,
              size: layout.fontSize(18),
              color: AppColors.secondaryGrey,
            ),
            SizedBox(width: layout.spacing(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    result.guestName,
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
                ],
              ),
            ),
            SizedBox(width: layout.spacing(8)),
            Container(
              width: layout.spacing(8),
              height: layout.spacing(8),
              decoration: BoxDecoration(
                color: _statusColor(),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: layout.spacing(6)),
            Icon(
              Icons.chevron_right_rounded,
              size: layout.fontSize(18),
              color: AppColors.secondaryGrey,
            ),
          ],
        ),
      ),
    );
  }
}
