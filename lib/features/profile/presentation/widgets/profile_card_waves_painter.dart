import 'package:flutter/material.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

/// Subtle cream waves inside the profile summary card (top-right).
class ProfileCardWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bands = [
      ProfileDesignSpec.cardWave1,
      ProfileDesignSpec.cardWave2,
      ProfileDesignSpec.cardWave3,
    ];

    for (var index = 0; index < bands.length; index++) {
      _drawBand(
        canvas,
        size,
        color: bands[index],
        insetFromRight: index * 16.0,
        curveDepth: 30 + (index * 6),
      );
    }
  }

  void _drawBand(
    Canvas canvas,
    Size size, {
    required Color color,
    required double insetFromRight,
    required double curveDepth,
  }) {
    final path = Path();
    final startX = size.width - insetFromRight;

    path.moveTo(size.width, 0);
    path.lineTo(startX, 0);
    path.cubicTo(
      startX - curveDepth,
      size.height * 0.25,
      startX - curveDepth * 0.5,
      size.height * 0.55,
      startX - curveDepth * 0.2,
      size.height,
    );
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
