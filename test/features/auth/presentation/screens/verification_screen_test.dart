import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/auth/presentation/screens/login_screen.dart';
import 'package:youpass/features/auth/presentation/screens/verification_screen.dart';
import 'package:youpass/features/auth/presentation/widgets/resend_code_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/verification_header_widget.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/routes/app_routes.dart';

import '../../../../helpers/localization_test_helper.dart';

void main() {
  testWidgets('VerificationScreen shows OTP UI in English', (tester) async {
    await tester.pumpWidget(
      LocalizationTestHelper.wrap(child: const VerificationScreen()),
    );

    final strings = lookupAppLocalizations(AppLocale.english);
    expect(find.text(strings.verificationCodeTitle), findsOneWidget);
    expect(find.byType(VerificationHeaderWidget), findsOneWidget);
    expect(find.text(strings.validateCodeButton), findsOneWidget);
    expect(find.text(strings.changeNumberLink), findsOneWidget);
    expect(find.byType(ResendCodeWidget), findsOneWidget);
  });

  testWidgets('VerificationScreen returns to login on change number', (tester) async {
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

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text(strings.welcomeBackTitle), findsOneWidget);
  });
}
