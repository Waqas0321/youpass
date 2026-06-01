import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youpass/core/constants/app_constants.dart';

class ApiClient {
  ApiClient({http.Client? client}) : httpClient = client ?? http.Client();

  final http.Client httpClient;

  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    return httpClient
        .get(Uri.parse(url), headers: headers)
        .timeout(AppConstants.apiTimeout);
  }

  Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return httpClient
        .post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            ...?headers,
          },
          body: body is String ? body : jsonEncode(body),
        )
        .timeout(AppConstants.apiTimeout);
  }
}
