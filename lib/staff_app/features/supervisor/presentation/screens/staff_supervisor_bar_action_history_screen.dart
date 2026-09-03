import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_bar_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/providers/staff_supervisor_drink_lookup_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_page_header.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

class StaffSupervisorBarActionHistoryRoute extends StatelessWidget {
  const StaffSupervisorBarActionHistoryRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorBarActionHistoryProvider(
        genericLoadError: l10n.staffSupervisorSearchDrinkSearchError,
      )..loadHistory(),
      child: const StaffSupervisorBarActionHistoryScreen(),
    );
  }
}

class StaffSupervisorBarActionHistoryScreen extends StatelessWidget {
  const StaffSupervisorBarActionHistoryScreen({super.key});

  String _resultLabel(dynamic l10n, StaffSupervisorBarActionHistoryEntry entry) {
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

  Color _resultColor(StaffSupervisorBarActionHistoryEntry entry) {
    return switch (entry.result) {
      StaffSupervisorRedemptionResult.redeemed => const Color(0xFF22C55E),
      StaffSupervisorRedemptionResult.restored => AppColors.homeAccentYellow,
      StaffSupervisorRedemptionResult.duplicateAttempt => const Color(0xFFEF4444),
      StaffSupervisorRedemptionResult.supervisor => const Color(0xFF2563EB),
      StaffSupervisorRedemptionResult.unknown => AppColors.secondaryGrey,
    };
  }

  void _openDetail(BuildContext context, StaffSupervisorBarActionHistoryEntry entry) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.backgroundWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(layout.radius(20)),
        ),
      ),
      builder: (sheetContext) {
        final rows = <(String, String)>[
          (l10n.staffSupervisorRedemptionDetailResult, _resultLabel(l10n, entry)),
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
            layout.spacing(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Consumer<StaffSupervisorBarActionHistoryProvider>(
      builder: (context, provider, _) {
        final entries = provider.history?.actions ?? const [];

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: Column(
            children: [
              StaffSupervisorPageHeader(
                title: l10n.staffSupervisorRedemptionHistoryTitle,
                subtitle: provider.history?.eventTitle ?? '',
              ),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.loadError != null
                        ? Center(
                            child: AppText(
                              provider.loadError!,
                              variant: AppTextVariant.body,
                              color: const Color(0xFFEF4444),
                              fontSize: layout.fontSize(13),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : entries.isEmpty
                            ? Center(
                                child: AppText(
                                  l10n.staffSupervisorRedemptionHistoryEmpty,
                                  variant: AppTextVariant.body,
                                  color: AppColors.secondaryGrey,
                                  fontSize: layout.fontSize(13),
                                ),
                              )
                            : ListView(
                                padding: EdgeInsets.all(layout.spacing(20)),
                                children: [
                                  StaffSupervisorSectionCard(
                                    child: Column(
                                      children: [
                                        for (var i = 0; i < entries.length; i++) ...[
                                          _RedemptionHistoryRow(
                                            layout: layout,
                                            entry: entries[i],
                                            resultLabel: _resultLabel(l10n, entries[i]),
                                            resultColor: _resultColor(entries[i]),
                                            onTap: () => _openDetail(context, entries[i]),
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
                              ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RedemptionHistoryRow extends StatelessWidget {
  const _RedemptionHistoryRow({
    required this.layout,
    required this.entry,
    required this.resultLabel,
    required this.resultColor,
    this.onTap,
  });

  final ResponsiveLayout layout;
  final StaffSupervisorBarActionHistoryEntry entry;
  final String resultLabel;
  final Color resultColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final product = entry.productName ?? entry.guestName;
    final qty = entry.productQuantity;
    final title = qty != null && qty > 1 ? '$product x$qty' : product;
    final subtitleParts = <String>[
      resultLabel,
      if (entry.guestName.isNotEmpty && entry.guestName != product) entry.guestName,
      if (entry.manualCode != null && entry.manualCode!.isNotEmpty) entry.manualCode!,
      if (entry.barName != null && entry.barName!.isNotEmpty) entry.barName!,
      if (entry.supervisorName.isNotEmpty) entry.supervisorName,
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
                      title,
                      variant: AppTextVariant.bodyEmphasis,
                      color: AppColors.homeBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: layout.fontSize(14),
                    ),
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
                ),
              ),
              AppText(
                entry.timeLabel,
                variant: AppTextVariant.body,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(13),
                fontWeight: FontWeight.w600,
              ),
              if (onTap != null)
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
