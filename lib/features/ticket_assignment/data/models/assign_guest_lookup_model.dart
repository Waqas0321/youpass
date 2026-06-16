import 'package:youpass/features/ticket_assignment/domain/entities/assign_guest_lookup_entity.dart';

class AssignGuestLookupModel extends AssignGuestLookupEntity {
  const AssignGuestLookupModel({
    required super.userId,
    required super.fullName,
    required super.phone,
    required super.phoneDisplay,
    required super.countryCode,
    super.profilePhotoUrl,
    super.isRegistered = true,
  });

  factory AssignGuestLookupModel.fromJson(Map<String, dynamic> json) {
    return AssignGuestLookupModel(
      userId: json['user_id']?.toString() ?? json['userId']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? json['fullName']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      phoneDisplay:
          json['phone_display']?.toString() ?? json['phoneDisplay']?.toString() ?? '',
      countryCode:
          json['country_code']?.toString() ?? json['countryCode']?.toString() ?? '',
      profilePhotoUrl:
          json['profile_photo_url']?.toString() ?? json['profilePhotoUrl']?.toString(),
      isRegistered: json['is_registered'] == true || json['isRegistered'] == true,
    );
  }
}

class AssignGuestLookupListModel {
  const AssignGuestLookupListModel({required this.results});

  final List<AssignGuestLookupModel> results;

  factory AssignGuestLookupListModel.fromJson(Map<String, dynamic> json) {
    final raw = json['results'];
    final results = raw is List
        ? raw
            .whereType<Map<String, dynamic>>()
            .map(AssignGuestLookupModel.fromJson)
            .toList()
        : const <AssignGuestLookupModel>[];

    return AssignGuestLookupListModel(results: results);
  }
}
