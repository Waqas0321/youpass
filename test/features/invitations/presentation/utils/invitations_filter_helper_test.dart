import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_filter.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_filter_helper.dart';

void main() {
  const invitations = [
    InvitationEntity(
      id: '1',
      eventTitle: 'YouFest 2026',
      locationLabel: 'Santiago',
      dateTimeLabel: 'Jul 4',
      imageAssetPath: '',
      tier: InvitationTier.vip,
      status: InvitationStatus.pending,
    ),
    InvitationEntity(
      id: '2',
      eventTitle: 'Concierto X',
      locationLabel: 'Arena',
      dateTimeLabel: 'May 15',
      imageAssetPath: '',
      tier: InvitationTier.general,
      status: InvitationStatus.rejected,
    ),
  ];

  test('filterInvitations hides rejected invitations', () {
    final result = InvitationsFilterHelper.filterInvitations(
      invitations: invitations,
      selectedFilter: InvitationFilter.all,
      searchQuery: '',
    );

    expect(result.length, 1);
    expect(result.first.id, '1');
  });

  test('filterInvitations matches vip tier', () {
    final result = InvitationsFilterHelper.filterInvitations(
      invitations: invitations,
      selectedFilter: InvitationFilter.vip,
      searchQuery: '',
    );

    expect(result.length, 1);
    expect(result.first.tier, InvitationTier.vip);
  });

  test('filterInvitations matches search query', () {
    final result = InvitationsFilterHelper.filterInvitations(
      invitations: invitations,
      selectedFilter: InvitationFilter.all,
      searchQuery: 'youfest',
    );

    expect(result.length, 1);
    expect(result.first.eventTitle, 'YouFest 2026');
  });
}
