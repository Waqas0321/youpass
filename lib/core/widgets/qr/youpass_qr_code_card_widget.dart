import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:youpass/core/theme/qr_screen_theme.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

/// Bordered QR card with manual entry code, matching ticket / purchase mockups.
class YouPassQrCodeCardWidget extends StatelessWidget {
  const YouPassQrCodeCardWidget({
    super.key,
    required this.qrPayload,
    required this.entryCode,
    required this.manualIdLabel,
  });

  final String qrPayload;
  final String entryCode;
  final String manualIdLabel;

  @override
  Widget build(BuildContext context) {
    final borderRadius = InvitationsDesignSpec.px(context, 14);
    final qrSize = InvitationsDesignSpec.px(context, 200);
    final padding = InvitationsDesignSpec.px(context, 18);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: QrScreenTheme.qrCardBackground(context),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: QrScreenTheme.qrCardBorder(context),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          QrImageView(
            data: qrPayload,
            version: QrVersions.auto,
            size: qrSize,
            backgroundColor: QrScreenTheme.qrModuleBackground(context),
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: QrScreenTheme.qrModuleForeground(context),
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: QrScreenTheme.qrModuleForeground(context),
            ),
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 16)),
          Divider(
            height: 1,
            thickness: 1,
            color: QrScreenTheme.qrDivider(context),
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 14)),
          Text(
            manualIdLabel,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: InvitationsDesignSpec.px(context, 13),
              color: QrScreenTheme.manualIdLabel(context),
            ),
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 6)),
          Text(
            entryCode,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: InvitationsDesignSpec.px(context, 24),
              fontWeight: FontWeight.w700,
              color: QrScreenTheme.manualIdValue(context),
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
