import 'package:flutter/painting.dart';

/// Corner radius tokens matching the pogo_alarm design standard.
abstract final class AppRadius {
  // ---------------------------------------------------------------------------
  // Numeric Radius Scale (logical px)
  // ---------------------------------------------------------------------------
  static const double none = 0.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double card = 16.0;
  static const double lg = 24.0;
  static const double pill = 999.0;
  static const double full = pill;

  // ---------------------------------------------------------------------------
  // Radius Objects
  // ---------------------------------------------------------------------------
  static const Radius xsR = Radius.circular(xs);
  static const Radius smR = Radius.circular(sm);
  static const Radius mdR = Radius.circular(md);
  static const Radius lgR = Radius.circular(lg);
  static const Radius pillR = Radius.circular(pill);

  // ---------------------------------------------------------------------------
  // Pre-computed BorderRadius
  // ---------------------------------------------------------------------------
  static const BorderRadius zero = BorderRadius.zero;
  static const BorderRadius xsAll = BorderRadius.all(xsR);
  static const BorderRadius smAll = BorderRadius.all(smR);
  static const BorderRadius mdAll = BorderRadius.all(mdR);
  static const BorderRadius cardAll = mdAll;
  static const BorderRadius lgAll = BorderRadius.all(lgR);
  static const BorderRadius pillAll = BorderRadius.all(pillR);

  static const BorderRadius topLg = BorderRadius.vertical(top: lgR);
  static const BorderRadius topMd = BorderRadius.vertical(top: mdR);
  static const BorderRadius bottomMd = BorderRadius.vertical(bottom: mdR);
}
