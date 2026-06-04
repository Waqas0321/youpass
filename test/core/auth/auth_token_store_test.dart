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

  test('resolveCredentials falls back to persisted values when memory empty', () {
    final credentials = AuthTokenStore.resolveCredentials(
      persistedToken: 'disk-token',
      persistedSessionId: 'disk-session',
    );
    expect(credentials.accessToken, 'disk-token');
    expect(credentials.sessionId, 'disk-session');
  });

  test('resolveCredentials does not mix memory token with disk session id', () {
    AuthTokenStore.setSession(
      accessToken: 'fresh-token',
      sessionId: null,
    );

    final credentials = AuthTokenStore.resolveCredentials(
      persistedToken: 'stale-token',
      persistedSessionId: 'stale-session',
    );

    expect(credentials.accessToken, 'fresh-token');
    expect(credentials.sessionId, isNull);
  });

  test('normalizeToken strips Bearer prefix and whitespace', () {
    expect(
      AuthTokenStore.normalizeToken('  Bearer eyJ.test.token  '),
      'eyJ.test.token',
    );
  });

  test('clear removes in-memory token', () {
    AuthTokenStore.setSession(accessToken: 'memory-token');
    AuthTokenStore.clear();
    expect(
      AuthTokenStore.resolveCredentials(persistedToken: null).accessToken,
      isNull,
    );
  });

  test('markEstablished enables grace period checks', () {
    AuthTokenStore.setSession(accessToken: 'memory-token');
    AuthTokenStore.markEstablished();

    expect(AuthTokenStore.isWithinEstablishGracePeriod, isTrue);
  });
}
