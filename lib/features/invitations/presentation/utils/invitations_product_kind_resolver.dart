import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_product_kind.dart';

class InvitationsProductKindResolver {
  InvitationsProductKindResolver._();

  static InvitationProductKind resolve(InvitationEntity invitation) {
    final fromApi = InvitationProductKindX.fromApi(invitation.productKind);
    if (fromApi != null) {
      return fromApi;
    }

    final type = invitation.type?.toLowerCase();
    if (type == 'discounted') {
      return InvitationProductKind.discounted;
    }
    if (type == 'courtesy' || invitation.requiresPaymentMethod) {
      return InvitationProductKind.guaranteedPass;
    }
    return InvitationProductKind.free;
  }

  static bool needsPaymentMethod(InvitationEntity invitation) {
    if (invitation.requiresPaymentMethod) {
      return true;
    }

    final kind = resolve(invitation);
    return kind == InvitationProductKind.guaranteedPass ||
        kind == InvitationProductKind.discounted;
  }
}
