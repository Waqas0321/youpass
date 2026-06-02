import 'package:equatable/equatable.dart';
import 'package:youpass/features/auth/domain/entities/profile_completeness_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';

class UserProfileEntity extends Equatable {
  const UserProfileEntity({
    required this.id,
    required this.phone,
    required this.phoneDisplay,
    required this.countryCode,
    required this.fullName,
    required this.email,
    required this.birthdate,
    required this.gender,
    required this.rutOrPassport,
    required this.category,
    required this.accountStatus,
    required this.createdAt,
    required this.profileCompleteness,
    this.instagramUsername,
    this.profilePhotoUrl,
  });

  final String id;
  final String phone;
  final String phoneDisplay;
  final String countryCode;
  final String fullName;
  final String email;
  final String birthdate;
  final String gender;
  final String rutOrPassport;
  final String? instagramUsername;
  final String? profilePhotoUrl;
  final String category;
  final String accountStatus;
  final DateTime createdAt;
  final ProfileCompletenessEntity profileCompleteness;

  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: fullName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        phone,
        phoneDisplay,
        countryCode,
        fullName,
        email,
        birthdate,
        gender,
        rutOrPassport,
        instagramUsername,
        profilePhotoUrl,
        category,
        accountStatus,
        createdAt,
        profileCompleteness,
      ];
}
