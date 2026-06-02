import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_filter.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';

class InvitationsFilterHelper {
  InvitationsFilterHelper._();

  static List<InvitationEntity> filterInvitations({
    required List<InvitationEntity> invitations,
    required InvitationFilter selectedFilter,
    required String searchQuery,
  }) {
    final query = searchQuery.trim().toLowerCase();

    return invitations.where((invitation) {
      if (invitation.status == InvitationStatus.rejected) {
        return false;
      }

      final matchesFilter = switch (selectedFilter) {
        InvitationFilter.all => true,
        InvitationFilter.general => invitation.tier == InvitationTier.general,
        InvitationFilter.vip => invitation.tier == InvitationTier.vip,
      };

      final matchesSearch = query.isEmpty ||
          invitation.eventTitle.toLowerCase().contains(query) ||
          invitation.locationLabel.toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
    }).toList();
  }
}
