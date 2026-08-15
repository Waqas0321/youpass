class StaffLookupResponse {
  const StaffLookupResponse({
    required this.isStaff,
    required this.phone,
    this.fullName,
  });

  final bool isStaff;
  final String phone;
  final String? fullName;

  factory StaffLookupResponse.fromJson(Map<String, dynamic> json) {
    return StaffLookupResponse(
      isStaff: json['is_staff'] == true,
      phone: (json['phone'] ?? '').toString(),
      fullName: json['full_name']?.toString(),
    );
  }
}
