import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationCardEventImageWidget extends StatelessWidget {
  const InvitationCardEventImageWidget({
    super.key,
    required this.invitation,
  });

  final InvitationEntity invitation;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(
      InvitationsDesignSpec.px(
        context,
        InvitationsDesignSpec.imageRadius,
      ),
    );

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox.expand(
        child: EventNetworkImage(
          imageUrl: invitation.usesNetworkImage ? invitation.imageAssetPath : null,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
