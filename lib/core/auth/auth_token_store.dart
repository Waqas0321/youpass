/// Holds the active access token in memory so authenticated requests work
/// immediately after login, before SharedPreferences finishes persisting.
class AuthTokenStore {
  AuthTokenStore._();

  static String? _accessToken;
  static String? _sessionId;

  static String? get accessToken => _accessToken;

  static String? get sessionId => _sessionId;

  static void setSession({
    required String accessToken,
    String? sessionId,
  }) {
    _accessToken = accessToken.isNotEmpty ? accessToken : null;
    _sessionId = sessionId;
  }

  static void clear() {
    _accessToken = null;
    _sessionId = null;
  }

  /// Resolves the token used for `Authorization: Bearer` headers.
  static String? resolveToken({String? persistedToken}) {
    return resolveCredentials(
      persistedToken: persistedToken,
      persistedSessionId: null,
    ).accessToken;
  }

  static AuthCredentials resolveCredentials({
    String? persistedToken,
    String? persistedSessionId,
  }) {
    final token = _readValue(_accessToken, persistedToken);
    final sessionId = _readValue(_sessionId, persistedSessionId);

    return AuthCredentials(
      accessToken: token,
      sessionId: sessionId,
    );
  }

  static String? _readValue(String? memory, String? persisted) {
    if (memory != null && memory.isNotEmpty) {
      return memory;
    }
    if (persisted != null && persisted.isNotEmpty) {
      return persisted;
    }
    return null;
  }
}

class AuthCredentials {
  const AuthCredentials({
    this.accessToken,
    this.sessionId,
  });

  final String? accessToken;
  final String? sessionId;
}
