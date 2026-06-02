import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/tickets/presentation/screens/my_tickets_screen.dart';
import 'package:youpass/l10n/app_localizations.dart';

void main() {
  testWidgets('MyTicketsScreen shows tabs and upcoming ticket card', (tester) async {
    final strings = lookupAppLocalizations(AppLocale.spanish);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const MyTicketsScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(strings.drawerMyTickets), findsOneWidget);
    expect(find.text(strings.ticketsTabUpcoming), findsOneWidget);
    expect(find.text(strings.ticketsTabPast), findsOneWidget);
    expect(find.text('Festival Verano 2026'), findsOneWidget);
    expect(find.text(strings.ticketsViewQr), findsWidgets);

    await tester.tap(find.text(strings.ticketsTabPast));
    await tester.pumpAndSettle();

    expect(find.text(strings.ticketsAttendedSectionTitle), findsOneWidget);
    expect(find.text('YouFest 2026'), findsOneWidget);
  });
}
