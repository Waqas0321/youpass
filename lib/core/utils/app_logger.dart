import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/l10n/auth_message_localizer.dart';

class AppLogger {
  AppLogger._();

  static const String appTag = 'YouPass';
  static const String apiTag = 'API';

  static void debug(String message, {String tag = appTag}) {
    if (!kDebugMode) {
      return;
    }

    _console('[$tag] $message');
  }

  static void info(String message, {String tag = appTag}) {
    debug(message, tag: tag);
  }

  static void warning(String message, {String tag = appTag}) {
    if (!kDebugMode) {
      return;
    }

    _console('[$tag] ⚠️ $message');
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

    _console('[$tag] ✗ $message');
    if (error != null) {
      _console('[$tag]   Error: $error');
    }
    if (stackTrace != null) {
      for (final line in stackTrace.toString().split('\n')) {
        _console('[$tag]   $line');
      }
    }
  }

  static void apiRequest({
    required String method,
    required String url,
    Object? body,
  }) {
    if (!kDebugMode) {
      return;
    }

    _console('[$apiTag] → $method $url');
    if (AppConstants.logApiResponsesToConsole) {
      _consoleMultiline(_formatBody(body), tag: apiTag);
    }
  }

  static void apiResponse({
    required String method,
    required String url,
    required int statusCode,
    String? body,
    Duration? duration,
  }) {
    if (!kDebugMode) {
      return;
    }

    final elapsed = duration == null ? '' : ' ${duration.inMilliseconds}ms';
    final ok = statusCode >= 200 && statusCode < 300;
    final marker = ok ? '✓' : '✗';
    _console('[$apiTag] ← $marker $statusCode $method $url$elapsed');
    if (AppConstants.logApiResponsesToConsole) {
      _consoleMultiline(_formatBody(body), tag: apiTag);
    }
  }

  static void apiFailure({
    required String method,
    required String url,
    required Object error,
    StackTrace? stackTrace,
  }) {
    AppLogger.error(
      '$method $url failed',
      tag: apiTag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void auth(String message) {
    debug(message, tag: 'Auth');
  }

  /// Logs a mock OTP returned by the local backend (`TWILIO_MOCK=true`).
  static void devOtp({
    required String phone,
    required String purpose,
    required String code,
  }) {
    if (!kDebugMode) {
      return;
    }

    _console('[$apiTag] [DEV OTP] phone=$phone purpose=$purpose code=$code');
  }

  static void _console(String message) {
    if (!kDebugMode) {
      return;
    }

    const maxChunk = 900;
    if (message.length <= maxChunk) {
      debugPrint(message);
      return;
    }

    for (var start = 0; start < message.length; start += maxChunk) {
      final end =
          (start + maxChunk < message.length) ? start + maxChunk : message.length;
      debugPrint(message.substring(start, end));
    }
  }

  static void _consoleMultiline(String message, {String tag = apiTag}) {
    for (final line in message.split('\n')) {
      _console('[$tag]   $line');
    }
  }

  static String _formatBody(Object? body) {
    if (body == null) {
      return 'Body: (empty)';
    }

    if (body is String) {
      if (body.isEmpty) {
        return 'Body: (empty)';
      }
      return 'Body:\n${_prettySanitizedJson(body)}';
    }

    try {
      final encoded = jsonEncode(body);
      return 'Body:\n${_prettySanitizedJson(encoded)}';
    } catch (_) {
      return 'Body: $body';
    }
  }

  static String _prettySanitizedJson(String raw) {
    final forLog = AuthMessageLocalizer.localizeResponseBodyForLog(raw);

    try {
      final decoded = jsonDecode(forLog);
      final sanitized = decoded is Map<String, dynamic>
          ? _sanitizeMapValue(decoded)
          : decoded;
      return const JsonEncoder.withIndent('  ').convert(sanitized);
    } catch (_) {
      return _sanitizeMap(forLog);
    }
  }

  static String _sanitizeMap(String raw) {
    return raw
        .replaceAllMapped(
          RegExp(r'"code"\s*:\s*"\d{4,8}"'),
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
      if (key == 'access_token' ||
          key == 'accessToken' ||
          key == 'recaptcha_token') {
        return MapEntry(key, '******');
      }

      if (key == 'code' && _isSensitiveCodeValue(value)) {
        return MapEntry(key, '******');
      }

      if (key == 'card_number' ||
          key == 'cvv' ||
          key == 'payment_method_id') {
        return MapEntry(key, '******');
      }

      if (value is Map<String, dynamic>) {
        return MapEntry(key, _sanitizeMapValue(value));
      }

      return MapEntry(key, value);
    });
  }
}
