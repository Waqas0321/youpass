import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_system_status_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';

class StaffSupervisorHealthStatusStyle {
  const StaffSupervisorHealthStatusStyle({
    required this.color,
    required this.label,
    this.showDisabledX = false,
  });

  final Color color;
  final String label;
  final bool showDisabledX;
}

StaffSupervisorHealthStatusStyle staffSupervisorHealthStatusStyle(
  StaffSupervisorSystemHealthStatus status,
  String Function(StaffSupervisorSystemHealthStatus status) statusLabel,
) {
  return switch (status) {
    StaffSupervisorSystemHealthStatus.online => StaffSupervisorHealthStatusStyle(
        color: StaffSupervisorDesign.successGreen,
        label: statusLabel(status),
      ),
    StaffSupervisorSystemHealthStatus.slow => StaffSupervisorHealthStatusStyle(
        color: StaffSupervisorDesign.accent,
        label: statusLabel(status),
      ),
    StaffSupervisorSystemHealthStatus.operational =>
      StaffSupervisorHealthStatusStyle(
        color: StaffSupervisorDesign.successGreen,
        label: statusLabel(status),
      ),
    StaffSupervisorSystemHealthStatus.disabled => StaffSupervisorHealthStatusStyle(
        color: StaffSupervisorDesign.dangerRed,
        label: statusLabel(status),
        showDisabledX: true,
      ),
    StaffSupervisorSystemHealthStatus.disconnected =>
      StaffSupervisorHealthStatusStyle(
        color: StaffSupervisorDesign.dangerRed,
        label: statusLabel(status),
      ),
  };
}

class StaffSupervisorStatusDot extends StatelessWidget {
  const StaffSupervisorStatusDot({
    super.key,
    required this.color,
    this.size,
  });

  final Color color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final dotSize = size ?? layout.spacing(7);

    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class StaffSupervisorSystemMetricCard extends StatelessWidget {
  const StaffSupervisorSystemMetricCard({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(layout.spacing(12)),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        border: Border.all(color: AppColors.homeDividerGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: layout.spacing(6),
            offset: Offset(0, layout.spacing(2)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            title,
            variant: AppTextVariant.label,
            color: AppColors.homeBlack,
            fontWeight: FontWeight.w800,
            fontSize: layout.fontSize(11),
            letterSpacing: 0.6,
          ),
          SizedBox(height: layout.spacing(12)),
          child,
        ],
      ),
    );
  }
}

class _HealthIconBadge extends StatelessWidget {
  const _HealthIconBadge({
    required this.layout,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: layout.spacing(28),
      height: layout.spacing(28),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: layout.spacing(16)),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator({
    required this.layout,
    required this.statusStyle,
  });

  final ResponsiveLayout layout;
  final StaffSupervisorHealthStatusStyle statusStyle;

  @override
  Widget build(BuildContext context) {
    if (statusStyle.showDisabledX) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            statusStyle.label,
            variant: AppTextVariant.bodyEmphasis,
            color: statusStyle.color,
            fontWeight: FontWeight.w800,
            fontSize: layout.fontSize(10),
            letterSpacing: 0.2,
          ),
          SizedBox(width: layout.spacing(3)),
          Icon(
            Icons.close_rounded,
            color: statusStyle.color,
            size: layout.spacing(14),
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StaffSupervisorStatusDot(color: statusStyle.color),
        SizedBox(width: layout.spacing(5)),
        AppText(
          statusStyle.label,
          variant: AppTextVariant.bodyEmphasis,
          color: statusStyle.color,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(10),
          letterSpacing: 0.2,
        ),
      ],
    );
  }
}

(IconData icon, Color bg, Color fg) _generalHealthIconStyle(
  StaffSupervisorGeneralHealthKind kind,
) {
  return switch (kind) {
    StaffSupervisorGeneralHealthKind.system => (
        Icons.dns_rounded,
        StaffSupervisorDesign.successGreen.withValues(alpha: 0.14),
        StaffSupervisorDesign.successGreen,
      ),
    StaffSupervisorGeneralHealthKind.sync => (
        Icons.sync_rounded,
        StaffSupervisorDesign.accent.withValues(alpha: 0.18),
        StaffSupervisorDesign.accent,
      ),
    StaffSupervisorGeneralHealthKind.database => (
        Icons.storage_rounded,
        StaffSupervisorDesign.successGreen.withValues(alpha: 0.14),
        StaffSupervisorDesign.successGreen,
      ),
    StaffSupervisorGeneralHealthKind.offlineMode => (
        Icons.wifi_off_rounded,
        AppColors.secondaryGrey.withValues(alpha: 0.14),
        AppColors.secondaryGrey,
      ),
  };
}

