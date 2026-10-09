import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';

class StaffTokenStore {
  StaffTokenStore({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const offlineSigningSecretKey = 'staff_offline_signing_secret';
  static const staffProfileKey = 'staff_profile_cache_v1';
  static const supervisorUnlockedKey = 'staff_supervisor_unlocked_v1';
  static const supervisorPinVerifierKey = 'staff_supervisor_pin_verifier_v1';

  Future<bool> hasSession() async {
    final token = await readToken();
    return token != null && token.isNotEmpty;
  }

  Future<String?> readToken() {
    return _storage.read(key: AppConstants.staffTokenKey);
  }

  Future<void> saveToken(String token) {
    return _storage.write(key: AppConstants.staffTokenKey, value: token);
  }

  Future<String?> readOfflineSigningSecret() {
    return _storage.read(key: offlineSigningSecretKey);
  }

  Future<void> saveOfflineSigningSecret(String secret) {
    return _storage.write(key: offlineSigningSecretKey, value: secret);
  }

  Future<void> saveProfileJson(Map<String, dynamic> profile) {
    return _storage.write(key: staffProfileKey, value: jsonEncode(profile));
  }

  Future<Map<String, dynamic>?> readProfileJson() async {
    final raw = await _storage.read(key: staffProfileKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {}
    return null;
  }

  Future<bool> readSupervisorUnlocked() async {
    final raw = await _storage.read(key: supervisorUnlockedKey);
    return raw == '1';
  }

  Future<void> saveSupervisorUnlocked(bool unlocked) {
    if (unlocked) {
      return _storage.write(key: supervisorUnlockedKey, value: '1');
    }
    return _storage.delete(key: supervisorUnlockedKey);
  }

  /// Local verifier so supervisor PIN can be checked offline after one online unlock.
  Future<void> saveSupervisorPinVerifier({
    required String pin,
    required String signingSecret,
  }) {
    return _storage.write(
      key: supervisorPinVerifierKey,
      value: _hashSupervisorPin(pin: pin, signingSecret: signingSecret),
    );
  }

  Future<bool> verifySupervisorPinLocally({
    required String pin,
    required String signingSecret,
  }) async {
    final stored = await _storage.read(key: supervisorPinVerifierKey);
    if (stored == null || stored.isEmpty) {
      return false;
    }
    final computed = _hashSupervisorPin(pin: pin, signingSecret: signingSecret);
    if (stored.length != computed.length) {
      return false;
    }
    var diff = 0;
    for (var i = 0; i < stored.length; i++) {
      diff |= stored.codeUnitAt(i) ^ computed.codeUnitAt(i);
    }
    return diff == 0;
  }

  Future<bool> hasSupervisorPinVerifier() async {
    final stored = await _storage.read(key: supervisorPinVerifierKey);
    return stored != null && stored.isNotEmpty;
  }

  static String _hashSupervisorPin({
    required String pin,
    required String signingSecret,
  }) {
    final digest = Hmac(
      sha256,
      utf8.encode(signingSecret),
    ).convert(utf8.encode('supervisor-pin-v1|$pin'));
    return digest.toString();
  }

  Future<void> clearSession() async {
    await _storage.delete(key: AppConstants.staffTokenKey);
    await _storage.delete(key: offlineSigningSecretKey);
    await _storage.delete(key: staffProfileKey);
    await _storage.delete(key: supervisorUnlockedKey);
    await _storage.delete(key: supervisorPinVerifierKey);
  }
}
