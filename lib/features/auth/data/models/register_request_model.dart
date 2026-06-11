import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';

class RegisterRequestModel {
  const RegisterRequestModel({
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
  final String gender;
  final String email;
  final String instagram;
  final bool acceptTerms;
  final String? preferredLanguage;

  factory RegisterRequestModel.fromEntity(RegisterRequestEntity entity) {
    return RegisterRequestModel(
      phone: entity.phone,
      countryIsoCode: entity.countryIsoCode,
      code: entity.code,
      fullName: entity.fullName,
      documentId: entity.documentId,
      birthDate: entity.birthDate,
      gender: entity.gender,
      email: entity.email,
      instagram: entity.instagram,
      acceptTerms: entity.acceptTerms,
      preferredLanguage: entity.preferredLanguage,
    );
  }

  Map<String, dynamic> toJson() {
    final body = <String, dynamic>{
      'phone': phone,
      'country_code': countryIsoCode,
      'code': code,
      'full_name': fullName,
      'rut_or_passport': documentId,
      'email': email,
      'birthdate': birthDate,
      'gender': gender,
      'accept_terms': acceptTerms,
    };

    final instagramUsername = instagram.trim();
    if (instagramUsername.isNotEmpty) {
      body['instagram_username'] = instagramUsername;
    }

    final preferredLanguageValue = preferredLanguage?.trim();
    if (preferredLanguageValue != null && preferredLanguageValue.isNotEmpty) {
      body['preferred_language'] = preferredLanguageValue;
    }

    return body;
  }
}
