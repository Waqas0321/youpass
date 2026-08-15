import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';

/// QR viewfinder icon matching real YouPass ticket / drink QR styling.
class StaffQrViewfinderIcon extends StatelessWidget {
  const StaffQrViewfinderIcon({
    super.key,
    this.size,
    this.color = AppColors.backgroundWhite,
    this.data,
    this.qrFillRatio = StaffQrViewfinderIcon.defaultQrFillRatio,
  });

  final double? size;
  final Color color;
  final double qrFillRatio;

  /// Optional payload; defaults to a representative drink-order QR shape.
  final String? data;

  /// Shared sizing for bar + access-validator home cards.
  static const defaultQrFillRatio = 0.66;
  static const homeCardViewfinderSpacing = 140.0;

  static double homeCardViewfinderSize(ResponsiveLayout layout) {
    return layout.spacing(homeCardViewfinderSpacing);
  }

  /// Sample payload shaped like production ticket QR codes (decorative only).
  static const sampleQrPayload =
      'cm5demo000000000000000000.clxevent000000000000000000.a1b2c3d4e5';

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final iconSize = size ?? homeCardViewfinderSize(layout);
    final qrSize = iconSize * qrFillRatio;
    final moduleStyle = QrDataModuleStyle(
      dataModuleShape: QrDataModuleShape.square,
      color: color,
    );
    final eyeStyle = QrEyeStyle(
      eyeShape: QrEyeShape.square,
      color: color,
    );

    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: CustomPaint(
        painter: _ViewfinderPainter(
          color: color,
          strokeWidth: iconSize * 0.038,
        ),
        child: Center(
          child: QrImageView(
            data: data ?? sampleQrPayload,
            size: qrSize,
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            gapless: true,
            semanticsLabel: 'QR code',
            eyeStyle: eyeStyle,
            dataModuleStyle: moduleStyle,
          ),
        ),
      ),
    );
  }
}

class _ViewfinderPainter extends CustomPainter {
  _ViewfinderPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final corner = size.width * 0.2;
    final inset = size.width * 0.04;

    void drawCorner({
      required Offset start,
      required Offset cornerPoint,
      required Offset end,
    }) {
      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..lineTo(cornerPoint.dx, cornerPoint.dy)
        ..lineTo(end.dx, end.dy);
      canvas.drawPath(path, paint);
    }

    drawCorner(
      start: Offset(inset, inset + corner),
      cornerPoint: Offset(inset, inset),
      end: Offset(inset + corner, inset),
    );
    drawCorner(
      start: Offset(size.width - inset - corner, inset),
      cornerPoint: Offset(size.width - inset, inset),
      end: Offset(size.width - inset, inset + corner),
    );
    drawCorner(
      start: Offset(size.width - inset, size.height - inset - corner),
      cornerPoint: Offset(size.width - inset, size.height - inset),
      end: Offset(size.width - inset - corner, size.height - inset),
    );
    drawCorner(
      start: Offset(inset + corner, size.height - inset),
      cornerPoint: Offset(inset, size.height - inset),
      end: Offset(inset, size.height - inset - corner),
    );
  }

  @override
  bool shouldRepaint(covariant _ViewfinderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
