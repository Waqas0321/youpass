import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';

/// Shared route arguments for every invitation detail destination.
class InvitationDetailRouteArgs {
  const InvitationDetailRouteArgs({
    required this.invitationId,
    this.initialInvitation,
  });

  final String invitationId;
  final InvitationEntity? initialInvitation;

  /// Backward-compatible factory used by deep links and legacy call sites.
  factory InvitationDetailRouteArgs.legacy({
    required String invitationId,
    Object? invitation,
  }) {
    return InvitationDetailRouteArgs(
      invitationId: invitationId,
      initialInvitation:
          invitation is InvitationEntity ? invitation : null,
    );
  }
}

/// Legacy alias — keeps existing imports working while routes converge.
typedef GuaranteedPassDetailRouteArgs = InvitationDetailRouteArgs;
