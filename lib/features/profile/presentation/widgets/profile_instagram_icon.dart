import 'package:flutter/material.dart';

class ProfileInstagramIcon extends StatelessWidget {
  const ProfileInstagramIcon({
    super.key,
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _ProfileInstagramIconPainter(color: color),
    );
  }
}

class _ProfileInstagramIconPainter extends CustomPainter {
  _ProfileInstagramIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.08,
        size.height * 0.08,
        size.width * 0.84,
        size.height * 0.84,
      ),
      Radius.circular(size.width * 0.22),
    );

    canvas.drawRRect(rect, paint);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.18,
      paint,
    );

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.74, size.height * 0.26),
      size.width * 0.05,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProfileInstagramIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
