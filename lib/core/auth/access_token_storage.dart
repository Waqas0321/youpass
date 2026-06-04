import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/services/storage_service.dart';
import 'package:youpass/core/utils/app_logger.dart';

/// Persists the raw JWT access token (no `Bearer` prefix).
abstract class AccessTokenStorage {
  Future<String?> read();
  Future<void> write(String token);
  Future<void> delete();
}

/// Stores tokens in Keychain/Keystore when the native plugin is available.
/// Falls back to [StorageService] after hot restart or when the plugin is
/// missing (requires a full `flutter run` to register native code).
class SecureAccessTokenStorage implements AccessTokenStorage {
  SecureAccessTokenStorage({
    FlutterSecureStorage? secureStorage,
    this.legacyStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  static const String storageKey = 'access_token';

  final FlutterSecureStorage _secureStorage;
  final StorageService? legacyStorage;
  bool _useLegacyFallback = false;

  @override
  Future<String?> read() async {
    if (_useLegacyFallback) {
      return _readLegacy();
    }

    try {
      await _migrateLegacyTokenIfNeeded();
      final token = AuthTokenStore.normalizeToken(
        await _secureStorage.read(key: storageKey),
      );
      if (token != null) {
        return token;
      }
      return _readLegacy();
    } on MissingPluginException catch (error) {
      _enableLegacyFallback(error);
      return _readLegacy();
    } on PlatformException catch (error) {
      if (_isSecureUnavailable(error)) {
        _enableLegacyFallback(error);
        return _readLegacy();
      }
      rethrow;
    }
  }

  @override
  Future<void> write(String token) async {
    final normalized = AuthTokenStore.normalizeToken(token);
    if (normalized == null) {
      return;
    }

    if (_useLegacyFallback) {
      await _writeLegacy(normalized);
      return;
    }

    try {
      await _secureStorage.write(key: storageKey, value: normalized);
      await legacyStorage?.remove(AppConstants.tokenKey);
    } on MissingPluginException catch (error) {
      _enableLegacyFallback(error);
      await _writeLegacy(normalized);
    } on PlatformException catch (error) {
      if (_isSecureUnavailable(error)) {
        _enableLegacyFallback(error);
        await _writeLegacy(normalized);
        return;
      }
      rethrow;
    }
  }

  @override
  Future<void> delete() async {
    if (!_useLegacyFallback) {
      try {
        await _secureStorage.delete(key: storageKey);
      } on MissingPluginException catch (error) {
        _enableLegacyFallback(error);
      } on PlatformException catch (error) {
        if (_isSecureUnavailable(error)) {
          _enableLegacyFallback(error);
        } else {
          rethrow;
        }
      }
    }

    await legacyStorage?.remove(AppConstants.tokenKey);
  }

  Future<void> _migrateLegacyTokenIfNeeded() async {
    final legacy = legacyStorage;
    if (legacy == null) {
      return;
    }

    final existing = await _secureStorage.read(key: storageKey);
    if (existing != null && existing.isNotEmpty) {
      return;
    }

    final legacyToken = _readLegacySync();
    if (legacyToken == null) {
      return;
    }

    await _secureStorage.write(key: storageKey, value: legacyToken);
    await legacy.remove(AppConstants.tokenKey);
  }

  String? _readLegacySync() {
    return AuthTokenStore.normalizeToken(
      legacyStorage?.getString(AppConstants.tokenKey),
    );
  }

  Future<String?> _readLegacy() async {
    return _readLegacySync();
  }

  Future<void> _writeLegacy(String token) async {
    await legacyStorage?.saveString(AppConstants.tokenKey, token);
  }

  void _enableLegacyFallback(Object error) {
    if (_useLegacyFallback) {
      return;
    }

    _useLegacyFallback = true;
    AppLogger.warning(
      'Secure storage unavailable ($error) — using SharedPreferences '
      'for the access token. Stop the app and run `flutter run` once to '
      'enable Keychain storage.',
      tag: 'Auth',
    );
  }

  bool _isSecureUnavailable(PlatformException error) {
    return error.code == 'channel-error' ||
        error.message?.contains('MissingPluginException') == true;
  }
}

/// In-memory token storage for unit tests.
class MemoryAccessTokenStorage implements AccessTokenStorage {
  String? _token;

  @override
  Future<void> delete() async {
    _token = null;
  }

  @override
  Future<String?> read() async {
    return AuthTokenStore.normalizeToken(_token);
  }

  @override
  Future<void> write(String token) async {
    _token = AuthTokenStore.normalizeToken(token);
  }
}
