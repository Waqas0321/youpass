import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';

class StaffSupervisorActionHistoryList extends StatelessWidget {
  const StaffSupervisorActionHistoryList({
    super.key,
    required this.entries,
    required this.entryTitle,
    required this.supervisorPrefix,
    this.targetLabel,
    this.onEntryTap,
  });

  final List<StaffSupervisorActionHistoryEntry> entries;
  final String Function(StaffSupervisorActionHistoryEntry entry) entryTitle;
  final String supervisorPrefix;
  final String? Function(StaffSupervisorActionHistoryEntry entry)? targetLabel;
  final ValueChanged<StaffSupervisorActionHistoryEntry>? onEntryTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSectionCard(
      child: Column(
        children: [
          for (var index = 0; index < entries.length; index++) ...[
            _ActionHistoryRow(
              layout: layout,
              entry: entries[index],
              title: entryTitle(entries[index]),
              supervisorPrefix: supervisorPrefix,
              targetText: targetLabel?.call(entries[index]),
              onTap: onEntryTap == null ? null : () => onEntryTap!(entries[index]),
            ),
            if (index < entries.length - 1)
              Divider(
                height: 1,
                color: AppColors.homeDividerGrey,
                indent: layout.spacing(44),
              ),
          ],
        ],
      ),
    );
  }
}

class _ActionHistoryRow extends StatelessWidget {
  const _ActionHistoryRow({
    required this.layout,
    required this.entry,
    required this.title,
    required this.supervisorPrefix,
    this.targetText,
    this.onTap,
  });

  final ResponsiveLayout layout;
  final StaffSupervisorActionHistoryEntry entry;
  final String title;
  final String supervisorPrefix;
  final String? targetText;
  final VoidCallback? onTap;

  (Color, IconData) get _badgeStyle {
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
      StaffSupervisorAccessResult.unknown => switch (entry.category) {
          StaffSupervisorActionHistoryCategory.access => (
              StaffSupervisorDesign.successGreen,
              Icons.door_front_door_outlined,
            ),
          StaffSupervisorActionHistoryCategory.entryOverride => (
              StaffSupervisorDesign.accent,
              Icons.qr_code_2_rounded,
            ),
          StaffSupervisorActionHistoryCategory.duplicate => (
              const Color(0xFFEF4444),
              Icons.warning_amber_rounded,
            ),
          StaffSupervisorActionHistoryCategory.manualValidation => (
              const Color(0xFF2563EB),
              Icons.badge_outlined,
            ),
          StaffSupervisorActionHistoryCategory.vip => (
              StaffSupervisorDesign.successGreen,
              Icons.workspace_premium_outlined,
            ),
          StaffSupervisorActionHistoryCategory.system => (
              AppColors.secondaryGrey,
              Icons.monitor_heart_outlined,
            ),
        },
    };
  }

  @override
  Widget build(BuildContext context) {
    final (badgeColor, badgeIcon) = _badgeStyle;

    return Material(
      color: Colors.transparent,
      child: InkWell(
              onTap: onTap != null &&
                      entry.ticketId != null &&
                      entry.ticketId!.isNotEmpty
                  ? onTap
                  : null,
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
                  color: badgeColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(badgeIcon, color: badgeColor, size: layout.spacing(18)),
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
                    AppText(
                      '$supervisorPrefix ${entry.supervisorName}',
                      variant: AppTextVariant.body,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(12),
                    ),
                    if (targetText != null && targetText!.isNotEmpty) ...[
                      SizedBox(height: layout.spacing(2)),
                      AppText(
                        targetText!,
                        variant: AppTextVariant.body,
                        color: AppColors.secondaryGrey,
                        fontSize: layout.fontSize(11),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
              if (onTap != null &&
                  entry.ticketId != null &&
                  entry.ticketId!.isNotEmpty)
                Icon(
                  Icons.chevron_right_rounded,
                  color: StaffSupervisorDesign.accent,
                  size: layout.spacing(20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
