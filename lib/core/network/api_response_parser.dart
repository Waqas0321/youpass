import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youpass/core/l10n/auth_message_localizer.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/network/session_auth_handler.dart';
import 'package:youpass/core/utils/app_logger.dart';

class ApiResponseParser {
  ApiResponseParser._();

  static Map<String, dynamic> parseData(http.Response response) {
    final body = decodeBody(response);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (body['success'] == true) {
        final data = body['data'];
        if (data is Map<String, dynamic>) {
          return data;
        }
      }
    }

    throw _exceptionFor(response, body);
  }

  static Object? parseRawData(http.Response response) {
    final body = decodeBody(response);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (body['success'] == true) {
        return body['data'];
      }
    }

    throw _exceptionFor(response, body);
  }

  static void parseSuccess(http.Response response) {
    final body = decodeBody(response);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (body.isEmpty || body['success'] == true) {
        return;
      }
    }

    throw _exceptionFor(response, body);
  }

  static ApiException _exceptionFor(
    http.Response response,
    Map<String, dynamic> body,
  ) {
    final exception = ApiException.fromResponse(
      statusCode: response.statusCode,
      body: body,
    );

    final errorLine =
        'API error ${exception.code}: '
        '${AuthMessageLocalizer.forDebugLog(
          code: exception.code,
          fallbackMessage: exception.message,
          retryAfterSeconds: exception.retryAfterSeconds,
        )} '
        '(status ${response.statusCode})';

    if (exception.shouldLogAsWarning) {
      AppLogger.warning(errorLine, tag: 'API');
    } else {
      AppLogger.debug(errorLine, tag: 'API');
    }

    handleSessionAuthError(exception);

    return exception;
  }

  static Map<String, dynamic> decodeBody(http.Response response) {
    if (response.body.isEmpty) {
      return {};
    }

    final decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    return {};
  }
}
