import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/auth/presentation/screens/login_screen.dart';
import 'package:youpass/features/auth/presentation/screens/verification_screen.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/routes/app_routes.dart';

import '../../../../helpers/auth_test_helper.dart';
import '../../../auth/mocks/mock_auth_repository.dart';

void main() {
  testWidgets('LoginScreen shows phone login UI in English', (tester) async {
    await tester.pumpWidget(
      AuthTestHelper.wrap(child: const LoginScreen()),
    );

    final strings = lookupAppLocalizations(AppLocale.english);
    expect(find.text(strings.welcomeBackTitle), findsOneWidget);
    expect(find.text(strings.phoneNumberLabel), findsOneWidget);
    expect(find.text(strings.sendCodeButton), findsOneWidget);
    expect(find.text(strings.createAccountLink), findsOneWidget);
    expect(find.text('+56'), findsOneWidget);
  });

  testWidgets('LoginScreen navigates to verification on send code success',
      (tester) async {
    final strings = lookupAppLocalizations(AppLocale.english);
    final mockAuthRepository = MockAuthRepository();
    AuthTestHelper.stubSendCodeSuccess(mockAuthRepository);

    await tester.pumpWidget(
      AuthTestHelper.wrap(
        child: const LoginScreen(),
        mockAuthRepository: mockAuthRepository,
        routes: {
          AppRoutes.verification: (_) => VerificationScreen(
                args: AuthTestHelper.testVerificationArgs,
              ),
        },
      ),
    );

    await tester.enterText(find.byType(TextField), '912345678');
    await tester.tap(find.text(strings.sendCodeButton));
    await tester.pumpAndSettle();

    expect(find.text(strings.verificationCodeTitle), findsOneWidget);
  });
}
