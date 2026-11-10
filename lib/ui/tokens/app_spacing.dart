import 'package:flutter/widgets.dart';

/// 4pt grid layout geometry and spacing tokens matching the pogo_alarm design standard.
abstract final class AppSpacing {
  // ---------------------------------------------------------------------------
  // 4pt Spacing Scale (logical px)
  // ---------------------------------------------------------------------------
  static const double s1 = 4.0;
  static const double s2 = 8.0;
  static const double s3 = 12.0;
  static const double s4 = 16.0;
  static const double s5 = 20.0;
  static const double s6 = 24.0;
  static const double s8 = 32.0;
  static const double s10 = 40.0;
  static const double s12 = 48.0;
  static const double s16 = 64.0;

  // ---------------------------------------------------------------------------
  // Semantic Aliases
  // ---------------------------------------------------------------------------
  static const double xs = s1;
  static const double s = s2;
  static const double sm = s2;
  static const double md = s3;
  static const double m = s4;
  static const double gutter = s4;
  static const double base = s6;
  static const double l = s8;
  static const double xl = s12;
  static const double xxl = s16;

  static const double hairlineThickness = 1.0;

  // ---------------------------------------------------------------------------
  // Pre-computed EdgeInsets
  // ---------------------------------------------------------------------------
  static const EdgeInsets zero = EdgeInsets.zero;
  static const EdgeInsets p4 = EdgeInsets.all(s1);
  static const EdgeInsets p8 = EdgeInsets.all(s2);
  static const EdgeInsets p12 = EdgeInsets.all(s3);
  static const EdgeInsets p16 = EdgeInsets.all(s4);
  static const EdgeInsets p20 = EdgeInsets.all(s5);
  static const EdgeInsets p24 = EdgeInsets.all(s6);
  static const EdgeInsets p32 = EdgeInsets.all(s8);

  static const EdgeInsets h8 = EdgeInsets.symmetric(horizontal: s2);
  static const EdgeInsets h12 = EdgeInsets.symmetric(horizontal: s3);
  static const EdgeInsets h16 = EdgeInsets.symmetric(horizontal: s4);
  static const EdgeInsets h20 = EdgeInsets.symmetric(horizontal: s5);
  static const EdgeInsets h24 = EdgeInsets.symmetric(horizontal: s6);

  static const EdgeInsets v8 = EdgeInsets.symmetric(vertical: s2);
  static const EdgeInsets v12 = EdgeInsets.symmetric(vertical: s3);
  static const EdgeInsets v16 = EdgeInsets.symmetric(vertical: s4);
  static const EdgeInsets v24 = EdgeInsets.symmetric(vertical: s6);

  static const EdgeInsets screenGutter = EdgeInsets.symmetric(
    horizontal: gutter,
    vertical: m,
  );
}
