import 'package:equatable/equatable.dart';

class RegisterRequestEntity extends Equatable {
  const RegisterRequestEntity({
    required this.phone,
    required this.countryIsoCode,
    required this.code,
    required this.fullName,
    required this.documentId,
    required this.birthDate,
    required this.gender,
    required this.email,
    this.instagram = '',
    this.acceptTerms = true,
    this.preferredLanguage,
  });

  final String phone;
  final String countryIsoCode;
  final String code;
  final String fullName;
  final String documentId;
  final String birthDate;
  /// API value: male | female | other | prefer_not_to_say
  final String gender;
  final String email;
  final String instagram;
  final bool acceptTerms;
  final String? preferredLanguage;

  @override
  List<Object?> get props => [
        phone,
        countryIsoCode,
        code,
        fullName,
        documentId,
        birthDate,
        gender,
        email,
        instagram,
        acceptTerms,
        preferredLanguage,
      ];
}
