import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationCardEventImageWidget extends StatelessWidget {
  const InvitationCardEventImageWidget({
    super.key,
    required this.invitation,
    required this.imageSize,
  });

  final InvitationEntity invitation;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(
      InvitationsDesignSpec.px(
        context,
        InvitationsDesignSpec.imageRadius,
      ),
    );

    if (invitation.usesNetworkImage) {
      return EventNetworkImage(
        imageUrl: invitation.imageAssetPath,
        width: imageSize,
        height: imageSize,
        borderRadius: borderRadius,
      );
    }

    return EventNetworkImage(
      width: imageSize,
      height: imageSize,
      borderRadius: borderRadius,
    );
  }
}
