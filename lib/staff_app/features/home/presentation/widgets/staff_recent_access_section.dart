import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_access_entry.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_scan_entry.dart';

class StaffRecentAccessSection extends StatelessWidget {
  const StaffRecentAccessSection({
    super.key,
    required this.scans,
    this.isLoading = false,
    this.emptyMessage,
    this.onViewAllTap,
    this.onScanTap,
  });

  final List<StaffScanEntry> scans;
  final bool isLoading;
  final String? emptyMessage;
  final VoidCallback? onViewAllTap;
  final ValueChanged<StaffScanEntry>? onScanTap;

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
                l10n.staffRecentAccessTitle,
                variant: AppTextVariant.sectionTitle,
                color: AppColors.homeBlack,
                fontWeight: FontWeight.w700,
                fontSize: layout.fontSize(18),
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
                l10n.staffViewAllAccess,
                variant: AppTextVariant.link,
                color: AppColors.primaryMustard,
                fontWeight: FontWeight.w600,
                fontSize: layout.fontSize(14),
              ),
            ),
          ],
        ),
        SizedBox(height: layout.spacing(12)),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(layout.radius(18)),
            border: Border.all(color: AppColors.homeDividerGrey),
          ),
          child: isLoading
              ? Padding(
                  padding: EdgeInsets.all(layout.spacing(24)),
                  child: Center(
                    child: SizedBox(
                      width: layout.spacing(24),
                      height: layout.spacing(24),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryMustard,
                      ),
                    ),
                  ),
                )
              : scans.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(layout.spacing(20)),
                      child: AppText(
                        emptyMessage ?? l10n.staffRecentAccessEmpty,
                        variant: AppTextVariant.body,
                        textAlign: TextAlign.center,
                        color: AppColors.secondaryGrey,
                        fontSize: layout.fontSize(14),
                        height: 1.4,
                      ),
                    )
                  : Column(
                      children: [
                        for (var index = 0; index < scans.length; index++) ...[
                          StaffRecentAccessTile(
                            entry: scans[index].toAccessEntry(),
                            onTap: onScanTap == null
                                ? null
                                : () => onScanTap!(scans[index]),
                          ),
                          if (index < scans.length - 1)
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: AppColors.homeDividerGrey,
                              indent: layout.spacing(60),
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

class StaffRecentAccessTile extends StatelessWidget {
  const StaffRecentAccessTile({
    super.key,
    required this.entry,
    this.onTap,
  });

  final StaffAccessEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);
    final isDuplicate = entry.status == StaffScanStatus.duplicate;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(18)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: layout.spacing(14),
            vertical: layout.spacing(13),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _StatusBadge(status: entry.status, layout: layout),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      isDuplicate
                          ? l10n.staffAccessDuplicateLabel
                          : entry.ticketLabel,
                      variant: AppTextVariant.listTitle,
                      color: AppColors.homeBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: layout.fontSize(15),
                    ),
                    SizedBox(height: layout.spacing(2)),
                    AppText(
                      entry.entryCode,
                      variant: AppTextVariant.body,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(13),
                    ),
                  ],
                ),
              ),
              AppText(
                entry.timeLabel,
                variant: AppTextVariant.listTrailing,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(13),
              ),
              if (onTap != null) ...[
                SizedBox(width: layout.spacing(4)),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.secondaryGrey,
                  size: layout.spacing(20),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.layout});

  final StaffScanStatus status;
  final ResponsiveLayout layout;

  @override
  Widget build(BuildContext context) {
    final isSuccess = status == StaffScanStatus.success;
    final color = isSuccess ? const Color(0xFF22C55E) : const Color(0xFFEF4444);

    return Container(
      width: layout.spacing(32),
      height: layout.spacing(32),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        isSuccess ? Icons.check_rounded : Icons.close_rounded,
        color: AppColors.backgroundWhite,
        size: layout.spacing(18),
      ),
    );
  }
}
