class AssignGuestSelection {
  const AssignGuestSelection({
    required this.displayName,
    required this.phone,
    required this.countryCode,
    this.phoneDisplay,
    this.isRegistered = false,
  });

  final String displayName;
  final String phone;
  final String? phoneDisplay;
  final String countryCode;
  final bool isRegistered;
}
