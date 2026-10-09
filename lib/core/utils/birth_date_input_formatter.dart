import 'package:flutter/services.dart';

/// Formats digits as `DD/MM/YYYY` while the user types.
class BirthDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final clipped = digits.length > 8 ? digits.substring(0, 8) : digits;

    final buffer = StringBuffer();
    for (var i = 0; i < clipped.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write('/');
      }
      buffer.write(clipped[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Parses `DD/MM/YYYY` into a [DateTime] (local date at midnight).
DateTime? parseBirthDateDdMmYyyy(String raw) {
  final match = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').firstMatch(raw.trim());
  if (match == null) {
    return null;
  }

  final day = int.parse(match.group(1)!);
  final month = int.parse(match.group(2)!);
  final year = int.parse(match.group(3)!);

  if (month < 1 || month > 12 || day < 1 || day > 31) {
    return null;
  }

  final date = DateTime(year, month, day);
  if (date.year != year || date.month != month || date.day != day) {
    return null;
  }

  return date;
}

String formatBirthDateApiFromDdMmYyyy(String raw) {
  final date = parseBirthDateDdMmYyyy(raw);
  if (date == null) {
    return '';
  }

  final y = date.year.toString().padLeft(4, '0');
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}
