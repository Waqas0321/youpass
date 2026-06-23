import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/widgets/youpass_primary_button.dart';
import 'package:youpass/features/auth/presentation/screens/register_screen.dart';
import 'package:youpass/features/auth/presentation/widgets/register_form_widget.dart';
import 'package:youpass/features/auth/routes/register_route_args.dart';
import 'package:youpass/l10n/app_localizations.dart';

import '../../../../helpers/auth_test_helper.dart';

void main() {
  testWidgets('RegisterScreen shows create account UI in English', (tester) async {
    await tester.pumpWidget(
      AuthTestHelper.wrap(child: const RegisterScreen()),
    );

    final strings = lookupAppLocalizations(AppLocale.english);
    expect(find.text(strings.backButton), findsOneWidget);
    expect(find.text(strings.phoneLoginSubtitle), findsOneWidget);
    expect(find.text(strings.sendCodeButton), findsOneWidget);
    expect(find.byType(YouPassPrimaryButton), findsOneWidget);
    expect(find.text(strings.signInLink), findsOneWidget);
  });

  testWidgets('RegisterScreen opens gender picker on tap', (tester) async {
    tester.view.physicalSize = const Size(480, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      AuthTestHelper.wrap(
        child: Scaffold(
          body: SingleChildScrollView(
            child: const RegisterFormWidget(
              routeArgs: RegisterRouteArgs(
                phone: '912345678',
                otpCode: '123456',
              ),
            ),
          ),
        ),
      ),
    );

    final strings = lookupAppLocalizations(AppLocale.english);
    final genderOption = find.text(strings.genderMale);

    await tester.ensureVisible(genderOption);
    await tester.pumpAndSettle();
    await tester.tap(genderOption);
    await tester.pumpAndSettle();

    expect(find.text(strings.genderMale), findsOneWidget);
  });
}
