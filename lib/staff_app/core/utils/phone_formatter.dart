class PhoneFormatter {
  static String formatDisplay(String countryCode, String phoneDigits) {
    final digits = phoneDigits.replaceAll(RegExp(r'\D'), '');
    if (digits.length >= 9) {
      return '+$countryCode ${digits[0]} ${digits.substring(1, 5)} ${digits.substring(5)}';
    }
    if (digits.length >= 5) {
      return '+$countryCode ${digits[0]} ${digits.substring(1)}';
    }
    return '+$countryCode $digits';
  }

  static String digitsOnly(String value) {
    return value.replaceAll(RegExp(r'\D'), '');
  }
}
