import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:youpass/staff_app/core/constants/app_constants.dart';

class AppLogger {
  AppLogger._();

  static const String appTag = 'YouPassStaff';
  static const String apiTag = 'API';

  static void debug(String message, {String tag = appTag}) {
    if (!kDebugMode) {
      return;
    }

    _console('[$tag] $message');
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
    Map<String, String>? headers,
  }) {
    if (!kDebugMode) {
      return;
    }

    _console('[$apiTag] → $method $url');
    if (headers != null && headers.isNotEmpty) {
      _consoleMultiline(_formatHeaders(headers), tag: apiTag);
    }
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
      final end = (start + maxChunk < message.length)
          ? start + maxChunk
          : message.length;
      debugPrint(message.substring(start, end));
    }
  }

  static void _consoleMultiline(String message, {String tag = apiTag}) {
    for (final line in message.split('\n')) {
      _console('[$tag]   $line');
    }
  }

  static String _formatHeaders(Map<String, String> headers) {
    final sanitized = headers.map((key, value) {
      if (key.toLowerCase() == 'authorization') {
        return MapEntry(key, 'Bearer ***');
      }
      return MapEntry(key, value);
    });

    return 'Headers:\n${const JsonEncoder.withIndent('  ').convert(sanitized)}';
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
    try {
      final decoded = jsonDecode(raw);
      final sanitized = decoded is Map<String, dynamic>
          ? _sanitizeMapValue(decoded)
          : decoded;
      return const JsonEncoder.withIndent('  ').convert(sanitized);
    } catch (_) {
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
  }

  static Map<String, dynamic> _sanitizeMapValue(Map<String, dynamic> map) {
    return map.map((key, value) {
      if (key == 'access_token' ||
          key == 'accessToken' ||
          key == 'recaptcha_token') {
        return MapEntry(key, '******');
      }

      if (key == 'code' && value is String && RegExp(r'^\d{4,8}$').hasMatch(value)) {
        return MapEntry(key, '******');
      }

      if (key == 'dev_otp_code' && value is String) {
        return MapEntry(key, value);
      }

      if (value is Map<String, dynamic>) {
        return MapEntry(key, _sanitizeMapValue(value));
      }

      return MapEntry(key, value);
    });
  }
}
