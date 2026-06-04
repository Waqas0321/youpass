import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/theme/domain/repositories/theme_preference_repository.dart';
import 'package:youpass/core/theme/presentation/providers/app_theme_provider.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/routes/route_generator.dart';

class TestAppWrapper extends StatelessWidget {
  const TestAppWrapper({
    super.key,
    required this.child,
    this.authProvider,
    this.homeProvider,
    this.initialRoute,
  });

  final Widget child;
  final AuthProvider? authProvider;
  final HomeProvider? homeProvider;
  final String? initialRoute;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider(sl<ThemePreferenceRepository>()),
        ),
        if (authProvider != null)
          ChangeNotifierProvider<AuthProvider>.value(value: authProvider!),
        if (homeProvider != null)
          ChangeNotifierProvider<HomeProvider>.value(value: homeProvider!),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
        locale: AppLocale.defaultLocale,
        supportedLocales: AppLocale.supported,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: child,
        initialRoute: initialRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
