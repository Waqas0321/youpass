import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/auth/presentation/screens/login_screen.dart';
import 'package:youpass/features/auth/presentation/screens/verification_screen.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/routes/app_routes.dart';

import '../../../../helpers/localization_test_helper.dart';

void main() {
  testWidgets('LoginScreen shows phone login UI in English', (tester) async {
    await tester.pumpWidget(
      LocalizationTestHelper.wrap(child: const LoginScreen()),
    );

    final strings = lookupAppLocalizations(AppLocale.english);
    expect(find.text(strings.welcomeBackTitle), findsOneWidget);
    expect(find.text(strings.phoneNumberLabel), findsOneWidget);
    expect(find.text(strings.sendCodeButton), findsOneWidget);
    expect(find.text(strings.createAccountLink), findsOneWidget);
    expect(find.text('+56'), findsOneWidget);
  });

  testWidgets('LoginScreen navigates to verification on button tap', (tester) async {
    final strings = lookupAppLocalizations(AppLocale.english);

    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: const LoginScreen(),
        routes: {
          AppRoutes.verification: (_) => const VerificationScreen(),
        },
      ),
    );

    await tester.tap(find.text(strings.sendCodeButton));
    await tester.pumpAndSettle();

    expect(find.text(strings.verificationCodeTitle), findsOneWidget);
  });
}
