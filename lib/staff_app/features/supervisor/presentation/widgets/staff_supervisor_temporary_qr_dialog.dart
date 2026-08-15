import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_manual_validation_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';
import 'package:youpass/l10n/app_localizations.dart';

class StaffSupervisorTemporaryQrDialog extends StatelessWidget {
  const StaffSupervisorTemporaryQrDialog({
    super.key,
    required this.temporaryQr,
    required this.l10n,
  });

  final StaffSupervisorTemporaryQr temporaryQr;
  final AppLocalizations l10n;

  static Future<void> show(
    BuildContext context, {
    required StaffSupervisorTemporaryQr temporaryQr,
    required AppLocalizations l10n,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => StaffSupervisorTemporaryQrDialog(
        temporaryQr: temporaryQr,
        l10n: l10n,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final qrSize = layout.spacing(220);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: layout.spacing(20)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(layout.radius(20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(layout.spacing(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              l10n.staffSupervisorTemporaryQrDialogTitle,
              variant: AppTextVariant.title,
              color: AppColors.homeBlack,
              fontWeight: FontWeight.w800,
              fontSize: layout.fontSize(18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: layout.spacing(8)),
            AppText(
              l10n.staffSupervisorTemporaryQrDialogSubtitle(
                temporaryQr.validityMinutes,
              ),
              variant: AppTextVariant.body,
              color: AppColors.secondaryGrey,
              fontSize: layout.fontSize(13),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: layout.spacing(8)),
            AppText(
              l10n.staffSupervisorTemporaryQrDialogGuest(temporaryQr.guestName),
              variant: AppTextVariant.bodyEmphasis,
              color: StaffSupervisorDesign.accent,
              fontWeight: FontWeight.w700,
              fontSize: layout.fontSize(14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: layout.spacing(18)),
            Container(
              padding: EdgeInsets.all(layout.spacing(16)),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(layout.radius(16)),
                border: Border.all(color: AppColors.homeDividerGrey),
              ),
              child: QrImageView(
                data: temporaryQr.qrPayload,
                size: qrSize,
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.backgroundWhite,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: AppColors.homeBlack,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: AppColors.homeBlack,
                ),
              ),
            ),
            SizedBox(height: layout.spacing(12)),
            AppText(
              temporaryQr.entryCode,
              variant: AppTextVariant.bodyEmphasis,
              color: AppColors.homeBlack,
              fontWeight: FontWeight.w800,
              fontSize: layout.fontSize(16),
              letterSpacing: 1.2,
            ),
            SizedBox(height: layout.spacing(20)),
            SizedBox(
              width: double.infinity,
              height: layout.buttonHeight,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: StaffSupervisorDesign.accent,
                  foregroundColor: AppColors.backgroundWhite,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(layout.radius(14)),
                  ),
                ),
                child: AppText(
                  l10n.staffSupervisorTemporaryQrDialogClose,
                  variant: AppTextVariant.button,
                  color: AppColors.backgroundWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
