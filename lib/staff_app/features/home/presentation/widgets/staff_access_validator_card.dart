import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_qr_viewfinder_icon.dart';

class StaffAccessValidatorCard extends StatelessWidget {
  const StaffAccessValidatorCard({
    super.key,
    this.onScanTap,
    this.onManualEntryTap,
    this.showManualEntry = true,
  });

  final VoidCallback? onScanTap;
  final VoidCallback? onManualEntryTap;
  final bool showManualEntry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Column(
      children: [
        Container(
          width: layout.spacing(72),
          height: layout.spacing(72),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8EB),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFDE6B0)),
          ),
          child: Icon(
            Icons.verified_user_outlined,
            color: AppColors.primaryMustard,
            size: layout.spacing(36),
          ),
        ),
        SizedBox(height: layout.spacing(18)),
        AppText(
          l10n.staffAccessValidatorTitle,
          variant: AppTextVariant.headline,
          textAlign: TextAlign.center,
          color: AppColors.homeBlack,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(22),
          letterSpacing: 0.4,
        ),
        SizedBox(height: layout.spacing(10)),
        AppText(
          l10n.staffAccessValidatorSubtitle,
          variant: AppTextVariant.body,
          textAlign: TextAlign.center,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(14),
          fontWeight: FontWeight.w500,
          height: 1.45,
        ),
        SizedBox(height: layout.spacing(24)),
        Material(
          color: AppColors.primaryMustard,
          borderRadius: BorderRadius.circular(layout.radius(20)),
          child: InkWell(
            onTap: onScanTap,
            borderRadius: BorderRadius.circular(layout.radius(20)),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: layout.spacing(24),
                vertical: layout.spacing(28),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StaffQrViewfinderIcon(
                    size: StaffQrViewfinderIcon.homeCardViewfinderSize(layout),
                    color: AppColors.backgroundWhite,
                  ),
                  SizedBox(height: layout.spacing(14)),
                  AppText(
                    l10n.staffScanEntryButton,
                    variant: AppTextVariant.button,
                    textAlign: TextAlign.center,
                    color: AppColors.backgroundWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: layout.fontSize(15),
                    letterSpacing: 0.8,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showManualEntry) ...[
        SizedBox(height: layout.spacing(12)),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onManualEntryTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryMustard,
              backgroundColor: AppColors.backgroundWhite,
              side: BorderSide(color: AppColors.primaryMustard, width: 1.5),
              padding: EdgeInsets.symmetric(vertical: layout.spacing(16)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(layout.radius(18)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.keyboard_outlined, size: layout.spacing(20)),
                SizedBox(width: layout.spacing(10)),
                AppText(
                  l10n.staffManualEntryButton,
                  variant: AppTextVariant.button,
                  color: AppColors.primaryMustard,
                  fontWeight: FontWeight.w700,
                  fontSize: layout.fontSize(14),
                  letterSpacing: 0.6,
                ),
              ],
            ),
          ),
        ),
        ],
      ],
    );
  }
}
