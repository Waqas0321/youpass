import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_invited_by_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_text_factory.dart';
import 'package:youpass/l10n/app_localizations.dart';

void main() {
  test('InvitationsTextFactory formats invited-by and accept-by labels', () {
    final strings = lookupAppLocalizations(AppLocale.english);
    const invitation = InvitationEntity(
      id: 'inv-1',
      eventTitle: 'YouFest 2026',
      locationLabel: 'Santiago',
      dateTimeLabel: 'Jul 4',
      imageAssetPath: '',
      tier: InvitationTier.vip,
      status: InvitationStatus.pending,
      invitedBy: InvitationInvitedByEntity(
        name: 'Tebo Events',
        role: 'producer',
      ),
      expiresAtLabel: 'Sun 15 Jun, 11:59 pm',
    );

    expect(
      InvitationsTextFactory.invitedByLabel(strings, invitation),
      'Invited by Tebo Events',
    );
    expect(
      InvitationsTextFactory.acceptByLabel(strings, invitation),
      'Accept by Sun 15 Jun, 11:59 pm',
    );
  });

  test('InvitationsTextFactory maps courtesy vip to VIP DJ label', () {
    final strings = lookupAppLocalizations(AppLocale.english);
    const invitation = InvitationEntity(
      id: 'inv-1',
      eventTitle: 'YouFest 2026',
      locationLabel: 'Santiago',
      dateTimeLabel: 'Jul 4',
      imageAssetPath: '',
      tier: InvitationTier.vip,
      type: 'courtesy',
      status: InvitationStatus.pending,
    );

    expect(
      InvitationsTextFactory.tierLabel(strings, invitation),
      'VIP DJ',
    );
  });

  test('InvitationsTextFactory maps producer free invitations', () {
    final strings = lookupAppLocalizations(AppLocale.english);
    const invitation = InvitationEntity(
      id: 'inv-producer-free',
      eventTitle: 'Open Mic',
      locationLabel: 'Santiago',
      dateTimeLabel: 'Aug 15',
      imageAssetPath: '',
      tier: InvitationTier.general,
      status: InvitationStatus.pending,
      source: 'producer',
      productKind: 'free',
      productLabel: 'Free Invitation',
    );

    expect(
      InvitationsTextFactory.productLabelForInvitation(strings, invitation),
      'Free Invitation',
    );
  });

  test('InvitationsTextFactory maps guest assignment labels', () {
    final strings = lookupAppLocalizations(AppLocale.english);

    const vipAssigned = InvitationEntity(
      id: 'inv-vip',
      eventTitle: 'Sunset Sessions',
      locationLabel: 'Santiago',
      dateTimeLabel: 'Sep 12',
      imageAssetPath: '',
      tier: InvitationTier.vip,
      status: InvitationStatus.pending,
      source: 'guest',
      productKind: 'free',
      productLabel: 'VIP Invitation',
      chargeAmount: 120000,
    );

    const generalAssigned = InvitationEntity(
      id: 'inv-general',
      eventTitle: 'Sunset Sessions',
      locationLabel: 'Santiago',
      dateTimeLabel: 'Sep 12',
      imageAssetPath: '',
      tier: InvitationTier.general,
      status: InvitationStatus.pending,
      source: 'guest',
      productKind: 'free',
      productLabel: 'Invitation',
      chargeAmount: 25000,
    );

    expect(
      InvitationsTextFactory.productLabelForInvitation(strings, vipAssigned),
      'VIP Invitation',
    );
    expect(
      InvitationsTextFactory.productLabelForInvitation(strings, generalAssigned),
      'Invitation',
    );
  });

  test('InvitationsTextFactory maps zero-value free invitations', () {
    final strings = lookupAppLocalizations(AppLocale.english);
    const invitation = InvitationEntity(
      id: 'inv-free-guest',
      eventTitle: 'Community Open Mic Night',
      locationLabel: 'Santiago',
      dateTimeLabel: 'Aug 15',
      imageAssetPath: '',
      tier: InvitationTier.general,
      status: InvitationStatus.pending,
      source: 'guest',
      productKind: 'free',
      productLabel: 'Invitation',
      chargeAmount: 0,
    );

    expect(
      InvitationsTextFactory.productLabelForInvitation(strings, invitation),
      'Free Invitation',
    );
    expect(
      InvitationsTextFactory.tierLabel(strings, invitation),
      'Free',
    );
  });
}
