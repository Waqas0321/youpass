import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/invitations/data/models/invitation_model.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';

void main() {
  test('InvitationModel parses invited_by and expiry fields from API payload', () {
    final model = InvitationModel.fromJson({
      'id': 'inv-1',
      'event_title': 'YouFest 2026',
      'location': 'Santiago',
      'date_time_label': 'Jul 4',
      'image_url': 'https://example.com/event.jpg',
      'tier': 'vip',
      'status': 'pending',
      'expires_at_label': 'Sun 15 Jun, 11:59 pm',
      'invited_by': {
        'name': 'Tebo Events',
        'role': 'producer',
      },
    });

    expect(model.id, 'inv-1');
    expect(model.tier, InvitationTier.vip);
    expect(model.status, InvitationStatus.pending);
    expect(model.expiresAtLabel, 'Sun 15 Jun, 11:59 pm');
    expect(model.invitedBy?.name, 'Tebo Events');
    expect(model.invitedBy?.role, 'producer');
  });
}
