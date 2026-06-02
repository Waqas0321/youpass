import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/auth/data/models/profile_completeness_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/profile/presentation/utils/profile_view_data_factory.dart';
import 'package:youpass/l10n/app_localizations.dart';

void main() {
  test('formats ISO birthdate for profile display', () {
    final strings = lookupAppLocalizations(AppLocale.english);
    final profile = UserProfileModel(
      id: 'user-1',
      phone: '+923216548001',
      phoneDisplay: '+92 321 6548001',
      countryCode: 'PK',
      fullName: 'Waqas Akhtar',
      email: 'waqasakhtar548@gmail.com',
      birthdate: '2003-06-02T00:00:00.000+00:00',
      gender: 'male',
      rutOrPassport: '0987655544444',
      instagramUsername: 'Waqas0321',
      category: 'bronze',
      accountStatus: 'active',
      createdAt: DateTime(2026, 6, 2),
      profileCompleteness: const ProfileCompletenessModel(
        hasPhoto: false,
        hasInstagram: true,
        completionPercentage: 70,
        missingFields: ['profile_photo'],
      ),
    );

    final data = ProfileViewDataFactory.build(strings, profile: profile);

    expect(data.birthDate, '02 / 06 / 2003');
    expect(data.gender, strings.genderMale);
    expect(data.instagramHandle, '@Waqas0321');
  });
}
