import 'dart:math' as math;

import 'package:flutter/material.dart';

class VenueMapDashedBorderPainter extends CustomPainter {
  VenueMapDashedBorderPainter({
    required this.color,
    required this.radius,
    this.strokeWidth = 1,
  });

  final Color color;
  final double radius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    const dashWidth = 5.0;
    const dashSpace = 4.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        final extractPath = metric.extractPath(
          distance,
          next.clamp(0, metric.length),
        );
        canvas.drawPath(extractPath, paint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant VenueMapDashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}

class VenueMapHalftonePainter extends CustomPainter {
  VenueMapHalftonePainter({required this.dotColor});

  final Color dotColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = dotColor;
    const spacing = 7.0;
    const radius = 1.2;

    for (var y = 0.0; y < size.height; y += spacing) {
      for (var x = 0.0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant VenueMapHalftonePainter oldDelegate) {
    return oldDelegate.dotColor != dotColor;
  }
}

class VenueMapCrowdPainter extends CustomPainter {
  VenueMapCrowdPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final baseY = size.height * 0.55;
    final count = 18;
    final spacing = size.width / count;

    for (var index = 0; index < count; index++) {
      final centerX = spacing * index + spacing / 2;
      final wave = math.sin(index * 0.8) * 6;
      final headRadius = size.height * 0.09;
      final headCenter = Offset(centerX, baseY + wave);

      canvas.drawCircle(headCenter, headRadius, paint);

      final bodyPath = Path()
        ..moveTo(headCenter.dx - headRadius * 1.1, headCenter.dy + headRadius * 0.4)
        ..quadraticBezierTo(
          headCenter.dx - headRadius * 1.4,
          size.height,
          headCenter.dx - headRadius * 0.2,
          size.height,
        )
        ..lineTo(headCenter.dx + headRadius * 0.2, size.height)
        ..quadraticBezierTo(
          headCenter.dx + headRadius * 1.4,
          size.height,
          headCenter.dx + headRadius * 1.1,
          headCenter.dy + headRadius * 0.4,
        )
        ..close();

      canvas.drawPath(bodyPath, paint);

      if (index.isEven) {
        final armPaint = Paint()
          ..color = color
          ..strokeWidth = headRadius * 0.35
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(
          Offset(headCenter.dx - headRadius * 1.3, baseY - 4 + wave),
          Offset(headCenter.dx - headRadius * 2.0, baseY - 18 + wave),
          armPaint,
        );
        canvas.drawLine(
          Offset(headCenter.dx + headRadius * 1.3, baseY - 4 + wave),
          Offset(headCenter.dx + headRadius * 2.0, baseY - 18 + wave),
          armPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant VenueMapCrowdPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class YouFestBunnyLogoPainter extends CustomPainter {
  YouFestBunnyLogoPainter({this.color = const Color(0xFFFF007F)});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final stroke = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width * 0.07
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height * 0.58);
    final faceRadius = size.width * 0.28;

    canvas.drawCircle(center, faceRadius, paint);

    final earWidth = size.width * 0.11;
    final leftEar = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx - faceRadius * 0.55, center.dy - faceRadius * 1.05),
        width: earWidth,
        height: size.height * 0.34,
      ),
      Radius.circular(earWidth),
    );
    final rightEar = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx + faceRadius * 0.55, center.dy - faceRadius * 1.05),
        width: earWidth,
        height: size.height * 0.34,
      ),
      Radius.circular(earWidth),
    );
    canvas.drawRRect(leftEar, paint);
    canvas.drawRRect(rightEar, paint);

    final eyeOffset = faceRadius * 0.35;
    canvas.drawLine(
      Offset(center.dx - eyeOffset - faceRadius * 0.08, center.dy - faceRadius * 0.05),
      Offset(center.dx - eyeOffset + faceRadius * 0.08, center.dy + faceRadius * 0.05),
      stroke,
    );
    canvas.drawLine(
      Offset(center.dx - eyeOffset + faceRadius * 0.08, center.dy - faceRadius * 0.05),
      Offset(center.dx - eyeOffset - faceRadius * 0.08, center.dy + faceRadius * 0.05),
      stroke,
    );
    canvas.drawLine(
      Offset(center.dx + eyeOffset - faceRadius * 0.08, center.dy - faceRadius * 0.05),
      Offset(center.dx + eyeOffset + faceRadius * 0.08, center.dy + faceRadius * 0.05),
      stroke,
    );
    canvas.drawLine(
      Offset(center.dx + eyeOffset + faceRadius * 0.08, center.dy - faceRadius * 0.05),
      Offset(center.dx + eyeOffset - faceRadius * 0.08, center.dy + faceRadius * 0.05),
      stroke,
    );

    final heartPaint = Paint()..color = Colors.white;
    final heartCenter = Offset(center.dx, center.dy + faceRadius * 0.28);
    final heartSize = faceRadius * 0.22;
    final heartPath = Path()
      ..moveTo(heartCenter.dx, heartCenter.dy + heartSize * 0.8)
      ..cubicTo(
        heartCenter.dx - heartSize * 1.4,
        heartCenter.dy - heartSize * 0.2,
        heartCenter.dx - heartSize * 0.5,
        heartCenter.dy - heartSize * 1.2,
        heartCenter.dx,
        heartCenter.dy - heartSize * 0.45,
      )
      ..cubicTo(
        heartCenter.dx + heartSize * 0.5,
        heartCenter.dy - heartSize * 1.2,
        heartCenter.dx + heartSize * 1.4,
        heartCenter.dy - heartSize * 0.2,
        heartCenter.dx,
        heartCenter.dy + heartSize * 0.8,
      );
    canvas.drawPath(heartPath, heartPaint);
  }

  @override
  bool shouldRepaint(covariant YouFestBunnyLogoPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
