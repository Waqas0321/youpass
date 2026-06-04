import 'dart:convert';

/// Shared JWT builders for auth-related unit tests.
class JwtTestHelper {
  JwtTestHelper._();

  static String buildToken({
    required int exp,
    Map<String, Object>? extraClaims,
  }) {
    final payloadMap = {'exp': exp, ...?extraClaims};
    final header = base64Url.encode(utf8.encode('{"alg":"HS256"}'));
    final payload = base64Url.encode(utf8.encode(jsonEncode(payloadMap)));
    return '$header.$payload.signature';
  }

  static String validToken({String? sessionId}) {
    return buildToken(
      exp: 4_000_000_000,
      extraClaims: sessionId == null ? null : {'session_id': sessionId},
    );
  }

  static String expiredToken() {
    return buildToken(exp: 1_600_000_000);
  }
}
