import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class DeviceAuthService {
  DeviceAuthService({LocalAuthentication? localAuth})
      : _localAuth = localAuth ?? LocalAuthentication();

  final LocalAuthentication _localAuth;

  Future<bool> authenticate({required String reason}) async {
    try {
      final isSupported = await _localAuth.isDeviceSupported();
      if (!isSupported) {
        return true;
      }

      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics && kDebugMode) {
        // iOS Simulator / dev devices without enrolled Face ID or Touch ID.
        return true;
      }

      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
          useErrorDialogs: true,
          sensitiveTransaction: true,
        ),
      );
    } catch (_) {
      if (kDebugMode) {
        return true;
      }
      return false;
    }
  }
}
