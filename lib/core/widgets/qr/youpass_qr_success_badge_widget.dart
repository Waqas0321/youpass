import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:youpass/core/theme/qr_screen_theme.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

/// Success checkmark with optional burst lines for QR confirmation screens.
class YouPassQrSuccessBadgeWidget extends StatelessWidget {
  const YouPassQrSuccessBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final outerSize = InvitationsDesignSpec.px(context, 88);
    final innerSize = InvitationsDesignSpec.px(context, 64);
    final checkSize = InvitationsDesignSpec.px(context, 36);

    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!QrScreenTheme.isDark(context))
            CustomPaint(
              size: Size(outerSize, outerSize),
              painter: QrSuccessBurstPainter(
                primaryColor: QrScreenTheme.burstPrimary(context),
                secondaryColor: QrScreenTheme.burstSecondary(context),
              ),
            ),
          Container(
            width: innerSize,
            height: innerSize,
            decoration: BoxDecoration(
              color: QrScreenTheme.successIconBackground(context),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: QrScreenTheme.successCheckColor(context),
              size: checkSize,
            ),
          ),
        ],
      ),
    );
  }
}

class QrSuccessBurstPainter extends CustomPainter {
  const QrSuccessBurstPainter({
    required this.primaryColor,
    required this.secondaryColor,
  });

  final Color primaryColor;
  final Color secondaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;

    for (var index = 0; index < 12; index++) {
      final angle = (index / 12) * math.pi * 2;
      final color = index.isEven ? primaryColor : secondaryColor;
      final paint = Paint()
        ..color = color.withValues(alpha: index.isEven ? 0.85 : 0.65)
        ..strokeWidth = index.isEven ? 2.2 : 1.6
        ..strokeCap = StrokeCap.round;

      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant QrSuccessBurstPainter oldDelegate) {
    return oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor;
  }
}
