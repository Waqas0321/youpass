class ChangePhoneRequestModel {
  const ChangePhoneRequestModel({
    required this.newPhone,
    required this.newCountryCode,
  });

  final String newPhone;
  final String newCountryCode;

  Map<String, dynamic> toJson() {
    return {
      'new_phone': newPhone,
      'new_country_code': newCountryCode,
    };
  }
}

class ChangePhoneVerifyRequestModel {
  const ChangePhoneVerifyRequestModel({
    required this.newPhone,
    required this.newCountryCode,
    required this.code,
  });

  final String newPhone;
  final String newCountryCode;
  final String code;

  Map<String, dynamic> toJson() {
    return {
      'new_phone': newPhone,
      'new_country_code': newCountryCode,
      'code': code,
    };
  }
}
