class AppConstants {
  static const String appName = 'YouPass';
  static const String apiBaseUrl = 'https://youpass-backend.vercel.app';
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration homeMockFetchDelay = Duration(milliseconds: 400);

  static const String categoryIdChile = 'chile';
  static const String categoryIdParties = 'parties';
  static const String categoryIdConcerts = 'concerts';
  static const String categoryIdSports = 'sports';
  static const String defaultHomeCategoryId = categoryIdChile;

  static const String featuredEventIdPrimavera = 'primavera-2026';
  static const String featuredEventIdSummerBeats = 'summer-beats';
  static const String featuredEventIdUrbanNight = 'urban-night';

  static const String eventIdCaribeNight = 'caribe-night';
  static const String eventIdRockAlParque = 'rock-al-parque';

  static const double countryPickerSheetHeightFactor = 0.85;
}
