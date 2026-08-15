import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';

class StaffSupervisorEntryMetaCell extends StatelessWidget {
  const StaffSupervisorEntryMetaCell({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: StaffSupervisorDesign.accent, size: layout.spacing(16)),
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
          fontWeight: FontWeight.w700,
          fontSize: layout.fontSize(12),
        ),
      ],
    );
  }
}

class StaffSupervisorEntryResultCard extends StatelessWidget {
  const StaffSupervisorEntryResultCard({
    super.key,
    required this.sectionTitle,
    required this.guestName,
    required this.initials,
    required this.eventLabel,
    required this.eventName,
    required this.ticketTypeLabel,
    required this.ticketTypeName,
    required this.accessLabel,
    required this.accessName,
    this.qrStatusLabel,
    this.qrStatusText,
    this.footer,
  });

  final String sectionTitle;
  final String guestName;
  final String initials;
  final String eventLabel;
  final String eventName;
  final String ticketTypeLabel;
  final String ticketTypeName;
  final String accessLabel;
  final String accessName;
  final String? qrStatusLabel;
  final String? qrStatusText;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSectionCard(
      title: sectionTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: layout.spacing(22),
                backgroundColor: StaffSupervisorDesign.tileBackground,
                child: AppText(
                  initials,
                  variant: AppTextVariant.bodyEmphasis,
                  color: StaffSupervisorDesign.accent,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(14),
                ),
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: AppText(
                  guestName,
                  variant: AppTextVariant.bodyEmphasis,
                  color: AppColors.homeBlack,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(16),
                ),
              ),
            ],
          ),
          SizedBox(height: layout.spacing(14)),
          Row(
            children: [
              Expanded(
                child: StaffSupervisorEntryMetaCell(
                  icon: Icons.event_rounded,
                  label: eventLabel,
                  value: eventName,
                ),
              ),
              Container(
                width: 1,
                height: layout.spacing(40),
                color: AppColors.homeDividerGrey,
                margin: EdgeInsets.symmetric(horizontal: layout.spacing(6)),
              ),
              Expanded(
                child: StaffSupervisorEntryMetaCell(
                  icon: Icons.confirmation_number_outlined,
                  label: ticketTypeLabel,
                  value: ticketTypeName,
                ),
              ),
              Container(
                width: 1,
                height: layout.spacing(40),
                color: AppColors.homeDividerGrey,
                margin: EdgeInsets.symmetric(horizontal: layout.spacing(6)),
              ),
              Expanded(
                child: StaffSupervisorEntryMetaCell(
                  icon: Icons.shield_outlined,
                  label: accessLabel,
                  value: accessName,
                ),
              ),
            ],
          ),
          if (qrStatusLabel != null && qrStatusText != null) ...[
            SizedBox(height: layout.spacing(14)),
            Divider(color: AppColors.homeDividerGrey, height: 1),
            SizedBox(height: layout.spacing(12)),
            Row(
              children: [
                AppText(
                  '$qrStatusLabel:',
                  variant: AppTextVariant.body,
                  color: AppColors.secondaryGrey,
                  fontSize: layout.fontSize(13),
                ),
                SizedBox(width: layout.spacing(8)),
                Icon(
                  Icons.warning_amber_rounded,
                  color: StaffSupervisorDesign.accent,
                  size: layout.spacing(18),
                ),
                SizedBox(width: layout.spacing(4)),
                AppText(
                  qrStatusText!,
                  variant: AppTextVariant.bodyEmphasis,
                  color: StaffSupervisorDesign.accent,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(13),
                  letterSpacing: 0.5,
                ),
              ],
            ),
          ],
          if (footer != null) ...[
            SizedBox(height: layout.spacing(14)),
            footer!,
          ],
        ],
      ),
    );
  }
}

class StaffSupervisorIdentitySection extends StatelessWidget {
  const StaffSupervisorIdentitySection({
    super.key,
    required this.title,
    required this.fullNameLabel,
    required this.fullName,
    required this.phoneDigitsLabel,
    required this.phoneDigits,
    required this.documentLabel,
    required this.documentConfirmed,
    this.documentPendingLabel,
    this.isDocumentConfirmed = true,
  });

