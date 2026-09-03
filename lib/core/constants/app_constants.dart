import 'package:flutter/foundation.dart';

class AppConstants {
  /// Set to `false` to restore real login/send-code API calls.
  static const bool devBypassLoginApi = false;

  /// Uses mock invitations when the invitations API is unavailable.
  static const bool useInvitationsMockData = false;

  /// Uses mock tickets when the tickets API is unavailable.
  static const bool useTicketsMockData = false;

  /// Uses mock VIP venue data when the VIP venue API is unavailable.
  static const bool useVipVenueMockData = false;

  /// Logs every API call to the console in debug builds. When true, also prints
  /// sanitized request/response JSON bodies.
  static const bool logApiResponsesToConsole = true;

  static const String appName = 'YouPass';

  /// Production API root (includes `/api/v1`).
  static const String productionApiV1Url =
      'https://youpass-backend-two.vercel.app/api/v1';

  /// Remote dev tunnel (physical devices). Same as production unless you run ngrok locally.
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

  /// Default: production API (Vercel). Local debug:
  /// `flutter run --dart-define=USE_LOCAL_API=true`
  /// Override: `--dart-define=API_BASE_URL=...`
  static String get apiBaseUrl {
    const override = String.fromEnvironment('API_BASE_URL');
    if (override.isNotEmpty) {
      return override.replaceAll(RegExp(r'/+$'), '');
    }

    if (!kDebugMode) {
      return productionApiV1Url;
    }

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

  static String get _localApiHost {
    if (kIsWeb) {
      return 'localhost';
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '10.0.2.2';
    }
    return 'localhost';
  }

  static const String tokenKey = 'auth_token';
  static const String sessionIdKey = 'auth_session_id';
  static const String userKey = 'user_data';
  static const String userProfileKey = 'user_profile_data';
  static const Duration apiTimeout = Duration(seconds: 30);

  static const String categoryIdAll = 'all';
  static const String categoryAllEmoji = '🌶️';
  static const String categoryIdChile = 'chile';
  static const String categoryIdParties = 'parties';
  static const String categoryIdConcerts = 'concerts';
  static const String categoryIdSports = 'sports';
  static const String defaultHomeCategoryId = categoryIdAll;

  static const String featuredEventIdPrimavera = 'primavera-2026';
  static const String featuredEventIdSummerBeats = 'summer-beats';

  static const String eventIdCaribeNight = 'caribe-night';
  static const String eventIdRockAlParque = 'rock-al-parque';

  static const double countryPickerSheetHeightFactor = 0.85;
}
