import 'package:flutter/material.dart';

import '../../ui/tokens/app_colors.dart';

ThemeData getTheme({bool isDarkMode = false}) {
  final AppColors colors =
      isDarkMode ? const AppDarkColors() : const AppLightColors();
  final AppTheme appTheme = isDarkMode ? AppDarkTheme() : AppLightTheme();

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: colors.bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.accent,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      surface: colors.surface1,
    ),
    extensions: <ThemeExtension<dynamic>>[appTheme],
    appBarTheme: AppBarTheme(
      backgroundColor: colors.bg,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: colors.text),
      titleTextStyle: TextStyle(
        color: colors.text,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colors.surface1,
      selectedItemColor: colors.accent,
      unselectedItemColor: colors.text3,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
    splashFactory: NoSplash.splashFactory,
  );
}

class AppLightTheme extends AppTheme {}

class AppDarkTheme extends AppTheme {}

abstract class AppTheme extends ThemeExtension<AppTheme> {
  @override
  ThemeExtension<AppTheme> copyWith() => this;

  @override
  ThemeExtension<AppTheme> lerp(ThemeExtension<AppTheme>? other, double t) =>
      this;

  Color get primaryColor => const Color(0xFFF5A623);
  Color get backgroundColor => const Color(0xFFFFFBF5);
  Color get successColor => const Color(0xFF2ECC71);
  Color get errorColor => const Color(0xFFE55353);

  AppButtonTheme get primaryButtonTheme => AppButtonTheme(
        defaultColor: const Color(0xFF382E6B),
        defaultTextColor: Colors.white,
        activeColor: const Color(0xFF2E245E),
        activeTextColor: Colors.white,
        hoverColor: const Color(0xFF4C3F8C),
        hoverTextColor: Colors.white,
      );

  AppButtonTheme get secondaryButtonTheme => AppButtonTheme(
        defaultColor: const Color(0xFFF5A623),
        defaultTextColor: const Color(0xFF28231D),
        activeColor: const Color(0xFFD98200),
        activeTextColor: Colors.white,
        hoverColor: const Color(0xFFFFB830),
        hoverTextColor: const Color(0xFF28231D),
      );
}

class AppButtonTheme {
  AppButtonTheme({
    required this.defaultColor,
    this.activeColor,
    this.hoverColor,
    required this.defaultTextColor,
    this.activeTextColor,
    this.hoverTextColor,
  });

  final Color defaultColor;
  final Color? activeColor;
  final Color? hoverColor;
  final Color defaultTextColor;
  final Color? activeTextColor;
  final Color? hoverTextColor;
}
