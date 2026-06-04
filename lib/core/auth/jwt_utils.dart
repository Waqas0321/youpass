import 'dart:convert';

/// Lightweight JWT helpers (decode only — no signature verification).
class JwtUtils {
  JwtUtils._();

  static bool isExpired(String token, {DateTime? now}) {
    final exp = readExpiry(token);
    if (exp == null) {
      return false;
    }

    final clock = now ?? DateTime.now();
    return !clock.isBefore(exp);
  }

  static DateTime? readExpiry(String token) {
    final payload = decodePayload(token);
    if (payload == null) {
      return null;
    }

    final exp = payload['exp'];
    if (exp is int) {
      return DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true).toLocal();
    }
    if (exp is num) {
      return DateTime.fromMillisecondsSinceEpoch(exp.toInt() * 1000, isUtc: true)
          .toLocal();
    }

    return null;
  }

  static Map<String, dynamic>? decodePayload(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }

    try {
      final normalized = base64Url.normalize(parts[1]);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final json = jsonDecode(decoded);
      if (json is Map<String, dynamic>) {
        return json;
      }
    } catch (_) {
      return null;
    }

    return null;
  }

  static String? readSessionId(String token) {
    final payload = decodePayload(token);
    if (payload == null) {
      return null;
    }

    for (final key in ['session_id', 'sessionId', 'sid', 'session']) {
      final value = payload[key];
      if (value == null) {
        continue;
      }
      final normalized = value.toString().trim();
      if (normalized.isNotEmpty) {
        return normalized;
      }
    }

    return null;
  }
}
