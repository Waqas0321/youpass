import 'package:flutter/foundation.dart';

/// Single place to change backend URLs for the staff app.
///
/// Update [devTunnelApiV1Url] when ngrok restarts and you get a new public URL.
/// Override at run time: `flutter run --dart-define=API_BASE_URL=https://.../api/v1`
abstract final class ApiConfig {
  static const String productionApiV1Url =
      'https://youpass-backend-two.vercel.app/api/v1';

  /// Remote dev tunnel (real devices). Same as production unless you run ngrok locally.
  static const String devTunnelApiV1Url = productionApiV1Url;

  static const int localApiPort = 3002;

  /// Simulator / emulator localhost backend.
  static String get localApiV1Url =>
      'http://$_localApiHost:$localApiPort/api/v1';

  /// Physical device tunnel. Simulator uses localhost by default.
  /// `flutter run --dart-define=USE_NGROK_TUNNEL=true`
  static const bool useNgrokTunnel = bool.fromEnvironment(
    'USE_NGROK_TUNNEL',
    defaultValue: false,
  );

  static String get apiBaseUrl {
    const override = String.fromEnvironment('API_BASE_URL');
    if (override.isNotEmpty) {
      return override.replaceAll(RegExp(r'/+$'), '');
    }

    if (!kDebugMode) {
      return productionApiV1Url;
    }

    // Default debug → production Vercel. Local:
    // `flutter run --dart-define=USE_LOCAL_API=true`
    const useLocalApi = bool.fromEnvironment(
      'USE_LOCAL_API',
      defaultValue: false,
    );
    if (useLocalApi) {
      if (useNgrokTunnel) {
        return devTunnelApiV1Url;
      }
      return localApiV1Url;
    }
    return productionApiV1Url;
  }

  /// Short label for UI (drawer / debug).
  static String get activeApiLabel {
    const override = String.fromEnvironment('API_BASE_URL');
    if (override.isNotEmpty) {
      return 'Custom API';
    }

    if (!kDebugMode) {
      return 'Production';
    }

    const useLocalApi = bool.fromEnvironment(
      'USE_LOCAL_API',
      defaultValue: false,
    );
    if (useLocalApi) {
      if (useNgrokTunnel) {
        return 'Dev (ngrok)';
      }
      return 'Dev (local)';
    }
    return 'Production';
  }

  static bool get usesNgrokTunnel => apiBaseUrl.contains('ngrok');

  /// Active ngrok tunnel URL (update when ngrok restarts).
  static String get configuredNgrokApiV1Url => devTunnelApiV1Url;

  static String get _localApiHost {
    if (kIsWeb) {
      return 'localhost';
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '10.0.2.2';
    }
    return 'localhost';
  }
}
