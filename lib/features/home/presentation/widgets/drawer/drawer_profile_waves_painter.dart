import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';

/// Thick wavy bands on the right of the drawer profile header (mockup).
class DrawerProfileWavesPainter extends CustomPainter {
  DrawerProfileWavesPainter({List<Color>? waveBands})
      : _waveBands = waveBands ??
            const [
              DrawerDesignSpec.profileWaveBand1,
              DrawerDesignSpec.profileWaveBand2,
              DrawerDesignSpec.profileWaveBand3,
              DrawerDesignSpec.profileWaveBand4,
            ];

  final List<Color> _waveBands;

  @override
  void paint(Canvas canvas, Size size) {
    for (var index = 0; index < _waveBands.length; index++) {
      _drawBand(
        canvas,
        size,
        color: _waveBands[index],
        insetFromRight: index * 18.0,
        curveDepth: 36 + (index * 8),
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
      size.height * 0.22,
      startX - curveDepth * 0.55,
      size.height * 0.55,
      startX - curveDepth * 0.25,
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
