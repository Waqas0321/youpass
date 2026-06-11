import 'package:equatable/equatable.dart';
import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';

class PhoneMigrationSummaryEntity extends Equatable {
  const PhoneMigrationSummaryEntity({
    this.invitationsUpdated = 0,
    this.slotsUpdated = 0,
    this.linkedInvitations = 0,
  });

  final int invitationsUpdated;
  final int slotsUpdated;
  final int linkedInvitations;

  @override
  List<Object?> get props => [
        invitationsUpdated,
        slotsUpdated,
        linkedInvitations,
      ];
}

class ChangePhoneResultEntity extends Equatable {
  const ChangePhoneResultEntity({
    required this.profile,
    required this.message,
    this.migration,
  });

  final UserProfileEntity profile;
  final String message;
  final PhoneMigrationSummaryEntity? migration;

  @override
  List<Object?> get props => [profile, message, migration];
}
