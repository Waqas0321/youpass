import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_search_result.dart';
import 'package:youpass/l10n/app_localizations.dart';

class StaffSupervisorEntryEventsTimeline extends StatelessWidget {
  const StaffSupervisorEntryEventsTimeline({
    super.key,
    required this.layout,
    required this.logs,
    this.showTitle = true,
  });

  static const _accent = AppColors.homeAccentYellow;
  static const _successGreen = Color(0xFF22C55E);

  final ResponsiveLayout layout;
  final List<StaffSupervisorEntryEventLog> logs;
  final bool showTitle;

  String _eventTitle(AppLocalizations l10n, StaffSupervisorEntryEventLog log) {
    switch (log.kind) {
      case StaffSupervisorEntryEventKind.validated:
        return l10n.staffSupervisorSearchEntryRecentValidated;
      case StaffSupervisorEntryEventKind.reentry:
        return l10n.staffSupervisorSearchEntryRecentReentry;
      case StaffSupervisorEntryEventKind.supervisor:
        return l10n.staffSupervisorSearchEntryRecentSupervisor;
      case StaffSupervisorEntryEventKind.unknown:
        return log.title.isNotEmpty
            ? log.title
            : l10n.staffSupervisorSearchEntryRecentValidated;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showTitle) ...[
          AppText(
            l10n.staffSupervisorSearchEntryRecentEventsTitle,
            variant: AppTextVariant.label,
            color: AppColors.secondaryGrey,
            fontWeight: FontWeight.w700,
            fontSize: layout.fontSize(12),
            letterSpacing: 0.8,
          ),
          SizedBox(height: layout.spacing(14)),
        ],
        ...List.generate(logs.length, (index) {
          final log = logs[index];
          final isLast = index == logs.length - 1;
          final isSupervisor = log.kind == StaffSupervisorEntryEventKind.supervisor;
          final iconColor = isSupervisor ? _accent : _successGreen;
          final icon = log.isSuccess
              ? Icons.check_circle_rounded
              : log.isReentry
                  ? Icons.refresh_rounded
                  : Icons.person_outline_rounded;
          final subtitle = isSupervisor ? log.detail : log.timeLabel;
          final trailing = isSupervisor ? log.timeLabel : log.detail;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Icon(icon, color: iconColor, size: layout.spacing(20)),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: EdgeInsets.symmetric(
                            vertical: layout.spacing(4),
                          ),
                          color: AppColors.homeDividerGrey,
                        ),
                      ),
                  ],
                ),
                SizedBox(width: layout.spacing(12)),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: layout.spacing(isLast ? 0 : 16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                _eventTitle(l10n, log),
                                variant: AppTextVariant.bodyEmphasis,
                                color: AppColors.homeBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: layout.fontSize(14),
                              ),
                              AppText(
                                subtitle,
                                variant: AppTextVariant.body,
                                color: AppColors.secondaryGrey,
                                fontSize: layout.fontSize(12),
                              ),
                            ],
                          ),
                        ),
                        AppText(
                          trailing,
                          variant: AppTextVariant.body,
                          color: AppColors.homeBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: layout.fontSize(13),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
