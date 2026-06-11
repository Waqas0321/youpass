import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/core/theme/domain/repositories/theme_preference_repository.dart';
import 'package:youpass/core/theme/presentation/providers/app_theme_provider.dart';
import 'package:youpass/core/theme/youpass_theme.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_provider.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_provider.dart';
import 'package:youpass/features/vip_venue/presentation/providers/vip_venue_provider.dart';
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
        ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider(sl<ThemePreferenceRepository>()),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => sl<AuthProvider>(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => sl<HomeProvider>(),
        ),
        ChangeNotifierProvider<InvitationsProvider>(
          create: (_) => sl<InvitationsProvider>(),
        ),
        ChangeNotifierProvider<TicketsProvider>(
          create: (_) => sl<TicketsProvider>(),
        ),
        ChangeNotifierProvider<TicketAssignmentProvider>(
          create: (_) => sl<TicketAssignmentProvider>(),
        ),
        ChangeNotifierProvider<VipVenueProvider>(
          create: (_) => sl<VipVenueProvider>(),
        ),
      ],
      child: Consumer2<LocaleProvider, AppThemeProvider>(
        builder: (context, localeProvider, themeProvider, _) {
          final isDark = themeProvider.themeMode == ThemeMode.dark;

          final materialLocale = _resolveMaterialLocale(localeProvider.locale);

          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            locale: materialLocale,
            supportedLocales: AppLocale.supported,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              return materialLocale;
            },
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: YouPassTheme.light(),
            darkTheme: YouPassTheme.dark(),
            themeMode: themeProvider.themeMode,
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
                  statusBarIconBrightness:
                      isDark ? Brightness.light : Brightness.dark,
                  systemNavigationBarColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  systemNavigationBarIconBrightness:
                      isDark ? Brightness.light : Brightness.dark,
                ),
                child: MediaQuery(
                  data: mediaQuery.copyWith(
                    textScaler: mediaQuery.textScaler.clamp(
                      minScaleFactor: 0.9,
                      maxScaleFactor: 1.15,
                    ),
                  ),
                  child: child ?? const SizedBox.shrink(),
                ),
              );
            },
            initialRoute: AppRoutes.splash,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }

  static Locale _resolveMaterialLocale(Locale locale) {
    if (locale.languageCode == 'pt') {
      return AppLocale.spanish;
    }
    return AppLocale.resolveSupported(locale);
  }
}
