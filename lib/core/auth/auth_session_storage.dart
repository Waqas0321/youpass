import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/services/storage_service.dart';

/// Restores in-memory auth credentials from disk on app launch.
class AuthSessionStorage {
  AuthSessionStorage._();

  static void hydrateFromDisk(StorageService storage) {
    final token = storage.getString(AppConstants.tokenKey)?.trim();
    if (token == null || token.isEmpty) {
      AuthTokenStore.clear();
      return;
    }

    final sessionId = storage.getString(AppConstants.sessionIdKey)?.trim();
    AuthTokenStore.setSession(
      accessToken: token,
      sessionId: sessionId?.isNotEmpty == true ? sessionId : null,
    );
  }
}
