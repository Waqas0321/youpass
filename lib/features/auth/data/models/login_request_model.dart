class LoginRequestModel {
  const LoginRequestModel({
    required this.phone,
    required this.countryIsoCode,
    required this.code,
  });

  final String phone;
  final String countryIsoCode;
  final String code;

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'country_code': countryIsoCode,
      'code': code,
    };
  }
}
