import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:youpass/staff_app/core/config/api_config.dart';
import 'package:youpass/staff_app/core/utils/app_logger.dart';
import '../constants/app_constants.dart';
import '../storage/staff_token_store.dart';
import 'api_exception.dart';

class ApiClient {
  ApiClient({http.Client? client, StaffTokenStore? tokenStore})
      : httpClient = client ?? http.Client(),
        _tokenStore = tokenStore ?? StaffTokenStore();

  final http.Client httpClient;
  final StaffTokenStore _tokenStore;

  String get baseUrl => ApiConfig.apiBaseUrl;

  Future<http.Response> get(
    String path, {
    bool authenticated = false,
  }) async {
    final headers = await _headers(authenticated: authenticated);
    final url = '$baseUrl$path';
    return _send(
      method: 'GET',
      url: url,
      headers: headers,
      request: () => httpClient
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(AppConstants.apiTimeout),
    );
  }

  Future<http.Response> post(
    String path, {
    Object? body,
    bool authenticated = false,
  }) async {
    final encodedBody = body == null ? null : jsonEncode(body);
    final headers = await _headers(
      authenticated: authenticated,
      includeJson: encodedBody != null,
    );
    final url = '$baseUrl$path';
    return _send(
      method: 'POST',
      url: url,
      headers: headers,
      body: body,
      request: () => httpClient
          .post(
            Uri.parse(url),
            headers: headers,
            body: encodedBody,
          )
          .timeout(AppConstants.apiTimeout),
    );
  }

  Future<http.Response> _send({
    required String method,
    required String url,
    required Future<http.Response> Function() request,
    Map<String, String>? headers,
    Object? body,
  }) async {
    final startedAt = DateTime.now();

    AppLogger.apiRequest(
      method: method,
      url: url,
      body: body,
      headers: headers,
    );

    for (var attempt = 0; attempt < 2; attempt++) {
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
      } on ApiException catch (error, stackTrace) {
        AppLogger.apiFailure(
          method: method,
          url: url,
          error: error,
          stackTrace: stackTrace,
        );
        rethrow;
      } on TimeoutException catch (error, stackTrace) {
        AppLogger.apiFailure(
          method: method,
          url: url,
          error: error,
          stackTrace: stackTrace,
        );
        throw ApiException(
          code: 'NETWORK_ERROR',
          message: 'Request timed out',
        );
      } on SocketException catch (error, stackTrace) {
        if (attempt == 0 && _shouldRetryTransientNetworkError(error)) {
          await Future<void>.delayed(const Duration(milliseconds: 400));
          continue;
        }
        AppLogger.apiFailure(
          method: method,
          url: url,
          error: error,
          stackTrace: stackTrace,
        );
        throw ApiException(
          code: 'NETWORK_ERROR',
          message: 'Could not reach the server',
        );
      } on http.ClientException catch (error, stackTrace) {
        if (attempt == 0 && _shouldRetryTransientNetworkError(error)) {
          await Future<void>.delayed(const Duration(milliseconds: 400));
          continue;
        }
        AppLogger.apiFailure(
          method: method,
          url: url,
          error: error,
          stackTrace: stackTrace,
        );
        throw ApiException(
          code: 'NETWORK_ERROR',
          message: 'Connection failed — try again',
        );
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

    throw ApiException(
      code: 'NETWORK_ERROR',
      message: 'Connection failed — try again',
    );
  }

  bool _shouldRetryTransientNetworkError(Object error) {
    final message = error.toString().toLowerCase();
    return message.contains('connection closed') ||
        message.contains('connection reset') ||
        message.contains('connection refused');
  }

  Future<Map<String, String>> _headers({
    required bool authenticated,
    bool includeJson = false,
  }) async {
    final headers = <String, String>{
      if (includeJson) 'Content-Type': 'application/json',
      if (ApiConfig.usesNgrokTunnel) ...{
        'ngrok-skip-browser-warning': 'true',
        // Avoid stale keep-alive sockets through ngrok after backend restarts.
        'Connection': 'close',
      },
    };

    if (authenticated) {
      final token = await _tokenStore.readToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }
}
