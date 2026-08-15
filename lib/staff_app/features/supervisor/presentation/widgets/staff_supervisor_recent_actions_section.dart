import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action.dart';

class StaffSupervisorRecentActionsSection extends StatelessWidget {
  const StaffSupervisorRecentActionsSection({
    super.key,
    required this.actions,
    this.onViewAllTap,
  });

  final List<StaffSupervisorAction> actions;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
              onPressed: onViewAllTap,
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
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(layout.radius(16)),
            border: Border.all(color: AppColors.homeDividerGrey),
          ),
          child: Column(
            children: [
              for (var index = 0; index < actions.length; index++) ...[
                _StaffSupervisorActionTile(action: actions[index]),
                if (index < actions.length - 1)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.homeDividerGrey,
                    indent: layout.spacing(56),
                    endIndent: layout.spacing(16),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _StaffSupervisorActionTile extends StatelessWidget {
  const _StaffSupervisorActionTile({required this.action});

  final StaffSupervisorAction action;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: layout.spacing(14),
        vertical: layout.spacing(13),
      ),
      child: Row(
        children: [
          _ActionBadge(type: action.type, layout: layout),
          SizedBox(width: layout.spacing(12)),
          Expanded(
            child: AppText(
              action.title,
              variant: AppTextVariant.listTitle,
              color: AppColors.homeBlack,
              fontWeight: FontWeight.w600,
              fontSize: layout.fontSize(14),
            ),
          ),
          AppText(
            action.timeLabel,
            variant: AppTextVariant.listTrailing,
            color: AppColors.secondaryGrey,
            fontSize: layout.fontSize(13),
          ),
          SizedBox(width: layout.spacing(4)),
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.secondaryGrey,
            size: layout.spacing(20),
          ),
        ],
      ),
    );
  }
}

class _ActionBadge extends StatelessWidget {
  const _ActionBadge({required this.type, required this.layout});

  final StaffSupervisorActionType type;
  final ResponsiveLayout layout;

  @override
  Widget build(BuildContext context) {
    final (color, icon) = switch (type) {
      StaffSupervisorActionType.qrReleased => (
          const Color(0xFF22C55E),
          Icons.lock_open_rounded,
        ),
      StaffSupervisorActionType.manualValidation => (
          const Color(0xFF22C55E),
          Icons.check_rounded,
        ),
      StaffSupervisorActionType.consumptionCancelled => (
          const Color(0xFFEF4444),
          Icons.close_rounded,
        ),
    };

    return Container(
      width: layout.spacing(32),
      height: layout.spacing(32),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: AppColors.backgroundWhite,
        size: layout.spacing(18),
      ),
    );
  }
}
