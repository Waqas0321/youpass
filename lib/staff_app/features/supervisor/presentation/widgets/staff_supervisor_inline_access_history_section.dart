import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_action_history_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_history_route_args.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

/// Compact ticket / access scan history for the idle search-entry screen.
class StaffSupervisorInlineAccessHistorySection extends StatelessWidget {
  const StaffSupervisorInlineAccessHistorySection({super.key});

  static const _accent = AppColors.homeAccentYellow;

  String _resultLabel(dynamic l10n, StaffSupervisorActionHistoryEntry entry) {
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

  (Color, IconData) _badgeStyle(StaffSupervisorActionHistoryEntry entry) {
    return switch (entry.result) {
      StaffSupervisorAccessResult.valid => (
          StaffSupervisorDesign.successGreen,
          Icons.check_circle_rounded,
        ),
      StaffSupervisorAccessResult.reEntry => (
          StaffSupervisorDesign.accent,
          Icons.login_rounded,
        ),
      StaffSupervisorAccessResult.rejected => (
          const Color(0xFFEF4444),
          Icons.block_rounded,
        ),
      StaffSupervisorAccessResult.supervisor => (
          const Color(0xFF2563EB),
          Icons.verified_user_outlined,
        ),
      StaffSupervisorAccessResult.unknown => (
          AppColors.secondaryGrey,
          Icons.qr_code_scanner_rounded,
        ),
    };
  }

  void _openEntryHistory(
    BuildContext context,
    StaffSupervisorActionHistoryEntry entry,
    StaffSupervisorActionHistoryResult history,
  ) {
    final ticketId = entry.ticketId;
    if (ticketId == null || ticketId.isEmpty) {
      return;
    }

    Navigator.of(context).pushNamed(
      StaffAppRoutes.supervisorEntryHistory,
      arguments: StaffSupervisorEntryHistoryRouteArgs(
        ticketId: ticketId,
        guestName: entry.guestName ?? entry.targetLabel ?? history.eventTitle,
        eventTitle: history.eventTitle,
        qrId: entry.entryCode ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Consumer<StaffSupervisorActionHistoryProvider>(
      builder: (context, provider, _) {
        final history = provider.history;
        final entries = history?.actions ?? const [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: layout.spacing(8)),
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
                    StaffAppRoutes.supervisorActionHistory,
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
                l10n.staffSupervisorAccessHistoryEmpty,
                variant: AppTextVariant.body,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(13),
              )
            else
              StaffSupervisorSectionCard(
                child: Column(
                  children: [
                    for (var i = 0; i < entries.length; i++) ...[
                      _InlineAccessHistoryRow(
                        layout: layout,
                        entry: entries[i],
                        resultLabel: _resultLabel(l10n, entries[i]),
                        badgeStyle: _badgeStyle(entries[i]),
                        onTap: history == null
                            ? null
                            : () => _openEntryHistory(
                                  context,
                                  entries[i],
                                  history,
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

class _InlineAccessHistoryRow extends StatelessWidget {
  const _InlineAccessHistoryRow({
    required this.layout,
    required this.entry,
    required this.resultLabel,
    required this.badgeStyle,
    this.onTap,
  });

  final ResponsiveLayout layout;
  final StaffSupervisorActionHistoryEntry entry;
  final String resultLabel;
  final (Color, IconData) badgeStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final (color, icon) = badgeStyle;
    final guest = (entry.guestName ?? entry.targetLabel ?? '').trim();
    final title = guest.isNotEmpty ? guest : resultLabel;
    final subtitleParts = <String>[
      resultLabel,
      if (entry.entryCode != null && entry.entryCode!.trim().isNotEmpty)
        entry.entryCode!,
      if (entry.ticketType != null && entry.ticketType!.trim().isNotEmpty)
        entry.ticketType!,
      if (entry.accessPoint != null && entry.accessPoint!.trim().isNotEmpty)
        entry.accessPoint!,
    ];

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: layout.spacing(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: layout.spacing(32),
              height: layout.spacing(32),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
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
          ],
        ),
      ),
    );
  }
}
