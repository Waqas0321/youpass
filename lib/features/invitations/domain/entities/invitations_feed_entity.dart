import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/waitlist/domain/entities/waitlist_entry_entity.dart';

class InvitationsFeedEntity {
  const InvitationsFeedEntity({
    required this.invitations,
    required this.waitlistEntries,
  });

  final List<InvitationEntity> invitations;
  final List<WaitlistEntryEntity> waitlistEntries;
}
