import 'package:equatable/equatable.dart';

class AssignGuestLookupEntity extends Equatable {
  const AssignGuestLookupEntity({
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.phoneDisplay,
    required this.countryCode,
    this.profilePhotoUrl,
    this.isRegistered = true,
  });

  final String userId;
  final String fullName;
  final String phone;
  final String phoneDisplay;
  final String countryCode;
  final String? profilePhotoUrl;
  final bool isRegistered;

  @override
  List<Object?> get props => [
        userId,
        fullName,
        phone,
        phoneDisplay,
        countryCode,
        profilePhotoUrl,
        isRegistered,
      ];
}
