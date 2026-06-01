import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youpass/core/l10n/auth_message_localizer.dart';
import 'package:youpass/core/network/api_exception.dart';
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

    final exception = ApiException.fromResponse(
      statusCode: response.statusCode,
      body: body,
    );

    AppLogger.warning(
      'API error ${exception.code}: '
      '${AuthMessageLocalizer.forDebugLog(
        code: exception.code,
        fallbackMessage: exception.message,
        retryAfterSeconds: exception.retryAfterSeconds,
      )} '
      '(status ${response.statusCode})',
      tag: 'API',
    );

    throw exception;
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
