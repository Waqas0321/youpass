import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/auth/domain/entities/change_phone_result_entity.dart';

class ChangePhoneResultModel extends ChangePhoneResultEntity {
  const ChangePhoneResultModel({
    required super.profile,
    required super.message,
    super.migration,
  });

  factory ChangePhoneResultModel.fromJson(Map<String, dynamic> json) {
    final migrationRaw = json['migration'];
    PhoneMigrationSummaryEntity? migration;
    if (migrationRaw is Map<String, dynamic>) {
      migration = PhoneMigrationSummaryEntity(
        invitationsUpdated: JsonReaders.integer(
          migrationRaw,
          'invitations_updated',
        ),
        slotsUpdated: JsonReaders.integer(migrationRaw, 'slots_updated'),
        linkedInvitations: JsonReaders.integer(
          migrationRaw,
          'linked_invitations',
        ),
      );
    }

    final profileRaw = json['user'] ?? json['profile'] ?? json;

    return ChangePhoneResultModel(
      profile: profileRaw is Map<String, dynamic>
          ? UserProfileModel.fromJson(profileRaw)
          : UserProfileModel.fromJson(const {}),
      message: JsonReaders.string(json, 'message'),
      migration: migration,
    );
  }
}
