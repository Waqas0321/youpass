import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/auth/auth_token_store.dart';

void main() {
  tearDown(AuthTokenStore.clear);

  test('resolveCredentials prefers in-memory values over persisted', () {
    AuthTokenStore.setSession(
      accessToken: 'memory-token',
      sessionId: 'memory-session',
    );
    final credentials = AuthTokenStore.resolveCredentials(
      persistedToken: 'disk-token',
      persistedSessionId: 'disk-session',
    );
    expect(credentials.accessToken, 'memory-token');
    expect(credentials.sessionId, 'memory-session');
  });

  test('resolveCredentials falls back to persisted values', () {
    final credentials = AuthTokenStore.resolveCredentials(
      persistedToken: 'disk-token',
      persistedSessionId: 'disk-session',
    );
    expect(credentials.accessToken, 'disk-token');
    expect(credentials.sessionId, 'disk-session');
  });

  test('clear removes in-memory token', () {
    AuthTokenStore.setSession(accessToken: 'memory-token');
    AuthTokenStore.clear();
    expect(AuthTokenStore.resolveToken(persistedToken: null), isNull);
  });
}
