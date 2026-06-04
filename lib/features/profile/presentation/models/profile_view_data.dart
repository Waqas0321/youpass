class ProfileViewData {
  const ProfileViewData({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.instagramHandle,
    this.profilePhotoUrl,
  });

  final String fullName;
  final String phone;
  final String email;
  final String birthDate;
  final String gender;
  final String instagramHandle;
  final String? profilePhotoUrl;
}
