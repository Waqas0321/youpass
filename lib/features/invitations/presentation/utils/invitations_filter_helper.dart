import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_list_tab.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';

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

  static bool matchesEventTypeFilter(
    InvitationEntity invitation,
    String? eventTypeSlug,
  ) {
    if (eventTypeSlug == null || eventTypeSlug.isEmpty) {
      return true;
    }

    return invitation.eventTypeSlug == eventTypeSlug;
  }

  static List<InvitationEntity> filterInvitations({
    required List<InvitationEntity> invitations,
    required InvitationListTab selectedTab,
    required String? selectedEventTypeSlug,
    required String searchQuery,
  }) {
    final query = searchQuery.trim().toLowerCase();

    return invitations.where((invitation) {
      if (!matchesTab(invitation, selectedTab)) {
        return false;
      }

      if (!matchesEventTypeFilter(invitation, selectedEventTypeSlug)) {
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
