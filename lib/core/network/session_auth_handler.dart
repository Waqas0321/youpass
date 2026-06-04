import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/network/api_exception.dart';

/// Clears in-memory credentials when the server rejects the session.
void handleSessionAuthError(ApiException error) {
  if (error.code == 'SESSION_INVALID' || error.code == 'UNAUTHORIZED') {
    AuthTokenStore.clear();
  }
}
