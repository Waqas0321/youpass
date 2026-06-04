import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/auth/session_establish_retry.dart';
import 'package:youpass/core/network/api_exception.dart';

void main() {
  tearDown(AuthTokenStore.clear);

  test('retries SESSION_INVALID during establish grace period', () async {
    AuthTokenStore.setSession(accessToken: 'token');
    AuthTokenStore.markEstablished();

    var attempts = 0;
    final result = await withSessionEstablishRetry(() async {
      attempts++;
      if (attempts < 2) {
        throw ApiException(
          code: 'SESSION_INVALID',
          message: 'Session is no longer valid',
          statusCode: 401,
        );
      }
      return 'ok';
    });

    expect(result, 'ok');
    expect(attempts, 2);
  });

  test('does not retry SESSION_INVALID outside grace period', () async {
    AuthTokenStore.setSession(
      accessToken: 'token',
      establishedAt: DateTime.now().subtract(const Duration(minutes: 1)),
    );

    await expectLater(
      withSessionEstablishRetry(() async {
        throw ApiException(
          code: 'SESSION_INVALID',
          message: 'Session is no longer valid',
          statusCode: 401,
        );
      }),
      throwsA(isA<ApiException>()),
    );
  });
}
