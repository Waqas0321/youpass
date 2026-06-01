import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/widgets/youpass_primary_button.dart';
import 'package:youpass/features/auth/presentation/screens/login_screen.dart';
import 'package:youpass/features/auth/presentation/screens/verification_screen.dart';
import 'package:youpass/features/auth/presentation/widgets/resend_code_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/verification_header_widget.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/routes/app_routes.dart';

import '../../../../helpers/auth_test_helper.dart';

void main() {
  testWidgets('VerificationScreen shows OTP UI in English', (tester) async {
    await tester.pumpWidget(
      AuthTestHelper.wrap(
        child: VerificationScreen(args: AuthTestHelper.testVerificationArgs),
      ),
    );
    await tester.pump();

    final strings = lookupAppLocalizations(AppLocale.english);
    expect(find.text(strings.verificationCodeTitle), findsOneWidget);
    expect(find.byType(VerificationHeaderWidget), findsOneWidget);
    expect(find.text(strings.validateCodeButton), findsOneWidget);
    expect(find.text(strings.changeNumberLink), findsOneWidget);
    expect(find.byType(ResendCodeWidget), findsOneWidget);
    expect(find.textContaining('01:00'), findsOneWidget);
  });

  testWidgets('VerificationScreen enables validate after six digits', (tester) async {
    await tester.pumpWidget(
      AuthTestHelper.wrap(
        child: VerificationScreen(args: AuthTestHelper.testVerificationArgs),
      ),
    );
    await tester.pump();

    final buttonFinder = find.byType(YouPassPrimaryButton);
    final button = tester.widget<YouPassPrimaryButton>(buttonFinder);
    expect(button.onPressed, isNull);

    await tester.enterText(find.byType(TextField), '123456');
    await tester.pump();

    final enabledButton = tester.widget<YouPassPrimaryButton>(buttonFinder);
    expect(enabledButton.onPressed, isNotNull);
  });

  testWidgets('VerificationScreen timer counts down', (tester) async {
    await tester.pumpWidget(
      AuthTestHelper.wrap(
        child: VerificationScreen(args: AuthTestHelper.testVerificationArgs),
      ),
    );
    await tester.pump();

    expect(find.textContaining('01:00'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.textContaining('00:59'), findsOneWidget);
  });

  testWidgets('VerificationScreen returns to login on change number', (tester) async {
    final strings = lookupAppLocalizations(AppLocale.english);

    await tester.pumpWidget(
      AuthTestHelper.wrap(
        child: const LoginScreen(),
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

    final changeNumberLink = find.text(strings.changeNumberLink);
    expect(changeNumberLink, findsOneWidget);
    await tester.ensureVisible(changeNumberLink);
    await tester.pumpAndSettle();
    await tester.tap(changeNumberLink);
    await tester.pumpAndSettle();

    expect(find.text(strings.welcomeBackTitle), findsOneWidget);
  });
}
