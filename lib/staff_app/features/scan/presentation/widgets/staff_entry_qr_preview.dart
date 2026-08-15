import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';

/// White QR card shown beside guest details on entry scan result screens.
class StaffEntryQrPreview extends StatelessWidget {
  const StaffEntryQrPreview({
    super.key,
    required this.layout,
    required this.qrData,
    required this.entryId,
    required this.captionColor,
  });

  final ResponsiveLayout layout;
  final String qrData;
  final String entryId;
  final Color captionColor;

  @override
  Widget build(BuildContext context) {
    final qrSize = layout.spacing(72);

    return Container(
      width: layout.spacing(96),
      padding: EdgeInsets.fromLTRB(
        layout.spacing(8),
        layout.spacing(8),
        layout.spacing(8),
        layout.spacing(6),
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: layout.spacing(6),
            offset: Offset(0, layout.spacing(2)),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(
            data: qrData,
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
          SizedBox(height: layout.spacing(4)),
          Text(
            entryId,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: captionColor,
              fontSize: layout.fontSize(9),
              fontWeight: FontWeight.w700,
              height: 1.1,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
