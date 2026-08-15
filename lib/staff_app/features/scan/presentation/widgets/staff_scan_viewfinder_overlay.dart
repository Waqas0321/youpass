import 'package:flutter/material.dart';

/// Scan accent from the QR scanner mockup (~#E6B048).
const Color staffScanAccent = Color(0xFFE6B048);

/// Shared scan-frame geometry so overlay + labels align with the mockup.
class StaffScanLayoutMetrics {
  StaffScanLayoutMetrics({
    required Size viewportSize,
    required double screenWidth,
  }) {
    scanWindowSize = screenWidth * 0.72;

    const flashBlockHeight = 52.0;
    const gapAfterFlash = 10.0;
    const gapAfterFrame = 20.0;
    const bottomBlockHeight = 88.0;

    final totalBlockHeight =
        flashBlockHeight + gapAfterFlash + scanWindowSize + gapAfterFrame + bottomBlockHeight;

    final blockTop = (viewportSize.height - totalBlockHeight) / 2;

    flashTop = blockTop;
    final windowTop = blockTop + flashBlockHeight + gapAfterFlash;
    bottomContentTop = windowTop + scanWindowSize + gapAfterFrame;

    windowCenter = Offset(viewportSize.width / 2, windowTop + scanWindowSize / 2);
    windowRect = Rect.fromLTWH(
      (viewportSize.width - scanWindowSize) / 2,
      windowTop,
      scanWindowSize,
      scanWindowSize,
    );
  }

  late final double scanWindowSize;
  late final double flashTop;
  late final double bottomContentTop;
  late final Offset windowCenter;
  late final Rect windowRect;
}

class StaffScanViewfinderOverlay extends StatelessWidget {
  const StaffScanViewfinderOverlay({
    super.key,
    this.metrics,
    this.windowRect,
    this.cornerColor = staffScanAccent,
  }) : assert(
          metrics != null || windowRect != null,
          'Provide metrics or windowRect',
        );

  final StaffScanLayoutMetrics? metrics;
  final Rect? windowRect;
  final Color cornerColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ScanOverlayPainter(
        windowRect: windowRect ?? metrics!.windowRect,
        cornerColor: cornerColor,
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _ScanOverlayPainter extends CustomPainter {
  _ScanOverlayPainter({
    required this.windowRect,
    required this.cornerColor,
  });

  final Rect windowRect;
  final Color cornerColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.black.withValues(alpha: 0.42),
    );
    canvas.drawRect(
      windowRect,
      Paint()..blendMode = BlendMode.clear,
    );
    canvas.restore();

    final cornerLength = windowRect.width * 0.18;
    final strokeWidth = windowRect.width * 0.036;

    final left = windowRect.left;
    final right = windowRect.right;
    final top = windowRect.top;
    final bottom = windowRect.bottom;

    final edgePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.42)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(left + cornerLength, top),
      Offset(right - cornerLength, top),
      edgePaint,
    );
    canvas.drawLine(
      Offset(left + cornerLength, bottom),
      Offset(right - cornerLength, bottom),
      edgePaint,
    );
    canvas.drawLine(
      Offset(left, top + cornerLength),
      Offset(left, bottom - cornerLength),
      edgePaint,
    );
    canvas.drawLine(
      Offset(right, top + cornerLength),
      Offset(right, bottom - cornerLength),
      edgePaint,
    );

    void drawCornerPath(Path path) {
      final glowPaint = Paint()
        ..color = cornerColor.withValues(alpha: 0.65)
        ..strokeWidth = strokeWidth * 2.8
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);

      final cornerPaint = Paint()
        ..color = cornerColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      canvas.drawPath(path, glowPaint);
      canvas.drawPath(path, cornerPaint);
    }

    drawCornerPath(
      Path()
        ..moveTo(left, top + cornerLength)
        ..lineTo(left, top)
        ..lineTo(left + cornerLength, top),
    );
    drawCornerPath(
      Path()
        ..moveTo(right - cornerLength, top)
        ..lineTo(right, top)
        ..lineTo(right, top + cornerLength),
    );
    drawCornerPath(
      Path()
        ..moveTo(right, bottom - cornerLength)
        ..lineTo(right, bottom)
        ..lineTo(right - cornerLength, bottom),
    );
    drawCornerPath(
      Path()
        ..moveTo(left + cornerLength, bottom)
        ..lineTo(left, bottom)
        ..lineTo(left, bottom - cornerLength),
    );
  }

  @override
  bool shouldRepaint(covariant _ScanOverlayPainter oldDelegate) {
    return oldDelegate.windowRect != windowRect ||
        oldDelegate.cornerColor != cornerColor;
  }
}
