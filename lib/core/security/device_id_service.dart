import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:youpass/core/utils/app_logger.dart';

/// Stable per-installation ID sent as `X-Device-Id` on every API request.
class DeviceIdService {
  DeviceIdService({
    FlutterSecureStorage? secureStorage,
    SharedPreferences? preferences,
  })  : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
        _preferences = preferences;

  static const String storageKey = 'device_id';

  final FlutterSecureStorage _secureStorage;
  final SharedPreferences? _preferences;
  String? _cachedId;

  Future<String> getId() async {
    if (_cachedId != null && _cachedId!.isNotEmpty) {
      return _cachedId!;
    }

    final stored = await _readStored();
    if (stored != null && stored.isNotEmpty) {
      _cachedId = stored;
      return stored;
    }

    final generated = const Uuid().v4();
    await _persist(generated);
    _cachedId = generated;
    AppLogger.info('Generated device id', tag: 'Security');
    return generated;
  }

  Future<String?> _readStored() async {
    try {
      return await _secureStorage.read(key: storageKey);
    } on MissingPluginException catch (_) {
      return _preferences?.getString(storageKey);
    } on PlatformException catch (_) {
      return _preferences?.getString(storageKey);
    }
  }

  Future<void> _persist(String id) async {
    try {
      await _secureStorage.write(key: storageKey, value: id);
      return;
    } on MissingPluginException catch (_) {
      // Fall through to preferences.
    } on PlatformException catch (_) {
      // Fall through to preferences.
    }

    await _preferences?.setString(storageKey, id);
  }
}
