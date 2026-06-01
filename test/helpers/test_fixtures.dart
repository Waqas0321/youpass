import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/auth/data/models/send_code_response_model.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/home/data/datasources/home_mock_data.dart';
import 'package:youpass/features/home/data/models/home_feed_model.dart';
import 'package:youpass/l10n/app_localizations.dart';

class TestFixtures {
  static const UserModel testUser = UserModel(
    id: 'test-1',
    email: 'test@youpass.com',
    name: 'test',
  );

  static final HomeFeedModel testHomeFeed = HomeMockData.buildFeed(
    labels: AppStrings.homeFeedLabels(
      lookupAppLocalizations(AppLocale.english),
    ),
  );

  static const String testPhone = '912345678';
  static const String testEmail = 'test@youpass.com';
  static const String testPassword = 'password123';
  static const String testToken = 'mock_token_test-1';

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
