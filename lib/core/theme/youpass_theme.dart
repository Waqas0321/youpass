import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';

class YouPassTheme {
  YouPassTheme._();

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryMustard,
      brightness: Brightness.light,
      surface: AppColors.backgroundWhite,
    );

    return _baseTheme(
      colorScheme: colorScheme,
      scaffoldBackground: AppColors.backgroundWhite,
      extension: YouPassThemeExtension.light,
    );
  }

  static ThemeData dark() {
    const scaffoldBackground = Color(0xFF000000);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.homeAccentYellow,
      brightness: Brightness.dark,
      surface: const Color(0xFF1A1A1A),
      onSurface: AppColors.backgroundWhite,
      onSurfaceVariant: const Color(0xFFB0B0B0),
    );

    return _baseTheme(
      colorScheme: colorScheme,
      scaffoldBackground: scaffoldBackground,
      extension: YouPassThemeExtension.dark,
    );
  }

  static ThemeData _baseTheme({
    required ColorScheme colorScheme,
    required Color scaffoldBackground,
    required YouPassThemeExtension extension,
  }) {
    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      useMaterial3: true,
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackground,
        surfaceTintColor: scaffoldBackground,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      extensions: [extension],
    );
  }
}
