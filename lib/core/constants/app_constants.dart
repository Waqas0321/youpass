class AppConstants {
  /// Set to `false` to restore real login/send-code API calls.
  static const bool devBypassLoginApi = false;

  /// Uses mock invitations when the invitations API is unavailable.
  static const bool useInvitationsMockData = false;

  /// Uses mock tickets when the tickets API is unavailable.
  static const bool useTicketsMockData = false;

  /// Uses mock VIP venue data when the VIP venue API is unavailable.
  static const bool useVipVenueMockData = false;

  /// Prints request/response JSON to the IDE / `flutter run` console (debug builds only).
  static const bool logApiResponsesToConsole = true;

  static const String appName = 'YouPass';
  static const String apiBaseUrl = 'https://youpass-backend.vercel.app';
  static const String tokenKey = 'auth_token';
  static const String sessionIdKey = 'auth_session_id';
  static const String userKey = 'user_data';
  static const String userProfileKey = 'user_profile_data';
  static const Duration apiTimeout = Duration(seconds: 30);

  static const String categoryIdAll = 'all';
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
