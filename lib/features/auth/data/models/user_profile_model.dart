import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/data/models/profile_completeness_model.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.id,
    required super.phone,
    required super.phoneDisplay,
    required super.countryCode,
    required super.fullName,
    required super.email,
    required super.birthdate,
    required super.gender,
    required super.rutOrPassport,
    required super.category,
    required super.accountStatus,
    required super.createdAt,
    required super.profileCompleteness,
    super.instagramUsername,
    super.profilePhotoUrl,
    super.preferredLanguage,
    super.pendingDeletion,
    super.deletionScheduledAt,
    super.daysRemaining,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final data = _resolvePayload(json);
    final completenessJson = data['profile_completeness'];
    final createdAt =
        JsonReaders.dateTime(data, 'created_at') ??
        JsonReaders.dateTime(data, 'createdAt') ??
        DateTime.now();
    final phone = JsonReaders.string(data, 'phone');
    final phoneDisplay = JsonReaders.string(
      data,
      'phone_display',
      fallback: phone,
    );

    return UserProfileModel(
      id: JsonReaders.readId(data),
      phone: phone,
      phoneDisplay: phoneDisplay,
      countryCode: JsonReaders.string(
        data,
        'country_code',
        fallback: JsonReaders.string(data, 'countryCode'),
      ),
      fullName: JsonReaders.string(
        data,
        'full_name',
        fallback: JsonReaders.string(data, 'fullName'),
      ),
      email: JsonReaders.string(data, 'email'),
      birthdate: JsonReaders.dateOnlyString(
        data,
        'birthdate',
        altKeys: const ['birth_date', 'date_of_birth'],
      ),
      gender: JsonReaders.normalizedGender(data, 'gender'),
      rutOrPassport: JsonReaders.string(
        data,
        'rut_or_passport',
        fallback: JsonReaders.string(data, 'document_id'),
      ),
      instagramUsername: JsonReaders.nullableStringWithAlt(
        data,
        'instagram_username',
        altKeys: const ['instagram', 'instagramUsername'],
      ),
      profilePhotoUrl: JsonReaders.nullableStringWithAlt(
        data,
        'profile_photo_url',
        altKeys: const ['profilePhotoUrl', 'avatar_url'],
      ),
      preferredLanguage: JsonReaders.nullableStringWithAlt(
        data,
        'preferred_language',
        altKeys: const ['preferredLanguage'],
      ),
      category: JsonReaders.string(data, 'category', fallback: 'bronze'),
      accountStatus: JsonReaders.string(data, 'account_status', fallback: 'active'),
      createdAt: createdAt,
      pendingDeletion: JsonReaders.boolean(data, 'pending_deletion'),
      deletionScheduledAt: JsonReaders.dateTime(data, 'deletion_scheduled_at'),
      daysRemaining: JsonReaders.boolean(data, 'pending_deletion')
          ? JsonReaders.integer(data, 'days_remaining')
          : null,
      profileCompleteness: completenessJson is Map<String, dynamic>
          ? ProfileCompletenessModel.fromJson(completenessJson)
          : const ProfileCompletenessModel(
              hasPhoto: false,
              hasInstagram: false,
              completionPercentage: 0,
              missingFields: [],
            ),
    );
  }

  /// Builds a profile snapshot from registration data when `/users/me` is delayed.
  factory UserProfileModel.fromRegisterRequest({
    required UserModel user,
    required RegisterRequestEntity request,
    String? phone,
    String? phoneDisplay,
  }) {
    final instagram = request.instagram.trim();
    final normalizedInstagram =
        instagram.isEmpty ? null : instagram.replaceFirst(RegExp(r'^@+'), '');

    return UserProfileModel(
      id: user.id,
      phone: phone ?? '',
      phoneDisplay: phoneDisplay ?? phone ?? '',
      countryCode: request.countryIsoCode,
      fullName: request.fullName,
      email: request.email,
      birthdate: request.birthDate,
      gender: request.gender,
      rutOrPassport: request.documentId,
      instagramUsername: normalizedInstagram,
      category: 'bronze',
      accountStatus: 'active',
      createdAt: DateTime.now(),
      profileCompleteness: ProfileCompletenessModel(
        hasPhoto: false,
        hasInstagram: normalizedInstagram != null,
        completionPercentage: normalizedInstagram != null ? 80 : 70,
        missingFields: normalizedInstagram != null
            ? const ['profile_photo']
            : const ['profile_photo', 'instagram_username'],
      ),
    );
  }

  static Map<String, dynamic> _resolvePayload(Map<String, dynamic> json) {
    final user = json['user'];
    if (user is Map<String, dynamic>) {
      return user;
    }

    final profile = json['profile'];
    if (profile is Map<String, dynamic>) {
      return profile;
    }

    return json;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'phone_display': phoneDisplay,
      'country_code': countryCode,
      'full_name': fullName,
      'email': email,
      'birthdate': birthdate,
      'gender': gender,
      'rut_or_passport': rutOrPassport,
      'instagram_username': instagramUsername,
      'profile_photo_url': profilePhotoUrl,
      'category': category,
      'account_status': accountStatus,
      'pending_deletion': pendingDeletion,
      if (deletionScheduledAt != null)
        'deletion_scheduled_at': deletionScheduledAt!.toIso8601String(),
      if (daysRemaining != null) 'days_remaining': daysRemaining,
      'created_at': createdAt.toIso8601String(),
      'profile_completeness': {
        'has_photo': profileCompleteness.hasPhoto,
        'has_instagram': profileCompleteness.hasInstagram,
        'completion_percentage': profileCompleteness.completionPercentage,
        'missing_fields': profileCompleteness.missingFields,
      },
    };
  }

  UserModel toUserModel() {
    return UserModel.fromEntity(toUserEntity());
  }
}
