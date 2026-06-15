import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_filter.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_list_tab.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_product_kind.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_product_kind_resolver.dart';

class InvitationsFilterHelper {
  InvitationsFilterHelper._();

  static bool isHiddenFromLists(InvitationEntity invitation) {
    return invitation.status == InvitationStatus.rejected ||
        invitation.status == InvitationStatus.expired ||
        invitation.status == InvitationStatus.canceled;
  }

  static bool matchesTab(InvitationEntity invitation, InvitationListTab tab) {
    if (isHiddenFromLists(invitation)) {
      return false;
    }

    return switch (tab) {
      InvitationListTab.pending => invitation.status.isPending,
      InvitationListTab.confirmed => invitation.status.isAccepted,
    };
  }

  static bool matchesTierFilter(InvitationEntity invitation, InvitationFilter filter) {
    final kind = InvitationsProductKindResolver.resolve(invitation);
    final type = invitation.type?.toLowerCase();

    return switch (filter) {
      InvitationFilter.all => true,
      InvitationFilter.courtesies => kind == InvitationProductKind.guaranteedPass,
      InvitationFilter.general =>
        invitation.tier == InvitationTier.general && kind != InvitationProductKind.guaranteedPass,
      InvitationFilter.vip =>
        invitation.tier == InvitationTier.vip &&
            kind != InvitationProductKind.guaranteedPass &&
            type != 'vip_table' &&
            !_isTableInvitation(invitation),
      InvitationFilter.tables => _isTableInvitation(invitation),
    };
  }

  static bool _isTableInvitation(InvitationEntity invitation) {
    final type = invitation.type?.toLowerCase();
    if (type == 'vip_table') {
      return true;
    }
    if (invitation.tier != InvitationTier.vip) {
      return false;
    }
    final slot = invitation.assignedSlot?.toLowerCase() ?? '';
    return slot.contains('table') || slot.contains('mesa');
  }

  static List<InvitationEntity> filterInvitations({
    required List<InvitationEntity> invitations,
    required InvitationListTab selectedTab,
    required InvitationFilter selectedFilter,
    required String searchQuery,
  }) {
    final query = searchQuery.trim().toLowerCase();

    return invitations.where((invitation) {
      if (!matchesTab(invitation, selectedTab)) {
        return false;
      }

      if (!matchesTierFilter(invitation, selectedFilter)) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      return invitation.eventTitle.toLowerCase().contains(query) ||
          invitation.locationLabel.toLowerCase().contains(query) ||
          (invitation.invitedBy?.name.toLowerCase().contains(query) ?? false) ||
          (invitation.productLabel?.toLowerCase().contains(query) ?? false);
    }).toList();
  }
}
