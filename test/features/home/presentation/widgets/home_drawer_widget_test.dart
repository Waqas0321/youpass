import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/home/domain/entities/drawer_membership_tier.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/home_drawer_widget.dart';
import 'package:youpass/l10n/app_localizations.dart';

import '../../../../helpers/localization_test_helper.dart';

void main() {
  testWidgets('HomeDrawerWidget shows profile and menu labels in spec order', (tester) async {
    final strings = lookupAppLocalizations(AppLocale.english);

    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: Scaffold(
          drawerEnableOpenDragGesture: false,
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                child: const Text('Open'),
              );
            },
          ),
          drawer: const HomeDrawerWidget(
            firstName: 'Alejandro',
            tier: DrawerMembershipTier.gold,
            invitationsBadgeCount: 3,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Alejandro'), findsOneWidget);
    expect(find.text(strings.drawerTierGold), findsOneWidget);
    expect(find.text(strings.drawerInvitations), findsOneWidget);
    expect(find.text(strings.drawerMyProfile), findsOneWidget);
    expect(find.text(strings.drawerMyTickets), findsOneWidget);
    expect(find.text(strings.drawerMyFavorites), findsOneWidget);
    expect(find.text(strings.drawerInvitationsNewBadge(3)), findsOneWidget);

    final invitationsFinder = find.text(strings.drawerInvitations);
    final favoritesFinder = find.text(strings.drawerMyFavorites);
    expect(
      tester.getTopLeft(invitationsFinder).dy,
      greaterThan(tester.getTopLeft(favoritesFinder).dy),
    );
  });
}
