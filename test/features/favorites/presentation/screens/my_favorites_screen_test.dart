import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/favorites/presentation/screens/my_favorites_screen.dart';
import 'package:youpass/l10n/app_localizations.dart';

void main() {
  testWidgets('MyFavoritesScreen shows localized favorites UI', (tester) async {
    final strings = lookupAppLocalizations(AppLocale.spanish);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const MyFavoritesScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(strings.drawerMyFavorites), findsWidgets);
    expect(find.text(strings.favoritesSubtitle), findsOneWidget);
    expect(find.text('YouFest'), findsOneWidget);
    expect(find.text('IGUANA'), findsOneWidget);
    expect(find.text(strings.favoritesViewEvents), findsWidgets);
  });
}
