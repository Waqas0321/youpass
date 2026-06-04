import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/network/session_auth_handler.dart';

void main() {
  tearDown(AuthTokenStore.clear);

  test('handleSessionAuthError clears token store on SESSION_INVALID', () {
    AuthTokenStore.setSession(accessToken: 'token');

    handleSessionAuthError(
      ApiException(
        code: 'SESSION_INVALID',
        message: 'Session is no longer valid',
        statusCode: 401,
      ),
    );

    expect(AuthTokenStore.accessToken, isNull);
  });

  test('handleSessionAuthError clears token store on UNAUTHORIZED', () {
    AuthTokenStore.setSession(accessToken: 'token');

    handleSessionAuthError(
      ApiException(
        code: 'UNAUTHORIZED',
        message: 'Authentication required',
        statusCode: 401,
      ),
    );

    expect(AuthTokenStore.accessToken, isNull);
  });

  test('handleSessionAuthError ignores other error codes', () {
    AuthTokenStore.setSession(accessToken: 'token');

    handleSessionAuthError(
      ApiException(
        code: 'INTERNAL_ERROR',
        message: 'Server error',
        statusCode: 500,
      ),
    );

    expect(AuthTokenStore.accessToken, 'token');
  });
}
