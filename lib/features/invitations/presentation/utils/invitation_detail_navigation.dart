import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_product_kind.dart';
import 'package:youpass/features/invitations/presentation/routes/invitation_detail_route_args.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_product_kind_resolver.dart';
import 'package:youpass/routes/app_routes.dart';

/// Central place to resolve invitation detail navigation.
/// Add a new product kind here instead of scattering route switches in UI code.
class InvitationDetailNavigation {
  InvitationDetailNavigation._();

  static InvitationDetailDestination resolve(InvitationEntity invitation) {
    final kind = InvitationsProductKindResolver.resolve(invitation);
    final args = InvitationDetailRouteArgs(
      invitationId: invitation.id,
      initialInvitation: invitation,
    );

    return InvitationDetailDestination(
      route: _routeFor(kind),
      args: args,
      productKind: kind,
    );
  }

  static InvitationDetailDestination resolveById(String invitationId) {
    return InvitationDetailDestination(
      route: AppRoutes.invitationDetail,
      args: InvitationDetailRouteArgs(invitationId: invitationId),
      productKind: null,
    );
  }

  static String _routeFor(InvitationProductKind kind) {
    switch (kind) {
      case InvitationProductKind.guaranteedPass:
        // Dedicated path preserved for deep links; same screen handles all kinds.
        return AppRoutes.guaranteedPassDetail;
      case InvitationProductKind.free:
      case InvitationProductKind.discounted:
        return AppRoutes.invitationDetail;
    }
  }
}

class InvitationDetailDestination {
  const InvitationDetailDestination({
    required this.route,
    required this.args,
    required this.productKind,
  });

  final String route;
  final InvitationDetailRouteArgs args;
  final InvitationProductKind? productKind;
}
