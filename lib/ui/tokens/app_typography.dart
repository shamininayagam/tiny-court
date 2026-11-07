import 'package:flutter/material.dart';

/// Semantic typography styles for the courtroom experience.
enum AppTextStyle {
  headlineLarge,
  headlineMedium,
  titleLarge,
  titleMedium,
  bodyLarge,
  bodyMedium,
  caption,
  stamp,
  label,
}

abstract final class AppTypography {
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Georgia',
    fontSize: 28.0,
    fontWeight: FontWeight.w900,
    height: 1.25,
    letterSpacing: -0.5,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Georgia',
    fontSize: 22.0,
    fontWeight: FontWeight.w800,
    height: 1.3,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    height: 1.35,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.45,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.35,
  );

  static const TextStyle stamp = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.5,
    height: 1.1,
  );

  static const TextStyle label = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static TextStyle resolve(AppTextStyle style) => switch (style) {
        AppTextStyle.headlineLarge => headlineLarge,
        AppTextStyle.headlineMedium => headlineMedium,
        AppTextStyle.titleLarge => titleLarge,
        AppTextStyle.titleMedium => titleMedium,
        AppTextStyle.bodyLarge => bodyLarge,
        AppTextStyle.bodyMedium => bodyMedium,
        AppTextStyle.caption => caption,
        AppTextStyle.stamp => stamp,
        AppTextStyle.label => label,
      };
}
