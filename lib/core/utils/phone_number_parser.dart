class PhoneNumberParser {
  static String digitsOnly(String value) {
    return value.replaceAll(RegExp(r'\D'), '');
  }

  static String nationalNumber(String value) {
    final digits = digitsOnly(value);
    if (digits.length <= 9) {
      return digits;
    }

    return digits.substring(digits.length - 9);
  }
}
