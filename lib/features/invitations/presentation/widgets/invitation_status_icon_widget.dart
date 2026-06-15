import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/widgets/bold_check_painter.dart';

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

    if (status.isAccepted) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: InvitationsScreenTheme.confirmedStatusIconBackground(context),
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: CustomPaint(
          size: Size.square(InvitationsDesignSpec.px(context, 14)),
          painter: BoldCheckPainter(
            color: InvitationsDesignSpec.confirmedStatusIcon,
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: InvitationsScreenTheme.pendingStatusIconBackground(context),
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
