import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:youpass/staff_app/core/utils/app_logger.dart';
import 'api_exception.dart';

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

    AppLogger.warning(
      'API error ${exception.code}: ${exception.message} '
      '(status ${response.statusCode})',
      tag: 'API',
    );

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
