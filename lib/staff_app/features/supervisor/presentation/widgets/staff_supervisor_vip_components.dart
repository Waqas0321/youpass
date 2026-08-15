import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_vip_table_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';

class StaffSupervisorVipTableCard extends StatelessWidget {
  const StaffSupervisorVipTableCard({
    super.key,
    required this.tableName,
    required this.accessLabel,
    required this.eventName,
    required this.statusLabel,
    required this.activeStatusText,
    required this.capacityLabel,
    required this.capacityValue,
    required this.enteredLabel,
    required this.enteredValue,
    required this.pendingLabel,
    required this.pendingValue,
    required this.purchaseResponsibleLabel,
    required this.purchaseResponsible,
    required this.purchaseIdLabel,
    required this.purchaseId,
    this.isActive = true,
  });

  final String tableName;
  final String accessLabel;
  final String eventName;
  final String statusLabel;
  final String activeStatusText;
  final String capacityLabel;
  final String capacityValue;
  final String enteredLabel;
  final String enteredValue;
  final String pendingLabel;
  final String pendingValue;
  final String purchaseResponsibleLabel;
  final String purchaseResponsible;
  final String purchaseIdLabel;
  final String purchaseId;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: layout.spacing(44),
                height: layout.spacing(44),
                decoration: BoxDecoration(
                  color: StaffSupervisorDesign.tileBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: StaffSupervisorDesign.tileBorder),
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: StaffSupervisorDesign.accent,
                  size: layout.spacing(24),
                ),
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      tableName,
                      variant: AppTextVariant.bodyEmphasis,
                      color: AppColors.homeBlack,
                      fontWeight: FontWeight.w800,
                      fontSize: layout.fontSize(16),
                    ),
                    SizedBox(height: layout.spacing(2)),
                    AppText(
                      '$accessLabel · $eventName',
                      variant: AppTextVariant.body,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(13),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: layout.spacing(8),
                  vertical: layout.spacing(4),
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? StaffSupervisorDesign.successBackground
                      : StaffSupervisorDesign.warningBackground,
                  borderRadius: BorderRadius.circular(layout.radius(20)),
                  border: Border.all(
                    color: isActive
                        ? StaffSupervisorDesign.successGreen.withValues(alpha: 0.5)
                        : StaffSupervisorDesign.accent.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      statusLabel,
                      variant: AppTextVariant.label,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(10),
                    ),
                    if (isActive) ...[
                      Icon(
                        Icons.check_circle_rounded,
                        color: StaffSupervisorDesign.successGreen,
                        size: layout.spacing(14),
                      ),
                      SizedBox(width: layout.spacing(2)),
                    ],
                    AppText(
                      activeStatusText,
                      variant: AppTextVariant.label,
                      color: isActive
                          ? StaffSupervisorDesign.successGreen
                          : StaffSupervisorDesign.accent,
                      fontWeight: FontWeight.w800,
                      fontSize: layout.fontSize(10),
                      letterSpacing: 0.4,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: layout.spacing(16)),
          Row(
            children: [
              Expanded(
                child: _StatCell(
                  layout: layout,
                  icon: Icons.groups_outlined,
                  iconColor: StaffSupervisorDesign.accent,
                  label: capacityLabel,
                  value: capacityValue,
                ),
              ),
              Container(
                width: 1,
                height: layout.spacing(44),
                color: AppColors.homeDividerGrey,
                margin: EdgeInsets.symmetric(horizontal: layout.spacing(6)),
              ),
              Expanded(
                child: _StatCell(
                  layout: layout,
                  icon: Icons.check_circle_outline_rounded,
                  iconColor: StaffSupervisorDesign.successGreen,
                  label: enteredLabel,
                  value: enteredValue,
                ),
              ),
              Container(
                width: 1,
                height: layout.spacing(44),
                color: AppColors.homeDividerGrey,
                margin: EdgeInsets.symmetric(horizontal: layout.spacing(6)),
              ),
              Expanded(
                child: _StatCell(
                  layout: layout,
                  icon: Icons.schedule_rounded,
                  iconColor: StaffSupervisorDesign.accent,
                  label: pendingLabel,
                  value: pendingValue,
                ),
              ),
            ],
          ),
          SizedBox(height: layout.spacing(14)),
          Divider(color: AppColors.homeDividerGrey, height: 1),
          SizedBox(height: layout.spacing(12)),
          Row(
            children: [
              Expanded(
                child: _InfoPair(
                  layout: layout,
                  label: purchaseResponsibleLabel,
                  value: purchaseResponsible,
                ),
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: _InfoPair(
                  layout: layout,
                  label: purchaseIdLabel,
                  value: purchaseId,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.layout,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: layout.spacing(18)),
        SizedBox(height: layout.spacing(4)),
        AppText(
          label,
          variant: AppTextVariant.body,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(10),
        ),
        AppText(
          value,
          variant: AppTextVariant.bodyEmphasis,
          color: AppColors.homeBlack,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(13),
        ),
      ],
    );
  }
}

