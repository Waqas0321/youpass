import 'package:youpass/core/auth/auth_token_store.dart';

/// Builds standard auth headers for protected YouPass API calls.
///
/// Stores and sends the raw JWT only — never prefix with `Bearer` in storage.
Map<String, String> authHeaders(String token) {
  final clean = AuthTokenStore.normalizeToken(token);
  if (clean == null || clean.isEmpty) {
    return const {'Content-Type': 'application/json'};
  }

  return {
    'Authorization': 'Bearer $clean',
    'Content-Type': 'application/json',
  };
}

/// Bearer header only for multipart uploads (no JSON content-type).
Map<String, String> authHeadersMultipart(String token) {
  final clean = AuthTokenStore.normalizeToken(token);
  if (clean == null || clean.isEmpty) {
    return const {};
  }

  return {'Authorization': 'Bearer $clean'};
}
