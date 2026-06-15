import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:youpass/core/auth/auth_headers.dart';
import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/security/client_request_headers.dart';
import 'package:youpass/core/utils/app_logger.dart';

typedef AuthTokenProvider = Future<String?> Function();

class ApiClient {
  ApiClient({
    http.Client? client,
    this.authTokenProvider,
    ClientRequestHeaders? clientRequestHeaders,
  })  : httpClient = client ?? http.Client(),
        _clientRequestHeaders = clientRequestHeaders;

  final http.Client httpClient;
  final AuthTokenProvider? authTokenProvider;
  final ClientRequestHeaders? _clientRequestHeaders;

  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final resolvedHeaders = await _resolveHeaders(
      headers: headers,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
      multipart: false,
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
    String? accessTokenOverride,
  }) async {
    final hasBody = body != null;
    final encodedBody = hasBody
        ? (body is String ? body : jsonEncode(body))
        : null;
    final resolvedHeaders = await _resolveHeaders(
      headers: headers,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
      multipart: false,
      includeJsonContentType: hasBody,
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

  Future<http.Response> delete(
    String url, {
    Map<String, String>? headers,
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final resolvedHeaders = await _resolveHeaders(
      headers: headers,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
      multipart: false,
    );

    return _send(
      method: 'DELETE',
      url: url,
      request: () => httpClient
          .delete(Uri.parse(url), headers: resolvedHeaders)
          .timeout(AppConstants.apiTimeout),
    );
  }

  Future<http.Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final hasBody = body != null;
    final encodedBody = hasBody
        ? (body is String ? body : jsonEncode(body))
        : null;
    final resolvedHeaders = await _resolveHeaders(
      headers: headers,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
      multipart: false,
      includeJsonContentType: hasBody,
    );

    return _send(
      method: 'PATCH',
      url: url,
      body: encodedBody,
      request: () => httpClient
          .patch(
            Uri.parse(url),
            headers: resolvedHeaders,
            body: encodedBody,
          )
          .timeout(AppConstants.apiTimeout),
    );
  }

  Future<http.Response> postMultipart(
    String url, {
    required List<http.MultipartFile> files,
    Map<String, String>? fields,
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));
    if (fields != null) {
      request.fields.addAll(fields);
    }
    request.files.addAll(files);

    final resolvedHeaders = await _resolveHeaders(
      headers: const {},
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
      multipart: true,
    );

    if (resolvedHeaders.containsKey('Authorization')) {
      request.headers['Authorization'] = resolvedHeaders['Authorization']!;
    }

    final multipartSummary = <String, Object?>{
      if (fields != null && fields.isNotEmpty) 'fields': fields,
      'files': files
          .map((file) => file.filename ?? file.field ?? 'file')
          .toList(growable: false),
    };

    return _send(
      method: 'POST',
      url: url,
      body: multipartSummary,
      request: () async {
        final streamed = await httpClient
            .send(request)
            .timeout(AppConstants.apiTimeout);
        return http.Response.fromStream(streamed);
      },
    );
  }

  Future<Map<String, String>> _resolveHeaders({
    Map<String, String>? headers,
    required bool authenticated,
    String? accessTokenOverride,
    required bool multipart,
    bool includeJsonContentType = true,
  }) async {
    final clientHeaders = await _clientRequestHeaders?.build() ?? const {};
    final resolved = <String, String>{
      if (!multipart && includeJsonContentType) 'Content-Type': 'application/json',
      ...clientHeaders,
      ...?headers,
    };

    if (!authenticated) {
      return resolved;
    }

    final override = AuthTokenStore.normalizeToken(accessTokenOverride);
    String? token = override;

    if (token == null || token.isEmpty) {
      token = AuthTokenStore.accessToken;
    }

    if ((token == null || token.isEmpty) && authTokenProvider != null) {
      token = AuthTokenStore.normalizeToken(await authTokenProvider!());
    }

    if (token != null && token.isNotEmpty) {
      resolved.addAll(
        multipart ? authHeadersMultipart(token) : authHeaders(token),
      );
      final source = override != null ? 'override' : 'store';
      if (kDebugMode) {
        AppLogger.debug(
          'Authorization attached from $source',
          tag: 'API',
        );
      }
    } else {
      AppLogger.warning(
        'Authenticated request without access token',
        tag: 'API',
      );
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
