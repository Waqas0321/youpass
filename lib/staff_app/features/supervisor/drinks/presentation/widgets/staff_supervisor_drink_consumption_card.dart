import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_drink_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';

class StaffSupervisorDrinkConsumptionCard extends StatelessWidget {
  const StaffSupervisorDrinkConsumptionCard({
    super.key,
    required this.layout,
    required this.l10n,
    required this.detail,
  });

  static const _successGreen = Color(0xFF22C55E);
  static const _warningAmber = Color(0xFFF59E0B);
  static const _dangerRed = Color(0xFFEF4444);

  final ResponsiveLayout layout;
  final dynamic l10n;
  final StaffSupervisorDrinkSearchDetail detail;

  @override
  Widget build(BuildContext context) {
    final statusLabel = _statusLabel();
    final statusColor = _statusColor();

    return StaffSupervisorSectionCard(
      title: l10n.staffSupervisorConsumptionFoundTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaffSupervisorDetailRow(
            label: l10n.staffSupervisorConsumptionUserLabel,
            value: detail.guestName,
          ),
          StaffSupervisorDetailRow(
            label: l10n.staffSupervisorConsumptionProductLabel,
            value: detail.productName,
          ),
          if ((detail.barName ?? '').isNotEmpty)
            StaffSupervisorDetailRow(
              label: l10n.staffSupervisorConsumptionBarLabel,
              value: detail.barName!,
            ),
          if ((detail.validatedAtLabel ?? detail.lastUsedAtLabel ?? '').isNotEmpty)
            StaffSupervisorDetailRow(
              label: l10n.staffSupervisorConsumptionTimeLabel,
              value: detail.validatedAtLabel ?? detail.lastUsedAtLabel ?? '—',
            ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: layout.spacing(6)),
            child: Divider(
              height: 1,
              thickness: 1,
              color: AppColors.homeDividerGrey,
            ),
          ),
          StaffSupervisorDetailRow(
            label: l10n.staffSupervisorConsumptionIdLabel,
            value: detail.consumptionId,
          ),
          StaffSupervisorDetailRow(
            label: l10n.staffSupervisorConsumptionStatusLabel,
            value: statusLabel,
            valueColor: statusColor,
            trailing: Icon(
              _statusIcon(),
              color: statusColor,
              size: layout.spacing(18),
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel() {
    switch (detail.status) {
      case StaffSupervisorDrinkStatus.validated:
        return l10n.staffSupervisorConsumptionStatusValidated;
      case StaffSupervisorDrinkStatus.pending:
        return l10n.staffSupervisorHistoryPending;
      case StaffSupervisorDrinkStatus.cancelled:
        return l10n.staffSupervisorOverrideStatusBlocked;
      case StaffSupervisorDrinkStatus.blocked:
        return l10n.staffSupervisorOverrideStatusBlocked;
      case StaffSupervisorDrinkStatus.error:
        return l10n.staffSupervisorSearchEntryFilterError;
    }
  }

  Color _statusColor() {
    switch (detail.status) {
      case StaffSupervisorDrinkStatus.validated:
        return _successGreen;
      case StaffSupervisorDrinkStatus.pending:
        return _warningAmber;
      case StaffSupervisorDrinkStatus.cancelled:
      case StaffSupervisorDrinkStatus.blocked:
      case StaffSupervisorDrinkStatus.error:
        return _dangerRed;
    }
  }

  IconData _statusIcon() {
    switch (detail.status) {
      case StaffSupervisorDrinkStatus.validated:
        return Icons.check_circle_rounded;
      case StaffSupervisorDrinkStatus.pending:
        return Icons.schedule_rounded;
      default:
        return Icons.cancel_rounded;
    }
  }
}

class StaffSupervisorDrinkHistorySection extends StatelessWidget {
  const StaffSupervisorDrinkHistorySection({
    super.key,
    required this.layout,
    required this.l10n,
    required this.detail,
  });

  final ResponsiveLayout layout;
  final dynamic l10n;
  final StaffSupervisorDrinkSearchDetail detail;

  @override
  Widget build(BuildContext context) {
    final events = detail.recentEvents;

    return StaffSupervisorSectionCard(
      title: l10n.staffSupervisorHistoryTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (events.isEmpty) ...[
            if ((detail.validatedAtLabel ?? '').isNotEmpty)
              StaffSupervisorHistoryBullet(
                text: l10n.staffSupervisorHistoryValidated(
                  detail.validatedAtLabel!,
                ),
              ),
            if (!detail.isValidated)
              StaffSupervisorHistoryBullet(
                text: l10n.staffSupervisorHistoryPending,
                muted: true,
              ),
          ] else
            ...events.map(
              (event) => StaffSupervisorHistoryBullet(
                text: '${event.timeLabel} · ${event.detail}',
                muted: event.kind != StaffSupervisorDrinkEventKind.validated,
              ),
            ),
        ],
      ),
    );
  }
}
