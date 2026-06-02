import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/utils/app_logger.dart';

typedef AuthCredentialsProvider = Future<AuthCredentials> Function();

class ApiClient {
  ApiClient({
    http.Client? client,
    this.authCredentialsProvider,
  }) : httpClient = client ?? http.Client();

  final http.Client httpClient;
  final AuthCredentialsProvider? authCredentialsProvider;

  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
    bool authenticated = false,
  }) async {
    final resolvedHeaders = await _resolveHeaders(
      headers: headers,
      authenticated: authenticated,
    );

    return _send(
      method: 'GET',
      url: url,
      request: () => httpClient
          .get(Uri.parse(url), headers: resolvedHeaders)
          .timeout(AppConstants.apiTimeout),
    );
  }

  Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    bool authenticated = false,
  }) async {
    final encodedBody = body is String ? body : jsonEncode(body);
    final resolvedHeaders = await _resolveHeaders(
      headers: headers,
      authenticated: authenticated,
    );

    return _send(
      method: 'POST',
      url: url,
      body: encodedBody,
      request: () => httpClient
          .post(
            Uri.parse(url),
            headers: resolvedHeaders,
            body: encodedBody,
          )
          .timeout(AppConstants.apiTimeout),
    );
  }

  Future<Map<String, String>> _resolveHeaders({
    Map<String, String>? headers,
    required bool authenticated,
  }) async {
    final resolved = <String, String>{
      'Content-Type': 'application/json',
      ...?headers,
    };

    if (authenticated && authCredentialsProvider != null) {
      final credentials = await authCredentialsProvider!();
      final token = credentials.accessToken?.trim();
      final sessionId = credentials.sessionId?.trim();

      if (token != null && token.isNotEmpty) {
        resolved['Authorization'] = 'Bearer $token';
        AppLogger.debug(
          'Authorization attached (${token.length} chars)',
          tag: 'API',
        );
      } else if (authenticated) {
        AppLogger.warning(
          'Authenticated request without access token',
          tag: 'API',
        );
      }

      if (sessionId != null && sessionId.isNotEmpty) {
        resolved['X-Session-Id'] = sessionId;
      }
    }

    return resolved;
  }

  Future<http.Response> _send({
    required String method,
    required String url,
    required Future<http.Response> Function() request,
    Object? body,
  }) async {
    final startedAt = DateTime.now();

    AppLogger.apiRequest(method: method, url: url, body: body);

    try {
      final response = await request();
      final duration = DateTime.now().difference(startedAt);

      AppLogger.apiResponse(
        method: method,
        url: url,
        statusCode: response.statusCode,
        body: response.body,
        duration: duration,
      );

      return response;
    } catch (error, stackTrace) {
      AppLogger.apiFailure(
        method: method,
        url: url,
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
