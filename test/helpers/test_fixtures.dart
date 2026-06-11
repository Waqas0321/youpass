import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/auth/data/models/profile_completeness_model.dart';
import 'package:youpass/features/auth/data/models/auth_session_model.dart';
import 'package:youpass/features/auth/data/models/send_code_response_model.dart';
import 'package:youpass/features/auth/domain/entities/whatsapp_check_result_entity.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'home_mock_data.dart';
import 'package:youpass/features/home/data/models/home_feed_model.dart';
import 'package:youpass/l10n/app_localizations.dart';

class TestFixtures {
  static const UserModel testUser = UserModel(
    id: 'test-1',
    email: 'test@youpass.com',
    name: 'test',
  );

  static final UserProfileModel testUserProfile = UserProfileModel(
    id: 'test-1',
    phone: '+56912345678',
    phoneDisplay: '+56 9 1234 5678',
    countryCode: 'CL',
    fullName: 'Alejandro Ruiz Tagle',
    email: 'alejandro@email.com',
    birthdate: '1995-06-15',
    gender: 'male',
    rutOrPassport: '12345678-9',
    instagramUsername: 'alerub',
    category: 'gold',
    accountStatus: 'active',
    createdAt: DateTime(2026, 6, 1),
    profileCompleteness: const ProfileCompletenessModel(
      hasPhoto: false,
      hasInstagram: true,
      completionPercentage: 70,
      missingFields: ['profile_photo'],
    ),
  );

  static final HomeFeedModel testHomeFeed = HomeMockData.buildFeed(
    labels: AppStrings.homeFeedLabels(
      lookupAppLocalizations(AppLocale.english),
    ),
  );

  static final HomeFeedEventsUpdate testFilteredHomeEvents =
      HomeFeedEventsUpdate(
    carouselEvents: testHomeFeed.carouselEvents,
    featuredEvents: testHomeFeed.featuredEvents,
  );

  static const String testPhone = '912345678';
  static const String testEmail = 'test@youpass.com';
  static const String testPassword = 'password123';
  static const String testToken = 'mock_token_test-1';

  static const AuthSessionModel testAuthSession = AuthSessionModel(
    accessToken: testToken,
    user: testUser,
  );

  static const WhatsAppCheckResultEntity testWhatsAppCheck =
      WhatsAppCheckResultEntity(
    phone: '+56912345678',
    whatsappAvailable: true,
    canReceiveOtp: true,
    deliveryChannel: 'whatsapp',
    message: 'Number is WhatsApp compatible',
  );

  static const SendCodeResponseModel testSendCodeResult = SendCodeResponseModel(
    message: 'Code sent via SMS',
    phone: '+56912345678',
    purpose: 'login',
    channel: 'whatsapp',
    expiresInSeconds: 180,
    resendAvailableInSeconds: 60,
    phoneDisplay: '+56 9 1234 5678',
    accountExists: true,
  );
}
