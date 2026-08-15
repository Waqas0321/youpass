import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/scan/domain/models/staff_qr_scan_result.dart';
import 'package:youpass/staff_app/features/scan/presentation/screens/staff_entry_invalid_result_screen.dart';
import 'package:youpass/staff_app/features/scan/presentation/screens/staff_entry_valid_result_screen.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_viewfinder_overlay.dart';

class StaffQrScanResultScreen extends StatelessWidget {
  const StaffQrScanResultScreen({
    super.key,
    required this.result,
  });

  final StaffQrScanResult result;

  static const _successGreen = Color(0xFF22C55E);
  static const _successGreenSoft = Color(0xFFDCFCE7);
  static const _errorRed = Color(0xFFEF4444);
  static const _errorRedSoft = Color(0xFFFEE2E2);
  static const _noticeCream = Color(0xFFFFF8EB);
  static const _noticeRedBg = Color(0xFFFEE2E2);

  @override
  Widget build(BuildContext context) {
    if (result.isEntryScan && result.isValid) {
      return StaffEntryValidResultScreen(result: result);
    }
    if (result.isEntryScan && !result.isValid) {
      return StaffEntryInvalidResultScreen(result: result);
    }

    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Column(
        children: [
          const StaffScanScreenHeader(showBottomDivider: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                layout.spacing(24),
                layout.spacing(20),
                layout.spacing(24),
                layout.spacing(16),
              ),
              child: Column(
                children: [
                  _StatusHero(
                    layout: layout,
                    isValid: result.isValid,
                    title: result.isValid
                        ? l10n.staffScanResultValidTitle
                        : l10n.staffScanResultUsedTitle,
                    subtitle: result.isValid
                        ? l10n.staffScanResultValidSubtitle
                        : l10n.staffScanResultUsedSubtitle,
                  ),
                  SizedBox(height: layout.spacing(24)),
                  _InfoCard(
                    layout: layout,
                    result: result,
                  ),
                  SizedBox(height: layout.spacing(20)),
                  if (result.isValid)
                    _NoticeBox(
                      layout: layout,
                      backgroundColor: _noticeCream,
                      borderColor: const Color(0xFFFDE6B0),
                      icon: Icons.info_outline_rounded,
                      title: l10n.staffScanResultRememberTitle,
                      body: result.isEntryScan
                          ? l10n.staffScanResultEntryRememberMessage
                          : l10n.staffScanResultRememberMessage,
                    )
                  else
                    _LastUseNotice(
                      layout: layout,
                      title: l10n.staffScanResultLastSuccessfulUse,
                      timeLabel: result.lastUsedTimeLabel ?? '--:--',
                      dateLabel: result.lastUsedDateLabel ?? '',
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              layout.spacing(24),
              layout.spacing(8),
              layout.spacing(24),
              layout.spacing(24),
            ),
            child: SafeArea(
              top: false,
              child: result.isValid
                  ? _PrimaryActionButton(
                      layout: layout,
                      label: result.isEntryScan
                          ? l10n.staffScanResultConfirmAccessButton
                          : l10n.staffScanResultDeliverButton,
                      icon: result.isEntryScan
                          ? Icons.confirmation_number_outlined
                          : Icons.local_drink_outlined,
                      onPressed: () => Navigator.of(context).pop(true),
                    )
                  : _PrimaryActionButton(
                      layout: layout,
                      label: l10n.staffScanResultBackButton,
                      icon: Icons.chevron_left_rounded,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusHero extends StatelessWidget {
  const _StatusHero({
    required this.layout,
    required this.isValid,
    required this.title,
    required this.subtitle,
  });

  final ResponsiveLayout layout;
  final bool isValid;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final color =
        isValid ? StaffQrScanResultScreen._successGreen : StaffQrScanResultScreen._errorRed;
    final softColor = isValid
        ? StaffQrScanResultScreen._successGreenSoft
        : StaffQrScanResultScreen._errorRedSoft;

    return Column(
      children: [
        Container(
          width: layout.spacing(88),
          height: layout.spacing(88),
          decoration: BoxDecoration(
            color: softColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isValid ? Icons.check_rounded : Icons.close_rounded,
            color: color,
            size: layout.spacing(44),
          ),
        ),
        SizedBox(height: layout.spacing(18)),
        AppText(
          title,
          variant: AppTextVariant.headline,
          textAlign: TextAlign.center,
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(30),
          letterSpacing: 0.5,
        ),
        SizedBox(height: layout.spacing(10)),
        AppText(
          subtitle,
          variant: AppTextVariant.body,
          textAlign: TextAlign.center,
          color: const Color(0xFF374151),
          fontSize: layout.fontSize(14),
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.layout,
    required this.result,
  });

  final ResponsiveLayout layout;
  final StaffQrScanResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(18)),
        border: Border.all(color: AppColors.homeDividerGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: layout.spacing(12),
            offset: Offset(0, layout.spacing(4)),
          ),
        ],
      ),
      child: Column(
        children: [
          if (result.isValid)
            _InfoRow(
              layout: layout,
              icon: result.isEntryScan
                  ? Icons.confirmation_number_outlined
                  : Icons.local_drink_outlined,
              title: result.productName,
              subtitle: result.isEntryScan
                  ? null
                  : l10n.staffScanResultUnitCount(result.productQuantity),
            )
          else
            _InfoRow(
              layout: layout,
              icon: result.isEntryScan
                  ? Icons.confirmation_number_outlined
                  : Icons.local_drink_outlined,
              label: result.isEntryScan
                  ? l10n.staffScanResultTicketLabel
                  : l10n.staffScanResultProductLabel,
              value: result.productName,
            ),
          _InfoDivider(layout: layout),
          _InfoRow(
            layout: layout,
            icon: Icons.person_outline_rounded,
            label: l10n.staffScanResultUserLabel,
            value: result.guestName,
          ),
          _InfoDivider(layout: layout),
          _InfoRow(
            layout: layout,
            icon: Icons.schedule_rounded,
            label: result.isValid
                ? l10n.staffScanResultTimeLabel
                : l10n.staffScanResultAttemptTimeLabel,
            value: result.scanTimeLabel,
          ),
          if (result.isValid && result.barName != null) ...[
            _InfoDivider(layout: layout),
            _InfoRow(
              layout: layout,
              icon: Icons.local_bar_outlined,
              label: l10n.staffScanResultBarLabel,
              value: result.barName!,
            ),
          ],
          _InfoDivider(layout: layout),
          _InfoRow(
            layout: layout,
            icon: Icons.tag_rounded,
            label: l10n.staffScanResultTransactionIdLabel,
            value: result.transactionId,
            useHashIcon: true,
          ),
        ],
      ),
    );
  }
}

class _InfoDivider extends StatelessWidget {
  const _InfoDivider({required this.layout});

  final ResponsiveLayout layout;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.homeDividerGrey,
      indent: layout.spacing(68),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.layout,
    required this.icon,
    this.label,
    this.value,
    this.title,
    this.subtitle,
    this.useHashIcon = false,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final String? label;
  final String? value;
  final String? title;
  final String? subtitle;
  final bool useHashIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: layout.spacing(16),
        vertical: layout.spacing(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: layout.spacing(40),
            height: layout.spacing(40),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8EB),
              shape: BoxShape.circle,
            ),
            child: useHashIcon
                ? Center(
                    child: Text(
                      '#',
                      style: TextStyle(
                        color: staffScanAccent,
                        fontSize: layout.fontSize(18),
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  )
                : Icon(
                    icon,
                    color: staffScanAccent,
                    size: layout.spacing(20),
                  ),
          ),
          SizedBox(width: layout.spacing(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  AppText(
                    title!,
                    variant: AppTextVariant.listTitle,
                    color: AppColors.homeBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: layout.fontSize(16),
                  )
                else ...[
                  AppText(
                    label!,
                    variant: AppTextVariant.label,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(12),
                  ),
                  SizedBox(height: layout.spacing(3)),
                  AppText(
                    value!,
                    variant: AppTextVariant.bodyEmphasis,
                    color: AppColors.homeBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: layout.fontSize(16),
                  ),
                ],
                if (subtitle != null) ...[
                  SizedBox(height: layout.spacing(3)),
                  AppText(
                    subtitle!,
                    variant: AppTextVariant.body,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(13),
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

class _NoticeBox extends StatelessWidget {
  const _NoticeBox({
    required this.layout,
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    required this.title,
    required this.body,
  });

  final ResponsiveLayout layout;
  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(layout.spacing(16)),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(layout.radius(14)),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: layout.spacing(28),
            height: layout.spacing(28),
            decoration: BoxDecoration(
              color: staffScanAccent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: staffScanAccent,
              size: layout.spacing(16),
            ),
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
                SizedBox(height: layout.spacing(4)),
                AppText(
                  body,
                  variant: AppTextVariant.body,
                  color: const Color(0xFF374151),
                  fontSize: layout.fontSize(13),
                  height: 1.4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LastUseNotice extends StatelessWidget {
  const _LastUseNotice({
    required this.layout,
    required this.title,
    required this.timeLabel,
    required this.dateLabel,
  });

  final ResponsiveLayout layout;
  final String title;
  final String timeLabel;
  final String dateLabel;

  static const _bodyGrey = Color(0xFF374151);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(layout.spacing(16)),
      decoration: BoxDecoration(
        color: StaffQrScanResultScreen._noticeRedBg,
        borderRadius: BorderRadius.circular(layout.radius(14)),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: layout.spacing(28),
            height: layout.spacing(28),
            decoration: const BoxDecoration(
              color: StaffQrScanResultScreen._errorRed,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.priority_high_rounded,
              color: AppColors.backgroundWhite,
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
                  variant: AppTextVariant.body,
                  color: _bodyGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: layout.fontSize(13),
                ),
                SizedBox(height: layout.spacing(4)),
                AppText(
                  timeLabel,
                  variant: AppTextVariant.headline,
                  color: StaffQrScanResultScreen._errorRed,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(30),
                  height: 1.1,
                ),
                if (dateLabel.isNotEmpty) ...[
                  SizedBox(height: layout.spacing(4)),
                  AppText(
                    dateLabel,
                    variant: AppTextVariant.body,
                    color: _bodyGrey,
                    fontSize: layout.fontSize(13),
                    fontWeight: FontWeight.w500,
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

class _PrimaryActionButton extends StatelessWidget {
  const _PrimaryActionButton({
    required this.layout,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final ResponsiveLayout layout;
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: layout.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
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
            Icon(icon, size: layout.spacing(20)),
            SizedBox(width: layout.spacing(10)),
            AppText(
              label,
              variant: AppTextVariant.button,
              color: AppColors.backgroundWhite,
              fontWeight: FontWeight.w700,
              fontSize: layout.fontSize(14),
              letterSpacing: 0.8,
            ),
          ],
        ),
      ),
    );
  }
}
