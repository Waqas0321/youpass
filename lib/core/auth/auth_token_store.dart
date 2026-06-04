/// Holds the active access token in memory so authenticated requests work
/// immediately after login, before SharedPreferences finishes persisting.
class AuthTokenStore {
  AuthTokenStore._();

  static const Duration establishGracePeriod = Duration(seconds: 15);

  static String? _accessToken;
  static String? _sessionId;
  static DateTime? _establishedAt;

  static String? get accessToken => normalizeToken(_accessToken);

  static String? get sessionId => normalizeSessionId(_sessionId);

  static DateTime? get establishedAt => _establishedAt;

  static bool get isWithinEstablishGracePeriod {
    final established = _establishedAt;
    if (established == null) {
      return false;
    }

    return DateTime.now().difference(established) <= establishGracePeriod;
  }

  static void setSession({
    required String accessToken,
    String? sessionId,
    DateTime? establishedAt,
  }) {
    _accessToken = normalizeToken(accessToken);
    _sessionId = normalizeSessionId(sessionId);
    _establishedAt = establishedAt;
  }

  static void markEstablished({DateTime? at}) {
    _establishedAt = at ?? DateTime.now();
  }

  static void clear() {
    _accessToken = null;
    _sessionId = null;
    _establishedAt = null;
  }

  /// Strips whitespace and accidental `Bearer ` prefix from stored tokens.
  static String? normalizeToken(String? raw) {
    if (raw == null) {
      return null;
    }

    var value = raw.trim();
    if (value.toLowerCase().startsWith('bearer ')) {
      value = value.substring(7).trim();
    }
    value = value.replaceAll(RegExp(r'\s+'), '');

    return value.isEmpty ? null : value;
  }

  static String? normalizeSessionId(String? raw) {
    if (raw == null) {
      return null;
    }

    final value = raw.trim();
    return value.isEmpty ? null : value;
  }

  /// Resolves credentials for authenticated API calls.
  ///
  /// When an in-memory token exists (fresh login), only the in-memory
  /// [sessionId] is used — never a stale session id from disk.
  static AuthCredentials resolveCredentials({
    String? persistedToken,
    String? persistedSessionId,
  }) {
    final memoryToken = normalizeToken(_accessToken);
    if (memoryToken != null && memoryToken.isNotEmpty) {
      return AuthCredentials(
        accessToken: memoryToken,
        sessionId: normalizeSessionId(_sessionId),
      );
    }

    return AuthCredentials(
      accessToken: normalizeToken(persistedToken),
      sessionId: normalizeSessionId(persistedSessionId),
    );
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
