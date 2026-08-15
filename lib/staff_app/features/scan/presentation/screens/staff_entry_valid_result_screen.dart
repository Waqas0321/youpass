import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/scan/domain/models/staff_qr_scan_result.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_entry_qr_preview.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_viewfinder_overlay.dart';

class StaffEntryValidResultScreen extends StatelessWidget {
  const StaffEntryValidResultScreen({
    super.key,
    required this.result,
  });

  final StaffQrScanResult result;

  static const _cardGreen = Color(0xFF22C55E);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);
    final entryId = result.entryId ?? result.transactionId;
    final qrData = result.qrPayload.isNotEmpty ? result.qrPayload : entryId;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Column(
        children: [
          const StaffScanScreenHeader(showBottomDivider: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                layout.spacing(20),
                layout.spacing(16),
                layout.spacing(20),
                layout.spacing(12),
              ),
              child: _EntryValidCard(
                layout: layout,
                validTitle: l10n.staffEntryValidTitle,
                validSubtitle: l10n.staffEntryValidSubtitle,
                eventLabel: l10n.staffEntryValidEventLabel,
                eventName: result.eventName ?? 'YouFest 2026',
                guestName: result.guestName,
                entryIdLabel: l10n.staffEntryValidEntryIdLabel,
                entryId: entryId,
                qrData: qrData,
                ticketTypeLabel: l10n.staffEntryValidTicketTypeLabel,
                ticketType: result.productName,
                accessLabel: l10n.staffEntryValidAccessLabel,
                accessLevel: result.accessLevel ?? 'VIP 1',
                timeLabel: l10n.staffEntryValidTimeLabel,
                timeValue: result.scanTimeLabel,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              layout.spacing(20),
              layout.spacing(8),
              layout.spacing(20),
              layout.spacing(24),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: layout.buttonHeight,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: staffScanAccent,
                    foregroundColor: AppColors.backgroundWhite,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(layout.radius(16)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.smartphone_rounded,
                        size: layout.spacing(20),
                      ),
                      SizedBox(width: layout.spacing(10)),
                      AppText(
                        l10n.staffEntryValidAllowButton,
                        variant: AppTextVariant.button,
                        color: AppColors.backgroundWhite,
                        fontWeight: FontWeight.w800,
                        fontSize: layout.fontSize(14),
                        letterSpacing: 0.8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryValidCard extends StatelessWidget {
  const _EntryValidCard({
    required this.layout,
    required this.validTitle,
    required this.validSubtitle,
    required this.eventLabel,
    required this.eventName,
    required this.guestName,
    required this.entryIdLabel,
    required this.entryId,
    required this.qrData,
    required this.ticketTypeLabel,
    required this.ticketType,
    required this.accessLabel,
    required this.accessLevel,
    required this.timeLabel,
    required this.timeValue,
  });

  final ResponsiveLayout layout;
  final String validTitle;
  final String validSubtitle;
  final String eventLabel;
  final String eventName;
  final String guestName;
  final String entryIdLabel;
  final String entryId;
  final String qrData;
  final String ticketTypeLabel;
  final String ticketType;
  final String accessLabel;
  final String accessLevel;
  final String timeLabel;
  final String timeValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: StaffEntryValidResultScreen._cardGreen,
        borderRadius: BorderRadius.circular(layout.radius(24)),
        boxShadow: [
          BoxShadow(
            color: StaffEntryValidResultScreen._cardGreen.withValues(alpha: 0.28),
            blurRadius: layout.spacing(18),
            offset: Offset(0, layout.spacing(8)),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: layout.spacing(12),
            left: layout.spacing(16),
            child: Icon(
              Icons.celebration_outlined,
              color: Colors.white.withValues(alpha: 0.18),
              size: layout.spacing(28),
            ),
          ),
          Positioned(
            top: layout.spacing(20),
            right: layout.spacing(18),
            child: Icon(
              Icons.auto_awesome_outlined,
              color: Colors.white.withValues(alpha: 0.18),
              size: layout.spacing(24),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              layout.spacing(20),
              layout.spacing(24),
              layout.spacing(20),
              layout.spacing(22),
            ),
            child: Column(
              children: [
                Container(
                  width: layout.spacing(56),
                  height: layout.spacing(56),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundWhite,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: StaffEntryValidResultScreen._cardGreen,
                    size: layout.spacing(34),
                  ),
                ),
                SizedBox(height: layout.spacing(14)),
                AppText(
                  validTitle,
                  variant: AppTextVariant.headline,
                  textAlign: TextAlign.center,
                  color: AppColors.backgroundWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(32),
                  letterSpacing: 0.6,
                ),
                SizedBox(height: layout.spacing(4)),
                AppText(
                  validSubtitle,
                  variant: AppTextVariant.body,
                  textAlign: TextAlign.center,
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: layout.fontSize(14),
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: layout.spacing(18)),
                _EntryValidDivider(layout: layout),
                SizedBox(height: layout.spacing(4)),
                _EntryValidStackedRow(
                  layout: layout,
                  icon: Icons.event_outlined,
                  label: eventLabel,
                  value: eventName,
                ),
                _EntryValidDivider(layout: layout),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: layout.spacing(12)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _EntryValidIconCircle(
                              layout: layout,
                              icon: Icons.person_outline_rounded,
                            ),
                            SizedBox(width: layout.spacing(12)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    guestName,
                                    variant: AppTextVariant.bodyEmphasis,
                                    color: AppColors.backgroundWhite,
                                    fontWeight: FontWeight.w700,
                                    fontSize: layout.fontSize(16),
                                  ),
                                  SizedBox(height: layout.spacing(6)),
                                  AppText(
                                    entryIdLabel,
                                    variant: AppTextVariant.label,
                                    color: Colors.white.withValues(alpha: 0.78),
                                    fontSize: layout.fontSize(11),
                                  ),
                                  AppText(
                                    entryId,
                                    variant: AppTextVariant.body,
                                    color: AppColors.backgroundWhite,
                                    fontWeight: FontWeight.w600,
                                    fontSize: layout.fontSize(13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: layout.spacing(12)),
                      StaffEntryQrPreview(
                        layout: layout,
                        qrData: qrData,
                        entryId: entryId,
                        captionColor: StaffEntryValidResultScreen._cardGreen,
                      ),
                    ],
                  ),
                ),
                _EntryValidDivider(layout: layout),
                _EntryValidSplitRow(
                  layout: layout,
                  icon: Icons.confirmation_number_outlined,
                  label: ticketTypeLabel,
                  value: ticketType,
                ),
                _EntryValidDivider(layout: layout),
                _EntryValidSplitRow(
                  layout: layout,
                  icon: Icons.star_outline_rounded,
                  label: accessLabel,
                  value: accessLevel,
                ),
                _EntryValidDivider(layout: layout),
                _EntryValidSplitRow(
                  layout: layout,
                  icon: Icons.schedule_rounded,
                  label: timeLabel,
                  value: timeValue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryValidStackedRow extends StatelessWidget {
  const _EntryValidStackedRow({
    required this.layout,
    required this.icon,
    required this.label,
    required this.value,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: layout.spacing(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _EntryValidIconCircle(layout: layout, icon: icon),
          SizedBox(width: layout.spacing(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  variant: AppTextVariant.label,
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: layout.fontSize(11),
                ),
                SizedBox(height: layout.spacing(2)),
                AppText(
                  value,
                  variant: AppTextVariant.bodyEmphasis,
                  color: AppColors.backgroundWhite,
                  fontWeight: FontWeight.w700,
                  fontSize: layout.fontSize(15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryValidSplitRow extends StatelessWidget {
  const _EntryValidSplitRow({
    required this.layout,
    required this.icon,
    required this.label,
    required this.value,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: layout.spacing(12)),
      child: Row(
        children: [
          _EntryValidIconCircle(layout: layout, icon: icon),
          SizedBox(width: layout.spacing(12)),
          Expanded(
            child: AppText(
              label,
              variant: AppTextVariant.label,
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: layout.fontSize(11),
            ),
          ),
          AppText(
            value,
            variant: AppTextVariant.bodyEmphasis,
            textAlign: TextAlign.right,
            color: AppColors.backgroundWhite,
            fontWeight: FontWeight.w700,
            fontSize: layout.fontSize(15),
          ),
        ],
      ),
    );
  }
}

class _EntryValidIconCircle extends StatelessWidget {
  const _EntryValidIconCircle({
    required this.layout,
    required this.icon,
  });

  final ResponsiveLayout layout;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: layout.spacing(36),
      height: layout.spacing(36),
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: StaffEntryValidResultScreen._cardGreen,
        size: layout.spacing(18),
      ),
    );
  }
}

class _EntryValidDivider extends StatelessWidget {
  const _EntryValidDivider({required this.layout});

  final ResponsiveLayout layout;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.white.withValues(alpha: 0.22),
    );
  }
}
