import 'package:intl/intl.dart';

class ProducerCalendarTimeFormatter {
  ProducerCalendarTimeFormatter._();

  static String displayDate({
    required String localeName,
    required String fallbackLabel,
    DateTime? startsAt,
  }) {
    if (startsAt == null) {
      return fallbackLabel;
    }

    try {
      final local = startsAt.toLocal();
      final weekday = DateFormat('EEE', localeName).format(local);
      final day = DateFormat('d', localeName).format(local);
      final month = DateFormat('MMM', localeName).format(local);
      final year = DateFormat('y', localeName).format(local);
      return '$weekday $day $month $year';
    } catch (_) {
      return DateFormat.yMMMEd(localeName).format(startsAt.toLocal());
    }
  }

  static String? displayTime({
    required String localeName,
    DateTime? startsAt,
  }) {
    if (startsAt == null) {
      return null;
    }

    try {
      final formatted = DateFormat.Hm(localeName).format(startsAt.toLocal());
      return '$formatted hrs';
    } catch (_) {
      return null;
    }
  }
}
