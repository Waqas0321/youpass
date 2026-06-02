import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/domain/entities/profile_completeness_entity.dart';

class ProfileCompletenessModel extends ProfileCompletenessEntity {
  const ProfileCompletenessModel({
    required super.hasPhoto,
    required super.hasInstagram,
    required super.completionPercentage,
    required super.missingFields,
  });

  factory ProfileCompletenessModel.fromJson(Map<String, dynamic> json) {
    return ProfileCompletenessModel(
      hasPhoto: JsonReaders.boolean(json, 'has_photo'),
      hasInstagram: JsonReaders.boolean(json, 'has_instagram'),
      completionPercentage: JsonReaders.integer(
        json,
        'completion_percentage',
      ),
      missingFields: JsonReaders.stringList(json, 'missing_fields'),
    );
  }
}
