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

class StaffEntryInvalidResultScreen extends StatelessWidget {
  const StaffEntryInvalidResultScreen({
    super.key,
    required this.result,
  });

  final StaffQrScanResult result;

  static const _cardRed = Color(0xFFEF4444);
  static const _cardRedDark = Color(0xFFB91C1C);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);
    final entryId = result.entryId ?? result.transactionId;
    final qrData = result.qrPayload.isNotEmpty ? result.qrPayload : entryId;
    final lastAccessDate = result.lastUsedDateLabel != null
        ? l10n.staffEntryInvalidLastAccessDate(result.lastUsedDateLabel!)
        : null;

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
              child: _EntryInvalidCard(
                layout: layout,
                invalidTitle: l10n.staffEntryInvalidTitle,
                invalidSubtitle: l10n.staffEntryInvalidSubtitle,
                reasonLabel: l10n.staffEntryInvalidReasonLabel,
                reasonTitle: l10n.staffEntryInvalidReasonTitle,
                reasonMessage: l10n.staffEntryInvalidReasonMessage,
                lastAccessLabel: l10n.staffEntryInvalidLastAccessLabel,
                lastAccessTime: result.lastUsedTimeLabel ?? '--:--',
                lastAccessDate: lastAccessDate,
                userLabel: l10n.staffEntryInvalidUserLabel,
                guestName: result.guestName,
                entryId: entryId,
                qrData: qrData,
                warningMessage: l10n.staffEntryInvalidWarning,
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
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: staffScanAccent,
                    foregroundColor: AppColors.backgroundWhite,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(layout.radius(14)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chevron_left_rounded, size: layout.spacing(20)),
                      SizedBox(width: layout.spacing(10)),
                      AppText(
                        l10n.staffScanResultBackButton,
                        variant: AppTextVariant.button,
                        color: AppColors.backgroundWhite,
                        fontWeight: FontWeight.w700,
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

class _EntryInvalidCard extends StatelessWidget {
  const _EntryInvalidCard({
    required this.layout,
    required this.invalidTitle,
    required this.invalidSubtitle,
    required this.reasonLabel,
    required this.reasonTitle,
    required this.reasonMessage,
    required this.lastAccessLabel,
    required this.lastAccessTime,
    required this.lastAccessDate,
    required this.userLabel,
    required this.guestName,
    required this.entryId,
    required this.qrData,
    required this.warningMessage,
  });

  final ResponsiveLayout layout;
  final String invalidTitle;
  final String invalidSubtitle;
  final String reasonLabel;
  final String reasonTitle;
  final String reasonMessage;
  final String lastAccessLabel;
  final String lastAccessTime;
  final String? lastAccessDate;
  final String userLabel;
  final String guestName;
  final String entryId;
  final String qrData;
  final String warningMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: StaffEntryInvalidResultScreen._cardRed,
        borderRadius: BorderRadius.circular(layout.radius(24)),
        boxShadow: [
          BoxShadow(
            color: StaffEntryInvalidResultScreen._cardRed.withValues(alpha: 0.28),
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
              color: Colors.white.withValues(alpha: 0.14),
              size: layout.spacing(28),
            ),
          ),
          Positioned(
            top: layout.spacing(20),
            right: layout.spacing(18),
            child: Icon(
              Icons.auto_awesome_outlined,
              color: Colors.white.withValues(alpha: 0.14),
              size: layout.spacing(24),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              layout.spacing(20),
              layout.spacing(24),
              layout.spacing(20),
              layout.spacing(20),
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
                    Icons.close_rounded,
                    color: StaffEntryInvalidResultScreen._cardRed,
                    size: layout.spacing(34),
                  ),
                ),
                SizedBox(height: layout.spacing(14)),
                AppText(
                  invalidTitle,
                  variant: AppTextVariant.headline,
                  textAlign: TextAlign.center,
                  color: AppColors.backgroundWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(32),
                  letterSpacing: 0.6,
                ),
                SizedBox(height: layout.spacing(4)),
                AppText(
                  invalidSubtitle,
                  variant: AppTextVariant.body,
                  textAlign: TextAlign.center,
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: layout.fontSize(14),
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: layout.spacing(22)),
                _EntryInvalidRow(
                  layout: layout,
                  icon: Icons.error_outline_rounded,
                  label: reasonLabel,
                  title: reasonTitle,
                  subtitle: reasonMessage,
                ),
                _EntryInvalidDivider(layout: layout),
                _EntryInvalidRow(
                  layout: layout,
                  icon: Icons.schedule_rounded,
                  label: lastAccessLabel,
                  title: lastAccessTime,
                  subtitle: lastAccessDate,
                ),
                _EntryInvalidDivider(layout: layout),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _EntryInvalidRow(
                        layout: layout,
                        icon: Icons.person_outline_rounded,
                        label: userLabel,
                        title: guestName,
                        subtitle: entryId,
                        compact: true,
                      ),
                    ),
                    SizedBox(width: layout.spacing(12)),
                    StaffEntryQrPreview(
                      layout: layout,
                      qrData: qrData,
                      entryId: entryId,
                      captionColor: StaffEntryInvalidResultScreen._cardRed,
                    ),
                  ],
                ),
                SizedBox(height: layout.spacing(18)),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(layout.spacing(14)),
                  decoration: BoxDecoration(
                    color: StaffEntryInvalidResultScreen._cardRedDark
                        .withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(layout.radius(14)),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        color: Colors.white.withValues(alpha: 0.9),
                        size: layout.spacing(20),
                      ),
                      SizedBox(width: layout.spacing(10)),
                      Expanded(
                        child: AppText(
                          warningMessage,
                          variant: AppTextVariant.body,
                          color: Colors.white.withValues(alpha: 0.92),
                          fontSize: layout.fontSize(12),
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryInvalidRow extends StatelessWidget {
  const _EntryInvalidRow({
    required this.layout,
    required this.icon,
    required this.label,
    required this.title,
    this.subtitle,
    this.compact = false,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final String title;
  final String? subtitle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: compact ? 0 : layout.spacing(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _EntryInvalidIconCircle(layout: layout, icon: icon),
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
                  title,
                  variant: AppTextVariant.bodyEmphasis,
                  color: AppColors.backgroundWhite,
                  fontWeight: FontWeight.w700,
                  fontSize: layout.fontSize(15),
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  SizedBox(height: layout.spacing(2)),
                  AppText(
                    subtitle!,
                    variant: AppTextVariant.body,
                    color: Colors.white.withValues(alpha: 0.82),
                    fontSize: layout.fontSize(12),
                    height: 1.35,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryInvalidIconCircle extends StatelessWidget {
  const _EntryInvalidIconCircle({
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
        color: StaffEntryInvalidResultScreen._cardRed,
        size: layout.spacing(18),
      ),
    );
  }
}

class _EntryInvalidDivider extends StatelessWidget {
  const _EntryInvalidDivider({required this.layout});

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
