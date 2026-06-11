import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';

class OtpRequestModel {
  const OtpRequestModel({
    required this.phone,
    required this.countryIsoCode,
    required this.purpose,
  });

  final String phone;
  final String countryIsoCode;
  final OtpPurpose purpose;

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'country_code': countryIsoCode,
      'purpose': purpose.apiValue,
    };
  }
}
