import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/widgets/youpass_confirm_dialog.dart';
import 'package:youpass/l10n/app_localizations.dart';

import '../../helpers/auth_test_helper.dart';

void main() {
  testWidgets('showLogout displays themed dialog and returns on confirm',
      (tester) async {
    final strings = lookupAppLocalizations(AppLocale.english);
    bool? confirmed;

    await tester.pumpWidget(
      AuthTestHelper.wrap(
        child: Builder(
          builder: (context) {
            return Scaffold(
              body: ElevatedButton(
                onPressed: () async {
                  confirmed = await YouPassConfirmDialog.showLogout(context);
                },
                child: const Text('Open'),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text(strings.confirmLogoutTitle), findsOneWidget);
    expect(find.text(strings.confirmLogoutMessage), findsOneWidget);

    await tester.tap(find.text(strings.confirmLogoutAction));
    await tester.pumpAndSettle();

    expect(confirmed, isTrue);
  });
}