class StaffSupervisorSystemPanel extends StatelessWidget {
  const StaffSupervisorSystemPanel({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          title,
          variant: AppTextVariant.label,
          color: AppColors.homeBlack,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(11),
          letterSpacing: 0.6,
        ),
        SizedBox(height: layout.spacing(10)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(layout.spacing(12)),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(layout.radius(12)),
            border: Border.all(color: AppColors.homeDividerGrey),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: layout.spacing(6),
                offset: Offset(0, layout.spacing(2)),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}

class StaffSupervisorHealthStatusRow extends StatelessWidget {
  const StaffSupervisorHealthStatusRow({
    super.key,
    required this.layout,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.label,
    required this.statusStyle,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String label;
  final StaffSupervisorHealthStatusStyle statusStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _HealthIconBadge(
            layout: layout,
            icon: icon,
            backgroundColor: iconBackgroundColor,
            iconColor: iconColor,
          ),
          SizedBox(width: layout.spacing(8)),
          Expanded(
            child: AppText(
              label,
              variant: AppTextVariant.body,
              color: AppColors.secondaryGrey,
              fontSize: layout.fontSize(11),
              fontWeight: FontWeight.w500,
            ),
          ),
          _StatusIndicator(layout: layout, statusStyle: statusStyle),
        ],
      ),
    );
  }
}

class StaffSupervisorGeneralStatusCard extends StatelessWidget {
  const StaffSupervisorGeneralStatusCard({
    super.key,
    required this.title,
    required this.items,
    required this.itemLabel,
    required this.statusLabel,
  });

  final String title;
  final List<StaffSupervisorGeneralHealthItem> items;
  final String Function(StaffSupervisorGeneralHealthKind kind) itemLabel;
  final String Function(StaffSupervisorSystemHealthStatus status) statusLabel;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSystemMetricCard(
      title: title,
      child: Column(
        children: items.map((item) {
          final style = staffSupervisorHealthStatusStyle(item.status, statusLabel);
          final (icon, bg, fg) = _generalHealthIconStyle(item.kind);
          return StaffSupervisorHealthStatusRow(
            layout: layout,
            icon: icon,
            iconBackgroundColor: bg,
            iconColor: fg,
            label: itemLabel(item.kind),
            statusStyle: style,
          );
        }).toList(),
      ),
    );
  }
}

class StaffSupervisorActiveScannersCard extends StatelessWidget {
  const StaffSupervisorActiveScannersCard({
    super.key,
    required this.title,
    required this.scanners,
    required this.restartLabel,
    required this.statusLabel,
    this.onRestartTap,
  });

