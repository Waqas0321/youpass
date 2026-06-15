import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';

/// Helpers for Section 14.7 invitation status values.
extension InvitationStatusX on InvitationStatus {
  bool get isPending =>
      this == InvitationStatus.sent ||
      this == InvitationStatus.viewed ||
      this == InvitationStatus.pending;

  bool get isAccepted =>
      this == InvitationStatus.accepted ||
      this == InvitationStatus.confirmed;

  bool get isActive =>
      isPending || isAccepted || this == InvitationStatus.validated;
}

bool invitationStatusIsPending(InvitationStatus status) => status.isPending;

bool invitationStatusIsAccepted(InvitationStatus status) => status.isAccepted;
