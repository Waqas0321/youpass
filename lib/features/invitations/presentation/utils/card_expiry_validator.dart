/// Card expiry helpers for MM/YY input.
class CardExpiryValidator {
  const CardExpiryValidator._();

  /// Returns null when [expiry] is a valid current-or-future MM/YY date.
  static String? validate(String expiry) {
    final match = RegExp(r'^(\d{2})/(\d{2})$').firstMatch(expiry.trim());
    if (match == null) {
      return 'Use MM/YY format';
    }

    final month = int.tryParse(match.group(1)!);
    final yearShort = int.tryParse(match.group(2)!);
    if (month == null || yearShort == null || month < 1 || month > 12) {
      return 'Enter a valid expiry month';
    }

    final year = 2000 + yearShort;
    final now = DateTime.now();
    if (year < now.year || (year == now.year && month < now.month)) {
      return 'Expiry date must be current or future';
    }

    return null;
  }
}
