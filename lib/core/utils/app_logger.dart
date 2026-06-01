import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:youpass/core/l10n/auth_message_localizer.dart';

class AppLogger {
  AppLogger._();

  static const String appTag = 'YouPass';

  static void debug(String message, {String tag = appTag}) {
    if (!kDebugMode) {
      return;
    }

    developer.log(message, name: tag);
  }

  static void info(String message, {String tag = appTag}) {
    debug(message, tag: tag);
  }

  static void warning(String message, {String tag = appTag}) {
    debug('⚠️ $message', tag: tag);
  }

  static void error(
    String message, {
    String tag = appTag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) {
      return;
    }

    final buffer = StringBuffer(message);
    if (error != null) {
      buffer.writeln('\nError: $error');
    }
    if (stackTrace != null) {
      buffer.writeln(stackTrace);
    }

    developer.log(
      buffer.toString(),
      name: tag,
      level: 1000,
    );
  }

  static void apiRequest({
    required String method,
    required String url,
    Object? body,
  }) {
    debug(
      '→ $method $url\n${_formatBody(body)}',
      tag: 'API',
    );
  }

  static void apiResponse({
    required String method,
    required String url,
    required int statusCode,
    String? body,
    Duration? duration,
  }) {
    final elapsed = duration == null ? '' : ' (${duration.inMilliseconds}ms)';
    debug(
      '← $statusCode $method $url$elapsed\n${_formatBody(body)}',
      tag: 'API',
    );
  }

  static void apiFailure({
    required String method,
    required String url,
    required Object error,
    StackTrace? stackTrace,
  }) {
    AppLogger.error(
      '✗ $method $url failed',
      tag: 'API',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void auth(String message) {
    debug(message, tag: 'Auth');
  }

  static String _formatBody(Object? body) {
    if (body == null) {
      return 'Body: (empty)';
    }

    if (body is String) {
      return 'Body: ${_sanitizeJsonString(body)}';
    }

    try {
      return 'Body: ${_sanitizeMap(jsonEncode(body))}';
    } catch (_) {
      return 'Body: $body';
    }
  }

  static String _sanitizeJsonString(String raw) {
    final forLog = AuthMessageLocalizer.localizeResponseBodyForLog(raw);

    try {
      final decoded = jsonDecode(forLog);
      if (decoded is Map<String, dynamic>) {
        return jsonEncode(_sanitizeMapValue(decoded));
      }
    } catch (_) {}

    return _sanitizeMap(forLog);
  }

  static String _sanitizeMap(String raw) {
    return raw
        .replaceAllMapped(
          RegExp(r'"code"\s*:\s*"\d+"'),
          (_) => '"code":"******"',
        )
        .replaceAllMapped(
          RegExp(r'"access_token"\s*:\s*"[^"]*"'),
          (_) => '"access_token":"***"',
        );
  }

  static bool _isSensitiveCodeValue(Object? value) {
    if (value is! String) {
      return false;
    }
    // OTP / verification codes only — keep API error codes like UNSUPPORTED_COUNTRY.
    return RegExp(r'^\d{4,8}$').hasMatch(value);
  }

  static Map<String, dynamic> _sanitizeMapValue(Map<String, dynamic> map) {
    return map.map((key, value) {
      if (key == 'access_token' || key == 'accessToken') {
        return MapEntry(key, '******');
      }

      if (key == 'code' && _isSensitiveCodeValue(value)) {
        return MapEntry(key, '******');
      }

      if (value is Map<String, dynamic>) {
        return MapEntry(key, _sanitizeMapValue(value));
      }

      return MapEntry(key, value);
    });
  }
}
