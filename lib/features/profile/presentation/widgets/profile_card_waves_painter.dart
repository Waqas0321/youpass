import 'package:flutter/material.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

/// Soft gold wave bands in the profile summary card (top-right), per mockup.
class ProfileCardWavesPainter extends CustomPainter {
  ProfileCardWavesPainter({List<Color>? waveBands})
      : _waveBands = waveBands ??
            const [
              ProfileDesignSpec.cardWave1,
              ProfileDesignSpec.cardWave2,
              ProfileDesignSpec.cardWave3,
              ProfileDesignSpec.cardWave4,
            ];

  final List<Color> _waveBands;

  @override
  void paint(Canvas canvas, Size size) {
    for (var index = 0; index < _waveBands.length; index++) {
      _drawBand(
        canvas,
        size,
        color: _waveBands[index],
        insetFromRight: index * 14.0,
        curveDepth: 34 + (index * 8),
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
      size.height * 0.52,
      startX - curveDepth * 0.22,
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
