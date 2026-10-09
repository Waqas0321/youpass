class RegisterDraft {
  const RegisterDraft({
    required this.fullName,
    required this.documentId,
    required this.birthDate,
    required this.gender,
    required this.email,
    this.acceptTerms = true,
  });

  final String fullName;
  final String documentId;
  final String birthDate;
  /// API value: male | female | other
  final String gender;
  final String email;
  final bool acceptTerms;
}
