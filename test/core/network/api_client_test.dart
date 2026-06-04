import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/network/api_client.dart';

import '../../helpers/jwt_test_helper.dart';

void main() {
  tearDown(AuthTokenStore.clear);

  group('authenticated requests', () {
    test('get attaches Bearer token from memory store', () async {
      late http.Request captured;
      final token = JwtTestHelper.validToken();
      AuthTokenStore.setSession(accessToken: token);

      final client = ApiClient(
        client: MockClient((request) async {
          captured = request;
          return http.Response(
            '{"success":true,"data":{}}',
            200,
            headers: {'content-type': 'application/json'},
          );
        }),
      );

      await client.get(
        'https://example.com/users/me',
        authenticated: true,
        accessTokenOverride: token,
      );

      expect(captured.headers['Authorization'], 'Bearer $token');
      expect(captured.headers.containsKey('X-Session-Id'), isFalse);
      expect(captured.headers['Content-Type'], 'application/json');
    });

    test('get uses accessTokenOverride before token provider', () async {
      late http.Request captured;
      final client = ApiClient(
        client: MockClient((request) async {
          captured = request;
          return http.Response('{"success":true,"data":{}}', 200);
        }),
        authTokenProvider: () async => 'stale-token',
      );

      await client.get(
        'https://example.com/users/me',
        authenticated: true,
        accessTokenOverride: 'fresh-login-token',
      );

      expect(captured.headers['Authorization'], 'Bearer fresh-login-token');
    });

    test('postMultipart sends Authorization without json Content-Type', () async {
      late Map<String, String> capturedHeaders;
      final token = JwtTestHelper.validToken();
      AuthTokenStore.setSession(accessToken: token);

      final client = ApiClient(
        client: MockClient((request) async {
          capturedHeaders = request.headers;
          return http.Response('{"success":true,"data":{}}', 200);
        }),
      );

      await client.postMultipart(
        'https://example.com/users/me/profile-photo',
        files: const [],
        authenticated: true,
        accessTokenOverride: token,
      );

      expect(capturedHeaders['Authorization'], 'Bearer $token');
      expect(capturedHeaders.containsKey('X-Session-Id'), isFalse);
      expect(capturedHeaders['Content-Type'], isNot('application/json'));
    });

    test('normalizeToken strips Bearer prefix from override', () async {
      late http.Request captured;
      final client = ApiClient(
        client: MockClient((request) async {
          captured = request;
          return http.Response('{"success":true,"data":{}}', 200);
        }),
      );

      await client.get(
        'https://example.com/users/me',
        authenticated: true,
        accessTokenOverride: 'Bearer eyJ.trimmed.token',
      );

      expect(captured.headers['Authorization'], 'Bearer eyJ.trimmed.token');
    });
  });
}