class _InfoPair extends StatelessWidget {
  const _InfoPair({
    required this.layout,
    required this.label,
    required this.value,
  });

  final ResponsiveLayout layout;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          variant: AppTextVariant.body,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(11),
        ),
        AppText(
          value,
          variant: AppTextVariant.bodyEmphasis,
          color: AppColors.homeBlack,
          fontWeight: FontWeight.w700,
          fontSize: layout.fontSize(13),
        ),
      ],
    );
  }
}

class StaffSupervisorVipGuestList extends StatelessWidget {
  const StaffSupervisorVipGuestList({
    super.key,
    required this.title,
    required this.guests,
    required this.enteredSubtitle,
    required this.pendingSubtitle,
    this.onGuestTap,
    this.selectedSlotId,
    this.selectionEnabled = false,
    this.selectionHint,
    this.isGuestSelectable,
  });

  final String title;
  final List<StaffSupervisorVipGuest> guests;
  final String Function(String time) enteredSubtitle;
  final String pendingSubtitle;
  final ValueChanged<StaffSupervisorVipGuest>? onGuestTap;
  final String? selectedSlotId;
  final bool selectionEnabled;
  final String? selectionHint;
  final bool Function(StaffSupervisorVipGuest guest)? isGuestSelectable;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSectionCard(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (selectionHint != null && selectionEnabled) ...[
            AppText(
              selectionHint!,
              variant: AppTextVariant.body,
              color: AppColors.secondaryGrey,
              fontSize: layout.fontSize(12),
            ),
            SizedBox(height: layout.spacing(10)),
          ],
          for (var index = 0; index < guests.length; index++) ...[
            _GuestRow(
              layout: layout,
              guest: guests[index],
              enteredSubtitle: enteredSubtitle,
              pendingSubtitle: pendingSubtitle,
              selected: selectedSlotId == guests[index].slotId,
              selectionEnabled: selectionEnabled,
              selectable: isGuestSelectable?.call(guests[index]) ?? true,
              onTap: onGuestTap == null ? null : () => onGuestTap!(guests[index]),
            ),
            if (index < guests.length - 1)
              Divider(
                height: 1,
                color: AppColors.homeDividerGrey,
                indent: layout.spacing(40),
              ),
          ],
        ],
      ),
    );
  }
}

class _GuestRow extends StatelessWidget {
  const _GuestRow({
    required this.layout,
    required this.guest,
    required this.enteredSubtitle,
    required this.pendingSubtitle,
    this.onTap,
    this.selected = false,
    this.selectionEnabled = false,
    this.selectable = true,
  });

  final ResponsiveLayout layout;
  final StaffSupervisorVipGuest guest;
  final String Function(String time) enteredSubtitle;
  final String pendingSubtitle;
  final VoidCallback? onTap;
  final bool selected;
  final bool selectionEnabled;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final isEntered = guest.status == StaffSupervisorVipGuestStatus.entered;
    final statusColor =
        isEntered ? StaffSupervisorDesign.successGreen : StaffSupervisorDesign.accent;
    final statusIcon =
        isEntered ? Icons.check_rounded : Icons.schedule_rounded;
    final subtitle = isEntered && guest.entryTime != null
        ? enteredSubtitle(guest.entryTime!)
        : pendingSubtitle;
    final disabled = selectionEnabled && !selectable;
    final borderColor = selected
        ? StaffSupervisorDesign.accent
        : (disabled ? AppColors.homeDividerGrey : Colors.transparent);

