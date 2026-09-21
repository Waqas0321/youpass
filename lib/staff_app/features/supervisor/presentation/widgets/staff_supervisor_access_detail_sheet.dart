import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_history_route_args.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

String staffSupervisorAccessResultLabel(
  dynamic l10n,
  StaffSupervisorActionHistoryEntry entry,
) {
  return switch (entry.result) {
    StaffSupervisorAccessResult.valid => l10n.staffSupervisorAccessResultValid,
    StaffSupervisorAccessResult.reEntry =>
      l10n.staffSupervisorAccessResultReEntry,
    StaffSupervisorAccessResult.rejected =>
      l10n.staffSupervisorAccessResultRejected,
    StaffSupervisorAccessResult.supervisor =>
      l10n.staffSupervisorAccessResultSupervisor,
    StaffSupervisorAccessResult.unknown => entry.kind.replaceAll('_', ' '),
  };
}

Future<void> showStaffSupervisorAccessDetailSheet(
  BuildContext context, {
  required StaffSupervisorActionHistoryEntry entry,
  required StaffSupervisorActionHistoryResult history,
}) {
  final l10n = context.l10n;
  final layout = ResponsiveLayout(context);
  final resultLabel = staffSupervisorAccessResultLabel(l10n, entry);
  final guest = (entry.guestName ?? entry.targetLabel ?? '').trim();

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.backgroundWhite,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(layout.radius(20)),
      ),
    ),
    builder: (sheetContext) {
      final rows = <(String, String)>[
        (l10n.staffSupervisorRedemptionDetailResult, resultLabel),
        if (guest.isNotEmpty)
          (l10n.staffSupervisorRedemptionDetailCustomer, guest),
        if (entry.entryCode != null && entry.entryCode!.trim().isNotEmpty)
          (l10n.staffSupervisorRedemptionDetailCode, entry.entryCode!),
        if (entry.ticketType != null && entry.ticketType!.trim().isNotEmpty)
          (l10n.staffSupervisorRedemptionDetailProduct, entry.ticketType!),
        if (entry.accessPoint != null && entry.accessPoint!.trim().isNotEmpty)
          (l10n.staffSupervisorRedemptionDetailBar, entry.accessPoint!),
        if (entry.supervisorName.isNotEmpty)
          (l10n.staffSupervisorRedemptionDetailStaff, entry.supervisorName),
        (l10n.staffSupervisorRedemptionDetailTime, entry.timeLabel),
        if (history.eventTitle.isNotEmpty)
          (l10n.staffSupervisorAccessHistoryTitle, history.eventTitle),
      ];

      final ticketId = entry.ticketId?.trim() ?? '';

      return Padding(
        padding: EdgeInsets.fromLTRB(
          layout.spacing(20),
          layout.spacing(16),
          layout.spacing(20),
          layout.spacing(28) + MediaQuery.paddingOf(sheetContext).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: layout.spacing(40),
                height: layout.spacing(4),
                decoration: BoxDecoration(
                  color: AppColors.homeDividerGrey,
                  borderRadius: BorderRadius.circular(layout.radius(4)),
                ),
              ),
            ),
            SizedBox(height: layout.spacing(16)),
            AppText(
              l10n.staffSupervisorRedemptionDetailTitle,
              variant: AppTextVariant.headline,
              fontWeight: FontWeight.w800,
              fontSize: layout.fontSize(18),
              color: AppColors.homeBlack,
            ),
            SizedBox(height: layout.spacing(16)),
            for (final row in rows) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: layout.spacing(110),
                    child: AppText(
                      row.$1,
                      variant: AppTextVariant.label,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(12),
                    ),
                  ),
                  Expanded(
                    child: AppText(
                      row.$2,
                      variant: AppTextVariant.body,
                      color: AppColors.homeBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: layout.fontSize(13),
                    ),
                  ),
                ],
              ),
              SizedBox(height: layout.spacing(10)),
            ],
            if (ticketId.isNotEmpty) ...[
              SizedBox(height: layout.spacing(8)),
              FilledButton(
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorEntryHistory,
                    arguments: StaffSupervisorEntryHistoryRouteArgs(
                      ticketId: ticketId,
                      guestName: guest.isNotEmpty ? guest : history.eventTitle,
                      eventTitle: history.eventTitle,
                      qrId: entry.entryCode ?? '',
                    ),
                  );
                },
                child: Text(l10n.staffSupervisorSearchEntryActionHistory),
              ),
            ],
          ],
        ),
      );
    },
  );
}
