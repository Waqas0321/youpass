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
}