    return Material(
      color: selected
          ? StaffSupervisorDesign.accent.withValues(alpha: 0.08)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(layout.radius(8)),
      child: InkWell(
        onTap: disabled ? null : onTap,
        borderRadius: BorderRadius.circular(layout.radius(8)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(layout.radius(8)),
            border: Border.all(color: borderColor, width: selected ? 1.5 : 1),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: layout.spacing(8),
            vertical: layout.spacing(10),
          ),
          child: Row(
            children: [
              Container(
                width: layout.spacing(28),
                height: layout.spacing(28),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: disabled ? 0.08 : 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  statusIcon,
                  color: disabled ? AppColors.secondaryGrey : statusColor,
                  size: layout.spacing(16),
                ),
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            guest.name,
                            variant: AppTextVariant.bodyEmphasis,
                            color: disabled ? AppColors.secondaryGrey : AppColors.homeBlack,
                            fontWeight: FontWeight.w700,
                            fontSize: layout.fontSize(14),
                          ),
                        ),
                        if (guest.isOwner)
                          Container(
                            margin: EdgeInsets.only(left: layout.spacing(6)),
                            padding: EdgeInsets.symmetric(
                              horizontal: layout.spacing(6),
                              vertical: layout.spacing(2),
                            ),
                            decoration: BoxDecoration(
                              color: StaffSupervisorDesign.tileBackground,
                              borderRadius: BorderRadius.circular(layout.radius(10)),
                              border: Border.all(color: StaffSupervisorDesign.tileBorder),
                            ),
                            child: AppText(
                              'OWNER',
                              variant: AppTextVariant.label,
                              color: StaffSupervisorDesign.accent,
                              fontSize: layout.fontSize(9),
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                          ),
                      ],
                    ),
                    AppText(
                      subtitle,
                      variant: AppTextVariant.body,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(12),
                    ),
                    if (guest.accessLabel.isNotEmpty) ...[
                      SizedBox(height: layout.spacing(2)),
                      AppText(
                        guest.accessLabel,
                        variant: AppTextVariant.body,
                        color: StaffSupervisorDesign.accent,
                        fontSize: layout.fontSize(11),
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ],
                ),
              ),
              if (selected)
                Icon(
                  Icons.check_circle_rounded,
                  color: StaffSupervisorDesign.accent,
                  size: layout.spacing(22),
                )
              else
                Icon(
                  Icons.chevron_right_rounded,
                  color: disabled ? AppColors.homeDividerGrey : AppColors.secondaryGrey,
                  size: layout.spacing(22),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class StaffSupervisorVipSlotPicker extends StatelessWidget {
  const StaffSupervisorVipSlotPicker({
    super.key,
    required this.title,
    required this.slots,
    required this.selectedSlotId,
    required this.onSlotSelected,
    this.emptyLabel,
  });

  final String title;
  final List<StaffSupervisorVipAvailableSlot> slots;
  final String? selectedSlotId;
  final ValueChanged<String> onSlotSelected;
  final String? emptyLabel;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSectionCard(
      title: title,
      child: slots.isEmpty
          ? AppText(
              emptyLabel ?? 'No seats available',
              variant: AppTextVariant.body,
              color: AppColors.secondaryGrey,
              fontSize: layout.fontSize(13),
            )
          : Wrap(
              spacing: layout.spacing(8),
              runSpacing: layout.spacing(8),
              children: slots.map((slot) {
                final selected = selectedSlotId == slot.slotId;
                return Material(
                  color: selected
                      ? StaffSupervisorDesign.accent.withValues(alpha: 0.15)
                      : AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(layout.radius(20)),
                  child: InkWell(
                    onTap: () => onSlotSelected(slot.slotId),
                    borderRadius: BorderRadius.circular(layout.radius(20)),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: layout.spacing(14),
                        vertical: layout.spacing(10),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(layout.radius(20)),
                        border: Border.all(
                          color: selected
                              ? StaffSupervisorDesign.accent
                              : AppColors.homeDividerGrey,
                        ),
                      ),
                      child: AppText(
                        slot.label,
                        variant: AppTextVariant.bodyEmphasis,
                        color: selected
                            ? StaffSupervisorDesign.accent
                            : AppColors.homeBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: layout.fontSize(13),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}

class StaffSupervisorVipAccessPicker extends StatelessWidget {
  const StaffSupervisorVipAccessPicker({
    super.key,
    required this.title,
    required this.options,
    required this.selectedLabel,
    required this.onOptionSelected,
  });

  final String title;
  final List<StaffSupervisorVipAccessOption> options;
  final String? selectedLabel;
  final ValueChanged<String> onOptionSelected;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSectionCard(
      title: title,
      child: Wrap(
        spacing: layout.spacing(8),
        runSpacing: layout.spacing(8),
        children: options.map((option) {
          final selected = selectedLabel == option.label;
          return Material(
            color: selected
                ? StaffSupervisorDesign.accent.withValues(alpha: 0.15)
                : AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(layout.radius(20)),
            child: InkWell(
              onTap: () => onOptionSelected(option.label),
              borderRadius: BorderRadius.circular(layout.radius(20)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: layout.spacing(14),
                  vertical: layout.spacing(10),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(layout.radius(20)),
                  border: Border.all(
                    color: selected
                        ? StaffSupervisorDesign.accent
                        : AppColors.homeDividerGrey,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      option.tier == 'vip'
                          ? Icons.workspace_premium_outlined
                          : Icons.confirmation_number_outlined,
                      color: selected
                          ? StaffSupervisorDesign.accent
                          : AppColors.secondaryGrey,
                      size: layout.spacing(16),
                    ),
                    SizedBox(width: layout.spacing(6)),
                    AppText(
                      option.label,
                      variant: AppTextVariant.bodyEmphasis,
                      color: selected
                          ? StaffSupervisorDesign.accent
                          : AppColors.homeBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: layout.fontSize(13),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class StaffSupervisorVipHistorySection extends StatelessWidget {
  const StaffSupervisorVipHistorySection({
    super.key,
    required this.title,
    required this.entries,
    required this.supervisorPrefix,
    required this.entryTitle,
    this.onEntryTap,
  });

  final String title;
  final List<StaffSupervisorVipHistoryEntry> entries;
  final String supervisorPrefix;
  final String Function(StaffSupervisorVipHistoryType type) entryTitle;
  final ValueChanged<StaffSupervisorVipHistoryEntry>? onEntryTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSectionCard(
      title: title,
      child: Column(
        children: [
          for (var index = 0; index < entries.length; index++) ...[
            _HistoryRow(
              layout: layout,
              entry: entries[index],
              title: entryTitle(entries[index].type),
              supervisorPrefix: supervisorPrefix,
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

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({
    required this.layout,
    required this.entry,
    required this.title,
    required this.supervisorPrefix,
    this.onTap,
  });

  final ResponsiveLayout layout;
  final StaffSupervisorVipHistoryEntry entry;
  final String title;
  final String supervisorPrefix;
  final VoidCallback? onTap;

  (Color, IconData) get _badgeStyle {
    return switch (entry.type) {
      StaffSupervisorVipHistoryType.extraGuest => (
          StaffSupervisorDesign.successGreen,
          Icons.person_add_alt_1_rounded,
        ),
      StaffSupervisorVipHistoryType.qrReleased => (
          StaffSupervisorDesign.accent,
          Icons.lock_open_rounded,
        ),
      StaffSupervisorVipHistoryType.tableModified => (
          StaffSupervisorDesign.accent,
          Icons.workspace_premium_outlined,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final (badgeColor, badgeIcon) = _badgeStyle;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: layout.spacing(10)),
          child: Row(
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
                  ],
                ),
              ),
              AppText(
                entry.time,
                variant: AppTextVariant.body,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(13),
                fontWeight: FontWeight.w600,
              ),
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
