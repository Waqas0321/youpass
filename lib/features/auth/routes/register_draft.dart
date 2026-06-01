class RegisterDraft {
  const RegisterDraft({
    required this.fullName,
    required this.documentId,
    required this.birthDate,
    required this.gender,
    required this.email,
    required this.instagram,
    this.acceptTerms = true,
  });

  final String fullName;
  final String documentId;
  final String birthDate;
  /// API value: male | female | other | prefer_not_to_say
  final String gender;
  final String email;
  final String instagram;
  final bool acceptTerms;
}
