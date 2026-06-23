import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_list_tab.dart';
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
      eventTypeSlug: 'parties',
      type: 'guaranteed',
      productKind: 'guaranteed_pass',
      requiresPaymentMethod: true,
      status: InvitationStatus.sent,
    ),
    InvitationEntity(
      id: '2',
      eventTitle: 'Concierto X',
      locationLabel: 'Arena',
      dateTimeLabel: 'May 15',
      imageAssetPath: '',
      tier: InvitationTier.general,
      eventTypeSlug: 'concerts',
      type: 'free',
      productKind: 'free',
      status: InvitationStatus.sent,
    ),
    InvitationEntity(
      id: '3',
      eventTitle: 'VIP Table Night',
      locationLabel: 'Santiago',
      dateTimeLabel: 'Aug 1',
      imageAssetPath: '',
      tier: InvitationTier.vip,
      eventTypeSlug: 'parties',
      type: 'vip_table',
      productKind: 'free',
      assignedSlot: 'VIP Table 1',
      status: InvitationStatus.accepted,
    ),
    InvitationEntity(
      id: '4',
      eventTitle: 'Rejected Event',
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
      selectedTab: InvitationListTab.pending,
      selectedEventTypeSlug: null,
      searchQuery: '',
    );

    expect(result.length, 2);
  });

  test('filterInvitations matches parties event type', () {
    final result = InvitationsFilterHelper.filterInvitations(
      invitations: invitations,
      selectedTab: InvitationListTab.pending,
      selectedEventTypeSlug: 'parties',
      searchQuery: '',
    );

    expect(result.length, 1);
    expect(result.first.id, '1');
  });

  test('filterInvitations matches concerts event type', () {
    final result = InvitationsFilterHelper.filterInvitations(
      invitations: invitations,
      selectedTab: InvitationListTab.pending,
      selectedEventTypeSlug: 'concerts',
      searchQuery: '',
    );

    expect(result.length, 1);
    expect(result.first.id, '2');
  });

  test('filterInvitations matches confirmed tab with event type', () {
    final result = InvitationsFilterHelper.filterInvitations(
      invitations: invitations,
      selectedTab: InvitationListTab.confirmed,
      selectedEventTypeSlug: 'parties',
      searchQuery: '',
    );

    expect(result.length, 1);
    expect(result.first.id, '3');
  });

  test('filterInvitations matches search query', () {
    final result = InvitationsFilterHelper.filterInvitations(
      invitations: invitations,
      selectedTab: InvitationListTab.pending,
      selectedEventTypeSlug: null,
      searchQuery: 'youfest',
    );

    expect(result.length, 1);
    expect(result.first.eventTitle, 'YouFest 2026');
  });
}
