import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/l10n/app_localizations.dart';

class LocalizationTestHelper {
  LocalizationTestHelper._();

  static Widget wrap({
    required Widget child,
    Locale locale = AppLocale.defaultLocale,
    Map<String, WidgetBuilder>? routes,
    String? initialRoute,
  }) {
    return MaterialApp(
      locale: locale,
      supportedLocales: AppLocale.supported,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: initialRoute == null ? child : null,
      routes: routes ?? const {},
      initialRoute: initialRoute,
    );
  }
}
