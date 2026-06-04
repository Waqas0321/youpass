import 'package:youpass/core/auth/access_token_storage.dart';
import 'package:youpass/core/auth/auth_token_store.dart';

/// Restores in-memory access token from secure storage on app launch.
class AuthSessionStorage {
  AuthSessionStorage._();

  static Future<void> hydrate(AccessTokenStorage storage) async {
    final token = await storage.read();
    if (token == null) {
      AuthTokenStore.clear();
      return;
    }

    AuthTokenStore.setSession(accessToken: token);
  }
}
