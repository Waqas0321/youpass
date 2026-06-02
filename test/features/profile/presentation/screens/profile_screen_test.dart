import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/profile/presentation/screens/profile_screen.dart';
import 'package:youpass/l10n/app_localizations.dart';

import '../../../../helpers/auth_test_helper.dart';
import '../../../../helpers/test_fixtures.dart';
import '../../../auth/mocks/mock_auth_repository.dart';

void main() {
  testWidgets('ProfileScreen shows localized sections in English', (tester) async {
    final strings = lookupAppLocalizations(AppLocale.english);
    final mockAuthRepository = MockAuthRepository();

    when(() => mockAuthRepository.getCachedUserProfile())
        .thenAnswer((_) async => null);
    when(() => mockAuthRepository.refreshUserProfile())
        .thenAnswer((_) async => TestFixtures.testUserProfile);

    await tester.pumpWidget(
      AuthTestHelper.wrap(
        mockAuthRepository: mockAuthRepository,
        child: const ProfileScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(strings.profileTitle), findsOneWidget);
    expect(find.text(strings.profilePersonalData), findsOneWidget);
    expect(find.text(strings.profileWalletSection), findsOneWidget);
    expect(find.text(strings.profileNotifications), findsOneWidget);
    expect(find.text(strings.profileSupport), findsOneWidget);
    expect(find.text(strings.profileLogout), findsOneWidget);
    expect(find.text('15 / 06 / 1995'), findsOneWidget);
    expect(find.text(strings.genderMale), findsOneWidget);
    expect(find.text('@alerub'), findsOneWidget);
  });
}
