import 'package:flutter/material.dart';

import '../../ui.dart';

ThemeData getTheme({bool isDarkMode = false}) {
  final AppTheme appLightTheme = isDarkMode ? AppDarkTheme() : AppLightTheme();
  final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: appLightTheme.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: appLightTheme.primaryColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: appLightTheme.primaryColor,
    ),
    brightness: Brightness.light,
    extensions: <ThemeExtension<dynamic>>[appLightTheme],
    splashFactory: NoSplash.splashFactory,
  );
  return theme;
}

class AppLightTheme extends AppTheme {}

class AppDarkTheme extends AppTheme {}

abstract class AppTheme extends ThemeExtension<AppTheme> {
  @override
  ThemeExtension<AppTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppTheme> lerp(ThemeExtension<AppTheme>? other, double t) {
    return this;
  }

  Color get primaryColor => Colors.red;

  Color get backgroundColor => Colors.white;

  Color get successColor => Colors.green;

  Color get errorColor => Colors.redAccent;

  AppButtonTheme get primaryButtonTheme => AppButtonTheme(
        defaultColor: Colors.red,
        defaultTextColor: Colors.white,
        activeColor: Colors.red.shade900,
        activeTextColor: Colors.white,
        hoverColor: Colors.red.shade300,
        hoverTextColor: Colors.white,
      );

  AppButtonTheme get secondaryButtonTheme => AppButtonTheme(
        defaultColor: Colors.green,
        defaultTextColor: Colors.white,
        activeColor: Colors.green.shade900,
        activeTextColor: Colors.white,
        hoverColor: Colors.green.shade300,
        hoverTextColor: Colors.white,
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
