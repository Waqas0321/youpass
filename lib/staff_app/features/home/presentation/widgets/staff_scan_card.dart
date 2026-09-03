import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_qr_viewfinder_icon.dart';

class StaffScanCard extends StatelessWidget {
  const StaffScanCard({
    super.key,
    this.onScanTap,
    this.onManualEntryTap,
    this.onSupervisorModeTap,
    // Kept for compatibility; Manual Entry is always available to regular staff.
    this.showManualEntry = true,
    this.showSupervisorMode = false,
  });

  final Future<void> Function()? onScanTap;
  final VoidCallback? onManualEntryTap;
  final VoidCallback? onSupervisorModeTap;
  final bool showManualEntry;
  final bool showSupervisorMode;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);
    final radius = layout.radius(28);
    final viewfinderSize = StaffQrViewfinderIcon.homeCardViewfinderSize(layout);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primaryMustard,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(
        padding: EdgeInsets.all(layout.spacing(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onScanTap?.call(),
                borderRadius: BorderRadius.circular(radius - layout.spacing(8)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: layout.spacing(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StaffQrViewfinderIcon(size: viewfinderSize),
                      SizedBox(height: layout.spacing(18)),
                      AppText(
                        l10n.staffScanConsumptionTitle,
                        variant: AppTextVariant.headline,
                        textAlign: TextAlign.center,
                        color: AppColors.homeBlack,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                        fontSize: layout.fontSize(22),
                      ),
                      SizedBox(height: layout.spacing(8)),
                      AppText(
                        l10n.staffScanQrSubtitle,
                        variant: AppTextVariant.body,
                        textAlign: TextAlign.center,
                        color: AppColors.homeBlack.withValues(alpha: 0.88),
                        fontWeight: FontWeight.w500,
                        fontSize: layout.fontSize(15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (showManualEntry) ...[
              SizedBox(height: layout.spacing(10)),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onManualEntryTap,
                  borderRadius: BorderRadius.circular(layout.spacing(28)),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: layout.spacing(20),
                      vertical: layout.spacing(14),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite.withValues(alpha: 0.24),
                      borderRadius: BorderRadius.circular(layout.spacing(28)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.keyboard_outlined,
                          size: layout.spacing(18),
                          color: AppColors.backgroundWhite,
                        ),
                        SizedBox(width: layout.spacing(8)),
                        AppText(
                          l10n.staffManualEntryButton,
                          variant: AppTextVariant.button,
                          color: AppColors.backgroundWhite,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          fontSize: layout.fontSize(14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            if (showSupervisorMode) ...[
              SizedBox(height: layout.spacing(10)),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onSupervisorModeTap,
                  borderRadius: BorderRadius.circular(layout.spacing(28)),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: layout.spacing(20),
                      vertical: layout.spacing(14),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.homeBlack.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(layout.spacing(28)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: layout.spacing(18),
                          color: AppColors.backgroundWhite,
                        ),
                        SizedBox(width: layout.spacing(8)),
                        AppText(
                          l10n.staffSupervisorModeButton,
                          variant: AppTextVariant.button,
                          color: AppColors.backgroundWhite,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          fontSize: layout.fontSize(14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
