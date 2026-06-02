import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/home_drawer_widget.dart';
import 'package:youpass/l10n/app_localizations.dart';

import '../../../../helpers/localization_test_helper.dart';

void main() {
  testWidgets('HomeDrawerWidget shows profile and menu labels', (tester) async {
    final strings = lookupAppLocalizations(AppLocale.english);

    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                child: const Text('Open'),
              );
            },
          ),
          drawer: const HomeDrawerWidget(userName: 'Alejandro'),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Alejandro'), findsOneWidget);
    expect(find.text(strings.drawerMyProfile), findsOneWidget);
    expect(find.text(strings.drawerInvitations), findsOneWidget);
    expect(find.text(strings.drawerInvitationsNewBadge(3)), findsOneWidget);
  });
}
