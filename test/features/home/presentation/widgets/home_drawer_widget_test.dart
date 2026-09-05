import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/theme/domain/repositories/theme_preference_repository.dart';
import 'package:youpass/core/theme/presentation/providers/app_theme_provider.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/home_drawer_widget.dart';
import 'package:youpass/l10n/app_localizations.dart';

class _FakeThemePreferenceRepository implements ThemePreferenceRepository {
  @override
  bool loadFiestaMode() => false;

  @override
  Future<void> saveFiestaMode(bool enabled) async {}

  @override
  Future<void> migrateFiestaMode(bool enabled) async {}
}

Widget _wrapDrawer({
  required Widget child,
  AppThemeProvider? themeProvider,
  ThemeMode themeMode = ThemeMode.light,
}) {
  final provider =
      themeProvider ?? AppThemeProvider(_FakeThemePreferenceRepository());

  return ChangeNotifierProvider<AppThemeProvider>.value(
    value: provider,
    child: MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: AppLocale.defaultLocale,
      supportedLocales: AppLocale.supported,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: child,
    ),
  );
}

void main() {
  testWidgets('HomeDrawerWidget shows menu labels in spec order', (tester) async {
    final strings = lookupAppLocalizations(AppLocale.english);

    await tester.pumpWidget(
      _wrapDrawer(
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
            invitationsBadgeCount: 3,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text(strings.drawerHome), findsOneWidget);
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

  testWidgets('HomeDrawerWidget shows party mode menu when fiesta mode is on',
      (tester) async {
    final strings = lookupAppLocalizations(AppLocale.english);
    final themeProvider = AppThemeProvider(_FakeThemePreferenceRepository())
      ..isFiestaMode = true;

    await tester.pumpWidget(
      _wrapDrawer(
        themeProvider: themeProvider,
        themeMode: ThemeMode.dark,
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
          drawer: const HomeDrawerWidget(),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text(strings.drawerHome), findsNothing);
    expect(find.text(strings.drawerMyFavorites), findsNothing);
    expect(find.text(strings.drawerMyTickets), findsNothing);
    expect(find.text(strings.drawerInvitations), findsNothing);
    expect(find.text(strings.drawerMyProfile), findsNothing);
    expect(find.text(strings.drawerDrinkMenu), findsOneWidget);
    expect(find.text(strings.drawerMyPurchases), findsOneWidget);
    expect(find.text(strings.invitationsFilterCourtesy), findsOneWidget);
    expect(find.text(strings.profileLogout), findsNothing);

    final drinkMenuFinder = find.text(strings.drawerDrinkMenu);
    final purchasesFinder = find.text(strings.drawerMyPurchases);
    final cortesiasFinder = find.text(strings.invitationsFilterCourtesy);

    expect(
      tester.getTopLeft(purchasesFinder).dy,
      greaterThan(tester.getTopLeft(drinkMenuFinder).dy),
    );
    expect(
      tester.getTopLeft(cortesiasFinder).dy,
      greaterThan(tester.getTopLeft(purchasesFinder).dy),
    );
  });

  testWidgets('HomeDrawerWidget party mode menu uses Spanish locale strings',
      (tester) async {
    final strings = lookupAppLocalizations(AppLocale.spanish);
    final themeProvider = AppThemeProvider(_FakeThemePreferenceRepository())
      ..isFiestaMode = true;

    await tester.pumpWidget(
      ChangeNotifierProvider<AppThemeProvider>.value(
        value: themeProvider,
        child: MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          locale: AppLocale.spanish,
          supportedLocales: AppLocale.supported,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Scaffold(
            drawerEnableOpenDragGesture: false,
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  child: const Text('Open'),
                );
              },
            ),
            drawer: const HomeDrawerWidget(),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text(strings.drawerMyProfile), findsNothing);
    expect(find.text('Carta de tragos'), findsOneWidget);
    expect(find.text('Mis compras'), findsOneWidget);
    expect(find.text('Cortesías'), findsOneWidget);
    expect(find.text(strings.profileLogout), findsNothing);
  });
}
