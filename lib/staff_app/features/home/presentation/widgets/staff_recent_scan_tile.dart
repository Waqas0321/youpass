import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_scan_entry.dart';
import 'package:youpass/staff_app/features/home/presentation/utils/staff_scan_item_label.dart';

class StaffRecentScansSection extends StatelessWidget {
  const StaffRecentScansSection({
    super.key,
    required this.entries,
    this.isLoading = false,
    this.emptyMessage,
    this.onViewAllTap,
    this.onScanTap,
  });

  final List<StaffScanEntry> entries;
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
            Icon(
              Icons.schedule_rounded,
              size: layout.spacing(20),
              color: AppColors.primaryMustard,
            ),
            SizedBox(width: layout.spacing(8)),
            Expanded(
              child: AppText(
                l10n.staffRecentScansTitle,
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
                l10n.staffViewAllScans,
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
              : entries.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(layout.spacing(20)),
                      child: AppText(
                        emptyMessage ?? l10n.staffRecentScansEmpty,
                        variant: AppTextVariant.body,
                        textAlign: TextAlign.center,
                        color: AppColors.secondaryGrey,
                        fontSize: layout.fontSize(14),
                        height: 1.4,
                      ),
                    )
                  : Column(
                      children: [
                        for (var index = 0; index < entries.length; index++) ...[
                          StaffRecentScanTile(
                            entry: entries[index],
                            onTap: onScanTap == null
                                ? null
                                : () => onScanTap!(entries[index]),
                          ),
                          if (index < entries.length - 1)
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: AppColors.homeDividerGrey,
                              indent: layout.spacing(68),
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

class StaffRecentScanTile extends StatelessWidget {
  const StaffRecentScanTile({
    super.key,
    required this.entry,
    this.onTap,
  });

  final StaffScanEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

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
              Container(
                width: layout.spacing(44),
                height: layout.spacing(44),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.homeDividerGrey),
                ),
                child: Icon(
                  _iconFor(entry.icon),
                  color: AppColors.primaryMustard,
                  size: layout.spacing(22),
                ),
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      formatStaffScanItemLabel(l10n, entry.itemName),
                      variant: AppTextVariant.listTitle,
                      color: AppColors.homeBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: layout.fontSize(15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: layout.spacing(2)),
                    AppText(
                      entry.guestName,
                      variant: AppTextVariant.body,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(13),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppText(
                    entry.timeLabel,
                    variant: AppTextVariant.listTrailing,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(12),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                  ),
                  if (entry.status == StaffScanStatus.duplicate) ...[
                    SizedBox(height: layout.spacing(2)),
                    AppText(
                      l10n.staffScanDuplicateLabel,
                      variant: AppTextVariant.error,
                      fontSize: layout.fontSize(12),
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                  SizedBox(height: layout.spacing(4)),
                  _StatusBadge(status: entry.status, layout: layout),
                ],
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

  IconData _iconFor(StaffScanItemIcon icon) {
    switch (icon) {
      case StaffScanItemIcon.bottle:
        return Icons.local_bar_outlined;
      case StaffScanItemIcon.drink:
        return Icons.local_drink_outlined;
    }
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
      width: layout.spacing(28),
      height: layout.spacing(28),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        isSuccess ? Icons.check_rounded : Icons.close_rounded,
        color: AppColors.backgroundWhite,
        size: layout.spacing(16),
      ),
    );
  }
}
