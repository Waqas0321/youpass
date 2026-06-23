import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';

class VerifyCodeRequestModel {
  const VerifyCodeRequestModel({
    required this.phone,
    required this.countryIsoCode,
    required this.code,
    required this.purpose,
  });

  final String phone;
  final String countryIsoCode;
  final String code;
  final OtpPurpose purpose;

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'country_code': countryIsoCode,
      'code': code,
      'purpose': purpose.apiValue,
    };
  }
}
