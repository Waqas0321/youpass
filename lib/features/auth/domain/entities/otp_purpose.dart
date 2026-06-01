enum OtpPurpose {
  register,
  login,
  changePhone,
  deleteAccount,
}

extension OtpPurposeParsing on OtpPurpose {
  static OtpPurpose fromApiValue(String? value) {
    switch (value) {
      case 'register':
        return OtpPurpose.register;
      case 'change_phone':
        return OtpPurpose.changePhone;
      case 'delete_account':
        return OtpPurpose.deleteAccount;
      case 'login':
      default:
        return OtpPurpose.login;
    }
  }
}

extension OtpPurposeApiValue on OtpPurpose {
  String get apiValue {
    switch (this) {
      case OtpPurpose.register:
        return 'register';
      case OtpPurpose.login:
        return 'login';
      case OtpPurpose.changePhone:
        return 'change_phone';
      case OtpPurpose.deleteAccount:
        return 'delete_account';
    }
  }
}
