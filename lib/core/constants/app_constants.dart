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
  /// Debug → local backend (`npm run dev`). Release → Vercel.
  static String get apiBaseUrl => kDebugMode
      ? 'http://localhost:3000'
      : 'https://youpass-backend.vercel.app';
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
