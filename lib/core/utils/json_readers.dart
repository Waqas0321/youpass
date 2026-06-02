class JsonReaders {
  JsonReaders._();

  static String string(Map<String, dynamic> json, String key, {String fallback = ''}) {
    final value = json[key];
    if (value == null) {
      return fallback;
    }
    return value.toString();
  }

  static String? nullableString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) {
      return null;
    }
    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  static int integer(Map<String, dynamic> json, String key, {int fallback = 0}) {
    return integerValue(json[key], fallback: fallback);
  }

  static int integerValue(Object? value, {int fallback = 0}) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return fallback;
  }

  static bool boolean(Map<String, dynamic> json, String key, {bool fallback = false}) {
    final value = json[key];
    if (value is bool) {
      return value;
    }
    return fallback;
  }

  static List<String> stringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) {
      return const [];
    }

    return value.map((item) => item.toString()).toList();
  }

  static DateTime? dateTime(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) {
      return null;
    }

    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }

    if (value is Map<String, dynamic>) {
      final nested = value[r'$date'] ?? value['date'];
      if (nested != null) {
        return DateTime.tryParse(nested.toString());
      }
    }

    return null;
  }

  static String readId(Map<String, dynamic> json) {
    final id = json['id'];
    if (id != null && id.toString().isNotEmpty) {
      return id.toString();
    }

    final mongoId = json['_id'];
    if (mongoId is String && mongoId.isNotEmpty) {
      return mongoId;
    }

    if (mongoId is Map<String, dynamic>) {
      final oid = mongoId[r'$oid'];
      if (oid != null) {
        return oid.toString();
      }
    }

    return '';
  }

  /// Reads a calendar date as `YYYY-MM-DD` from ISO strings or Mongo date objects.
  static String dateOnlyString(
    Map<String, dynamic> json,
    String key, {
    List<String> altKeys = const [],
  }) {
    final keys = [key, ...altKeys];
    for (final entryKey in keys) {
      final value = json[entryKey];
      final normalized = _normalizeDateValue(value);
      if (normalized.isNotEmpty) {
        return normalized;
      }
    }

    return '';
  }

  static String normalizedGender(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) {
      return '';
    }

    return value.toString().trim().toLowerCase();
  }

  static String? nullableStringWithAlt(
    Map<String, dynamic> json,
    String key, {
    List<String> altKeys = const [],
  }) {
    final keys = [key, ...altKeys];
    for (final entryKey in keys) {
      final value = nullableString(json, entryKey);
      if (value != null) {
        return value;
      }
    }

    return null;
  }

  static String _normalizeDateValue(Object? value) {
    if (value == null) {
      return '';
    }

    if (value is String) {
      final trimmed = value.trim();
      if (trimmed.isEmpty) {
        return '';
      }

      final parsed = DateTime.tryParse(trimmed);
      if (parsed != null) {
        return _formatDateOnly(parsed.toLocal());
      }

      if (trimmed.length >= 10 && trimmed[4] == '-') {
        return trimmed.substring(0, 10);
      }

      return trimmed;
    }

    if (value is Map<String, dynamic>) {
      final nested = value[r'$date'] ?? value['date'];
      return _normalizeDateValue(nested);
    }

    return '';
  }

  static String _formatDateOnly(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
