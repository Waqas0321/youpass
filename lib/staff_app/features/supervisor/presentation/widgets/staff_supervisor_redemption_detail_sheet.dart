import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_bar_action_history_result.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

String staffSupervisorRedemptionResultLabel(
  dynamic l10n,
  StaffSupervisorBarActionHistoryEntry entry,
) {
  return switch (entry.result) {
    StaffSupervisorRedemptionResult.redeemed =>
      l10n.staffSupervisorRedemptionResultRedeemed,
    StaffSupervisorRedemptionResult.restored =>
      l10n.staffSupervisorRedemptionResultRestored,
    StaffSupervisorRedemptionResult.duplicateAttempt =>
      l10n.staffSupervisorRedemptionResultDuplicate,
    StaffSupervisorRedemptionResult.supervisor =>
      l10n.staffSupervisorRedemptionResultSupervisor,
    StaffSupervisorRedemptionResult.unknown => entry.kind.replaceAll('_', ' '),
  };
}

Future<void> showStaffSupervisorRedemptionDetailSheet(
  BuildContext context,
  StaffSupervisorBarActionHistoryEntry entry,
) {
  final l10n = context.l10n;
  final layout = ResponsiveLayout(context);
  final resultLabel = staffSupervisorRedemptionResultLabel(l10n, entry);

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
        if (entry.productName != null && entry.productName!.isNotEmpty)
          (
            l10n.staffSupervisorRedemptionDetailProduct,
            entry.productQuantity != null && entry.productQuantity! > 1
                ? '${entry.productName} x${entry.productQuantity}'
                : entry.productName!,
          ),
        if (entry.guestName.isNotEmpty)
          (l10n.staffSupervisorRedemptionDetailCustomer, entry.guestName),
        if (entry.orderId != null && entry.orderId!.isNotEmpty)
          (l10n.staffSupervisorRedemptionDetailOrder, entry.orderId!),
        if (entry.manualCode != null && entry.manualCode!.isNotEmpty)
          (l10n.staffSupervisorRedemptionDetailCode, entry.manualCode!),
        if (entry.barName != null && entry.barName!.isNotEmpty)
          (l10n.staffSupervisorRedemptionDetailBar, entry.barName!),
        if (entry.supervisorName.isNotEmpty)
          (l10n.staffSupervisorRedemptionDetailStaff, entry.supervisorName),
        (l10n.staffSupervisorRedemptionDetailTime, entry.timeLabel),
        if (entry.currentStatus != null && entry.currentStatus!.isNotEmpty)
          (l10n.staffSupervisorRedemptionDetailStatus, entry.currentStatus!),
      ];

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
            if (entry.redemptionId != null && entry.redemptionId!.isNotEmpty) ...[
              SizedBox(height: layout.spacing(8)),
              FilledButton(
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorCancellations,
                  );
                },
                child: Text(l10n.staffSupervisorSearchManagePurchaseTitle),
              ),
            ],
          ],
        ),
      );
    },
  );
}