  final String title;
  final String fullNameLabel;
  final String fullName;
  final String phoneDigitsLabel;
  final String phoneDigits;
  final String documentLabel;
  final String documentConfirmed;
  final String? documentPendingLabel;
  final bool isDocumentConfirmed;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSectionCard(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _IdentityRow(
            layout: layout,
            icon: Icons.person_outline_rounded,
            label: fullNameLabel,
            value: fullName,
            valueColor: StaffSupervisorDesign.accent,
          ),
          _IdentityRow(
            layout: layout,
            icon: Icons.phone_outlined,
            label: phoneDigitsLabel,
            value: phoneDigits,
            valueColor: StaffSupervisorDesign.accent,
          ),
          _IdentityRow(
            layout: layout,
            icon: Icons.verified_user_outlined,
            label: documentLabel,
            value: isDocumentConfirmed
                ? documentConfirmed
                : (documentPendingLabel ?? documentConfirmed),
            valueColor: isDocumentConfirmed ? null : AppColors.secondaryGrey,
            showValue: !isDocumentConfirmed,
            trailing: isDocumentConfirmed
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: layout.spacing(8),
                      vertical: layout.spacing(4),
                    ),
                    decoration: BoxDecoration(
                      color: StaffSupervisorDesign.successGreen
                          .withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(layout.radius(8)),
                      border: Border.all(
                        color: StaffSupervisorDesign.successGreen
                            .withValues(alpha: 0.35),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: StaffSupervisorDesign.successGreen,
                          size: layout.spacing(14),
                        ),
                        SizedBox(width: layout.spacing(4)),
                        AppText(
                          documentConfirmed,
                          variant: AppTextVariant.label,
                          color: StaffSupervisorDesign.successGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: layout.fontSize(11),
                        ),
                      ],
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class _IdentityRow extends StatelessWidget {
  const _IdentityRow({
    required this.layout,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.trailing,
    this.showValue = true,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final Widget? trailing;
  final bool showValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: StaffSupervisorDesign.accent, size: layout.spacing(20)),
          SizedBox(width: layout.spacing(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  variant: AppTextVariant.body,
                  color: AppColors.secondaryGrey,
                  fontSize: layout.fontSize(12),
                ),
                if (showValue)
                  AppText(
                    value,
                    variant: AppTextVariant.bodyEmphasis,
                    color: valueColor ?? AppColors.homeBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: layout.fontSize(14),
                  ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class StaffSupervisorSystemRecordBar extends StatelessWidget {
  const StaffSupervisorSystemRecordBar({
    super.key,
    required this.title,
    required this.supervisorText,
    required this.timeText,
    required this.statusLabel,
    required this.statusValue,
    this.statusAsPill = false,
  });

  final String title;
  final String supervisorText;
  final String timeText;
  final String statusLabel;
  final String statusValue;
  final bool statusAsPill;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSectionCard(
      title: title,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: layout.spacing(40),
            height: layout.spacing(40),
            decoration: BoxDecoration(
              color: StaffSupervisorDesign.tileBackground,
              shape: BoxShape.circle,
              border: Border.all(color: StaffSupervisorDesign.tileBorder),
            ),
            child: Icon(
              Icons.assignment_outlined,
              color: StaffSupervisorDesign.accent,
              size: layout.spacing(20),
            ),
          ),
          SizedBox(width: layout.spacing(12)),
          Expanded(
            child: Wrap(
              spacing: layout.spacing(8),
              runSpacing: layout.spacing(6),
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _Chip(layout: layout, icon: Icons.person_outline_rounded, text: supervisorText),
                _Dot(layout: layout),
                _Chip(layout: layout, icon: Icons.schedule_rounded, text: timeText),
                _Dot(layout: layout),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      statusLabel,
                      variant: AppTextVariant.body,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(13),
                    ),
                    if (statusAsPill) ...[
                      SizedBox(width: layout.spacing(6)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: layout.spacing(8),
                          vertical: layout.spacing(4),
                        ),
                        decoration: BoxDecoration(
                          color: StaffSupervisorDesign.warningBackground,
                          borderRadius: BorderRadius.circular(layout.radius(8)),
                          border: Border.all(
                            color: StaffSupervisorDesign.accent.withValues(alpha: 0.35),
                          ),
                        ),
                        child: AppText(
                          statusValue,
                          variant: AppTextVariant.label,
                          color: StaffSupervisorDesign.accent,
                          fontWeight: FontWeight.w800,
                          fontSize: layout.fontSize(11),
                        ),
                      ),
                    ] else
                      AppText(
                        statusValue,
                        variant: AppTextVariant.bodyEmphasis,
                        color: StaffSupervisorDesign.accent,
                        fontWeight: FontWeight.w800,
                        fontSize: layout.fontSize(13),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.layout, required this.icon, required this.text});

  final ResponsiveLayout layout;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: layout.spacing(16), color: AppColors.secondaryGrey),
        SizedBox(width: layout.spacing(4)),
        AppText(
          text,
          variant: AppTextVariant.body,
          color: AppColors.homeBlack,
          fontSize: layout.fontSize(13),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.layout});

  final ResponsiveLayout layout;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: layout.spacing(4),
      height: layout.spacing(4),
      decoration: BoxDecoration(
        color: AppColors.secondaryGrey.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}
