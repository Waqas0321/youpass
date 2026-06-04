import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationStatusIconWidget extends StatelessWidget {
  const InvitationStatusIconWidget({
    super.key,
    required this.status,
  });

  final InvitationStatus status;

  @override
  Widget build(BuildContext context) {
    final size = InvitationsDesignSpec.px(context, 28);
    final radius = InvitationsDesignSpec.px(context, 6);

    if (status == InvitationStatus.confirmed) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: InvitationsDesignSpec.confirmedStatusIconBackground,
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: CustomPaint(
          size: Size.square(InvitationsDesignSpec.px(context, 14)),
          painter: _BoldCheckPainter(
            color: InvitationsDesignSpec.confirmedStatusIcon,
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: InvitationsDesignSpec.pendingStatusIconBackground,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(
        Icons.hourglass_empty_rounded,
        size: InvitationsDesignSpec.px(context, 16),
        color: InvitationsDesignSpec.pendingStatusIcon,
      ),
    );
  }
}

class _BoldCheckPainter extends CustomPainter {
  const _BoldCheckPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width * 0.18
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.54)
      ..lineTo(size.width * 0.42, size.height * 0.78)
      ..lineTo(size.width * 0.82, size.height * 0.28);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BoldCheckPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
