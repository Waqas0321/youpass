import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/locale/app_locale.dart';
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
        if (authProvider != null)
          ChangeNotifierProvider<AuthProvider>.value(value: authProvider!),
        if (homeProvider != null)
          ChangeNotifierProvider<HomeProvider>.value(value: homeProvider!),
      ],
      child: MaterialApp(
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