  final String title;
  final List<StaffSupervisorScannerItem> scanners;
  final String restartLabel;
  final String Function(StaffSupervisorSystemHealthStatus status) statusLabel;
  final VoidCallback? onRestartTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSystemMetricCard(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...scanners.map((scanner) {
            final style =
                staffSupervisorHealthStatusStyle(scanner.status, statusLabel);
            return Padding(
              padding: EdgeInsets.only(bottom: layout.spacing(12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppText(
                      scanner.id,
                      variant: AppTextVariant.body,
                      color: AppColors.homeBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: layout.fontSize(11),
                    ),
                  ),
                  _StatusIndicator(layout: layout, statusStyle: style),
                ],
              ),
            );
          }),
          SizedBox(height: layout.spacing(4)),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onRestartTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: StaffSupervisorDesign.accent,
                side: BorderSide(
                  color: StaffSupervisorDesign.accent.withValues(alpha: 0.7),
                ),
                padding: EdgeInsets.symmetric(vertical: layout.spacing(9)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(layout.radius(8)),
                ),
              ),
              icon: Icon(Icons.refresh_rounded, size: layout.spacing(16)),
              label: AppText(
                restartLabel,
                variant: AppTextVariant.button,
                color: StaffSupervisorDesign.accent,
                fontWeight: FontWeight.w800,
                fontSize: layout.fontSize(9),
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StaffSupervisorActiveAlertsSection extends StatelessWidget {
  const StaffSupervisorActiveAlertsSection({
    super.key,
    required this.title,
    required this.alerts,
    required this.alertLabel,
  });

  final String title;
  final List<StaffSupervisorSystemAlertKind> alerts;
  final String Function(StaffSupervisorSystemAlertKind kind) alertLabel;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSectionCard(
      title: title,
      child: Column(
        children: alerts.map((alert) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: layout.spacing(8)),
            padding: EdgeInsets.symmetric(
              horizontal: layout.spacing(12),
              vertical: layout.spacing(10),
            ),
            decoration: BoxDecoration(
              color: StaffSupervisorDesign.warningBackground,
              borderRadius: BorderRadius.circular(layout.radius(10)),
              border: Border.all(
                color: StaffSupervisorDesign.accent.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: StaffSupervisorDesign.accent,
                  size: layout.spacing(20),
                ),
                SizedBox(width: layout.spacing(10)),
                Expanded(
                  child: AppText(
                    alertLabel(alert),
                    variant: AppTextVariant.body,
                    color: AppColors.homeBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: layout.fontSize(12),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class StaffSupervisorEventFlowCard extends StatelessWidget {
  const StaffSupervisorEventFlowCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.items,
    required this.itemLabel,
  });

  final String title;
  final String subtitle;
  final List<StaffSupervisorEventFlowItem> items;
  final String Function(StaffSupervisorEventFlowKind kind) itemLabel;

  IconData _iconFor(StaffSupervisorEventFlowKind kind) {
    return switch (kind) {
      StaffSupervisorEventFlowKind.general => Icons.groups_outlined,
      StaffSupervisorEventFlowKind.vip => Icons.star_outline_rounded,
      StaffSupervisorEventFlowKind.backstage => Icons.badge_outlined,
      StaffSupervisorEventFlowKind.rejected => Icons.close_rounded,
      StaffSupervisorEventFlowKind.duplicates => Icons.qr_code_2_rounded,
    };
  }

  Color _iconColor(StaffSupervisorEventFlowKind kind) {
    return switch (kind) {
      StaffSupervisorEventFlowKind.rejected => StaffSupervisorDesign.dangerRed,
      _ => StaffSupervisorDesign.accent,
    };
  }

  Color _valueColor(StaffSupervisorEventFlowKind kind) {
    return switch (kind) {
      StaffSupervisorEventFlowKind.general ||
      StaffSupervisorEventFlowKind.vip =>
        StaffSupervisorDesign.accent,
      _ => AppColors.homeBlack,
    };
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSystemMetricCard(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            subtitle,
            variant: AppTextVariant.body,
            color: AppColors.secondaryGrey,
            fontSize: layout.fontSize(10),
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: layout.spacing(10)),
          ...items.map((item) {
            final iconColor = _iconColor(item.kind);
            final valueColor = _valueColor(item.kind);
            return Padding(
              padding: EdgeInsets.only(bottom: layout.spacing(10)),
              child: Row(
                children: [
                  SizedBox(
                    width: layout.spacing(20),
                    child: Icon(
                      _iconFor(item.kind),
                      color: iconColor,
                      size: layout.spacing(18),
                    ),
                  ),
                  SizedBox(width: layout.spacing(6)),
                  Expanded(
                    child: AppText(
                      itemLabel(item.kind),
                      variant: AppTextVariant.body,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(11),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AppText(
                    '${item.count}',
                    variant: AppTextVariant.bodyEmphasis,
                    color: valueColor,
                    fontWeight: FontWeight.w800,
                    fontSize: layout.fontSize(13),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class StaffSupervisorQuickActionButton extends StatelessWidget {
  const StaffSupervisorQuickActionButton({
    super.key,
    required this.layout,
    required this.icon,
    required this.label,
    required this.foregroundColor,
    required this.onTap,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final Color foregroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconSize = layout.spacing(18);
    final sideInset = layout.spacing(10);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(8)),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: layout.spacing(8)),
          padding: EdgeInsets.symmetric(
            horizontal: sideInset,
            vertical: layout.spacing(11),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(layout.radius(8)),
            border: Border.all(color: foregroundColor.withValues(alpha: 0.65)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(icon, color: foregroundColor, size: iconSize),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: iconSize + sideInset),
                child: AppText(
                  label,
                  variant: AppTextVariant.label,
                  color: foregroundColor,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(8),
                  letterSpacing: 0.2,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StaffSupervisorQuickActionsCard extends StatelessWidget {
  const StaffSupervisorQuickActionsCard({
    super.key,
    required this.title,
    required this.actions,
    required this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final List<StaffSupervisorQuickActionKind> actions;
  final String Function(StaffSupervisorQuickActionKind kind) actionLabel;
  final ValueChanged<StaffSupervisorQuickActionKind>? onActionTap;

  (IconData, Color) _styleFor(StaffSupervisorQuickActionKind kind) {
    return switch (kind) {
      StaffSupervisorQuickActionKind.offlineMode => (
          Icons.wifi_off_rounded,
          StaffSupervisorDesign.accent,
        ),
      StaffSupervisorQuickActionKind.pauseValidations => (
          Icons.pause_rounded,
          StaffSupervisorDesign.accent,
        ),
      StaffSupervisorQuickActionKind.manualAccess => (
          Icons.person_add_alt_1_rounded,
          StaffSupervisorDesign.accent,
        ),
      StaffSupervisorQuickActionKind.blockVip => (
          Icons.lock_outline_rounded,
          StaffSupervisorDesign.dangerRed,
        ),
      StaffSupervisorQuickActionKind.staffAlert => (
          Icons.campaign_outlined,
          const Color(0xFF2563EB),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSystemMetricCard(
      title: title,
      child: Column(
        children: actions.map((action) {
          final (icon, color) = _styleFor(action);
          return StaffSupervisorQuickActionButton(
            layout: layout,
            icon: icon,
            label: actionLabel(action),
            foregroundColor: color,
            onTap: () => onActionTap?.call(action),
          );
        }).toList(),
      ),
    );
  }
}

class StaffSupervisorOperationalSemaphoreCard extends StatelessWidget {
  const StaffSupervisorOperationalSemaphoreCard({
    super.key,
    required this.title,
    required this.riskLabel,
    required this.reasonLabel,
    required this.reasonText,
  });

  final String title;
  final String riskLabel;
  final String reasonLabel;
  final String reasonText;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSystemPanel(
      title: title,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: layout.spacing(44),
            height: layout.spacing(44),
            decoration: BoxDecoration(
              color: StaffSupervisorDesign.warningBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: StaffSupervisorDesign.accent,
              size: layout.spacing(26),
            ),
          ),
          SizedBox(width: layout.spacing(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  riskLabel,
                  variant: AppTextVariant.bodyEmphasis,
                  color: StaffSupervisorDesign.accent,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(13),
                  letterSpacing: 0.3,
                ),
                SizedBox(height: layout.spacing(6)),
                AppText(
                  reasonLabel,
                  variant: AppTextVariant.body,
                  color: AppColors.secondaryGrey,
                  fontSize: layout.fontSize(11),
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  reasonText,
                  variant: AppTextVariant.bodyEmphasis,
                  color: AppColors.homeBlack,
                  fontWeight: FontWeight.w700,
                  fontSize: layout.fontSize(12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StaffSupervisorRecentLogsSection extends StatelessWidget {
  const StaffSupervisorRecentLogsSection({
    super.key,
    required this.title,
    required this.logs,
    required this.logLabel,
    this.onLogTap,
  });

  final String title;
  final List<StaffSupervisorSystemLogEntry> logs;
  final String Function(StaffSupervisorSystemLogKind kind) logLabel;
  final ValueChanged<StaffSupervisorSystemLogEntry>? onLogTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSystemPanel(
      title: title,
      child: Column(
        children: [
          for (var index = 0; index < logs.length; index++) ...[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onLogTap == null ? null : () => onLogTap!(logs[index]),
                borderRadius: BorderRadius.circular(layout.radius(8)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: layout.spacing(8)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule_outlined,
                        color: StaffSupervisorDesign.accent,
                        size: layout.spacing(18),
                      ),
                      SizedBox(width: layout.spacing(8)),
                      AppText(
                        logs[index].time,
                        variant: AppTextVariant.bodyEmphasis,
                        color: StaffSupervisorDesign.accent,
                        fontWeight: FontWeight.w800,
                        fontSize: layout.fontSize(12),
                      ),
                      SizedBox(width: layout.spacing(8)),
                      Expanded(
                        child: AppText(
                          logLabel(logs[index].kind),
                          variant: AppTextVariant.body,
                          color: AppColors.homeBlack,
                          fontSize: layout.fontSize(12),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.secondaryGrey.withValues(alpha: 0.7),
                        size: layout.spacing(18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (index < logs.length - 1)
              Divider(height: 1, color: AppColors.homeDividerGrey),
          ],
        ],
      ),
    );
  }
}
