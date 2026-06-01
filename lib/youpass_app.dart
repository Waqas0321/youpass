import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/routes/app_routes.dart';
import 'package:youpass/routes/route_generator.dart';

class YouPassApp extends StatelessWidget {
  const YouPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(
          create: (_) => sl<LocaleProvider>(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => sl<AuthProvider>(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => sl<HomeProvider>(),
        ),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, _) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            locale: localeProvider.locale,
            supportedLocales: AppLocale.supported,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryMustard,
              ),
              scaffoldBackgroundColor: AppColors.backgroundWhite,
              useMaterial3: true,
              fontFamily: 'Roboto',
            ),
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: mediaQuery.textScaler.clamp(
                    minScaleFactor: 0.9,
                    maxScaleFactor: 1.15,
                  ),
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
            initialRoute: AppRoutes.splash,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }
}
