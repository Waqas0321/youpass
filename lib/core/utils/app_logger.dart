import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:youpass/core/constants/app_constants.dart';
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
    final message = '→ $method $url\n${_formatBody(body)}';
    if (kDebugMode && AppConstants.logApiResponsesToConsole) {
      _printToConsole('API REQUEST', message);
      return;
    }
    debug(message, tag: 'API');
  }

  static void apiResponse({
    required String method,
    required String url,
    required int statusCode,
    String? body,
    Duration? duration,
  }) {
    final elapsed = duration == null ? '' : ' (${duration.inMilliseconds}ms)';
    final message =
        '← $statusCode $method $url$elapsed\n${_formatBody(body)}';
    if (kDebugMode && AppConstants.logApiResponsesToConsole) {
      _printToConsole('API RESPONSE', message);
      return;
    }
    debug(message, tag: 'API');
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

  static void _printToConsole(String title, String message) {
    if (!kDebugMode || !AppConstants.logApiResponsesToConsole) {
      return;
    }

    final divider = '═' * 48;
    debugPrint('');
    debugPrint(divider);
    debugPrint(' $title ');
    debugPrint(divider);
    for (final line in message.split('\n')) {
      _debugPrintLine(line);
    }
    debugPrint(divider);
    debugPrint('');
  }

  static void _debugPrintLine(String line) {
    const maxChunk = 900;
    if (line.length <= maxChunk) {
      debugPrint(line);
      return;
    }

    for (var start = 0; start < line.length; start += maxChunk) {
      final end = (start + maxChunk < line.length) ? start + maxChunk : line.length;
      debugPrint(line.substring(start, end));
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
