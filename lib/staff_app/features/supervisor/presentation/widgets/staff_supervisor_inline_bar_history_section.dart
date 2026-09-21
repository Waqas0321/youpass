import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_bar_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/providers/staff_supervisor_drink_lookup_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_redemption_detail_sheet.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

/// Compact bar scan / redemption history for supervisor idle screens.
class StaffSupervisorInlineBarHistorySection extends StatelessWidget {
  const StaffSupervisorInlineBarHistorySection({super.key});

  static const _accent = AppColors.homeAccentYellow;

  Color _resultColor(StaffSupervisorBarActionHistoryEntry entry) {
    return switch (entry.result) {
      StaffSupervisorRedemptionResult.redeemed => const Color(0xFF22C55E),
      StaffSupervisorRedemptionResult.restored => _accent,
      StaffSupervisorRedemptionResult.duplicateAttempt => const Color(0xFFEF4444),
      StaffSupervisorRedemptionResult.supervisor => const Color(0xFF2563EB),
      StaffSupervisorRedemptionResult.unknown => AppColors.secondaryGrey,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Consumer<StaffSupervisorBarDashboardProvider>(
      builder: (context, provider, _) {
        final entries = provider.history?.actions ?? const [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: layout.spacing(20)),
            Row(
              children: [
                Expanded(
                  child: AppText(
                    l10n.staffSupervisorRecentActionsTitle,
                    variant: AppTextVariant.sectionTitle,
                    color: AppColors.homeBlack,
                    fontWeight: FontWeight.w800,
                    fontSize: layout.fontSize(13),
                    letterSpacing: 0.6,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorBarActionHistory,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryMustard,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: AppText(
                    l10n.staffSupervisorViewAllActions,
                    variant: AppTextVariant.link,
                    color: AppColors.primaryMustard,
                    fontWeight: FontWeight.w600,
                    fontSize: layout.fontSize(13),
                  ),
                ),
              ],
            ),
            SizedBox(height: layout.spacing(12)),
            if (provider.isLoading)
              Padding(
                padding: EdgeInsets.symmetric(vertical: layout.spacing(24)),
                child: const Center(
                  child: CircularProgressIndicator(color: _accent),
                ),
              )
            else if (provider.loadError != null)
              AppText(
                provider.loadError!,
                variant: AppTextVariant.body,
                color: const Color(0xFFEF4444),
                fontSize: layout.fontSize(13),
                textAlign: TextAlign.center,
              )
            else if (entries.isEmpty)
              AppText(
                l10n.staffSupervisorRedemptionHistoryEmpty,
                variant: AppTextVariant.body,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(13),
              )
            else
              StaffSupervisorSectionCard(
                child: Column(
                  children: [
                    for (var i = 0; i < entries.length; i++) ...[
                      _InlineHistoryRow(
                        layout: layout,
                        entry: entries[i],
                        resultLabel: staffSupervisorRedemptionResultLabel(
                          l10n,
                          entries[i],
                        ),
                        resultColor: _resultColor(entries[i]),
                        onTap: () => showStaffSupervisorRedemptionDetailSheet(
                          context,
                          entries[i],
                        ),
                      ),
                      if (i < entries.length - 1)
                        Divider(
                          height: 1,
                          color: AppColors.homeDividerGrey,
                          indent: layout.spacing(44),
                        ),
                    ],
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class _InlineHistoryRow extends StatelessWidget {
  const _InlineHistoryRow({
    required this.layout,
    required this.entry,
    required this.resultLabel,
    required this.resultColor,
    required this.onTap,
  });

  final ResponsiveLayout layout;
  final StaffSupervisorBarActionHistoryEntry entry;
  final String resultLabel;
  final Color resultColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final rawProduct = entry.productName?.trim();
    final product = (rawProduct != null && rawProduct.isNotEmpty)
        ? rawProduct
        : entry.guestName.trim();
    final qty = entry.productQuantity;
    final title = product.isEmpty
        ? ''
        : (qty != null && qty > 1 ? '$product x$qty' : product);
    final subtitleParts = <String>[
      resultLabel,
      if (entry.guestName.isNotEmpty && entry.guestName != product)
        entry.guestName,
      if (entry.manualCode != null && entry.manualCode!.isNotEmpty)
        entry.manualCode!,
      if (entry.barName != null && entry.barName!.isNotEmpty) entry.barName!,
    ];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: layout.spacing(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: layout.spacing(32),
                height: layout.spacing(32),
                decoration: BoxDecoration(
                  color: resultColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.local_bar_rounded,
                  color: resultColor,
                  size: layout.spacing(18),
                ),
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title.isEmpty ? resultLabel : title,
                      variant: AppTextVariant.listTitle,
                      color: AppColors.homeBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: layout.fontSize(14),
                    ),
                    if (subtitleParts.isNotEmpty) ...[
                      SizedBox(height: layout.spacing(2)),
                      AppText(
                        subtitleParts.join(' · '),
                        variant: AppTextVariant.body,
                        color: AppColors.secondaryGrey,
                        fontSize: layout.fontSize(12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: layout.spacing(8)),
              AppText(
                entry.timeLabel,
                variant: AppTextVariant.listTrailing,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(12),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.homeAccentYellow,
                size: layout.spacing(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
