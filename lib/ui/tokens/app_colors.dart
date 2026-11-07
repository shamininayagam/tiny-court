import 'package:flutter/material.dart';

/// Semantic courtroom color tokens adhering to the design system specification.
///
/// Combines traditional judicial solemnity with comical cartoon warmth:
/// - Court Navy: Deep podium and header surfaces.
/// - Gavel Gold: Primary actions, accent gavels, and highlights.
/// - Parchment Cream: Scroll containers, argument duel cards.
/// - Verdict Stamps: Guilty Red, Acquittal Green, Mutual Orange, Contempt Purple.
abstract class AppColors {
  const AppColors();

  // ---------------------------------------------------------------------------
  // Core Courtroom Palette
  // ---------------------------------------------------------------------------
  Color get courtNavy => const Color(0xFF1A2238);
  Color get courtNavyLight => const Color(0xFF263252);
  Color get gavelGold => const Color(0xFFE6B042);
  Color get gavelGoldDark => const Color(0xFFC4932D);
  Color get parchmentCream => const Color(0xFFFBF8F1);
  Color get parchmentBorder => const Color(0xFFE8DFD0);
  Color get walnutWood => const Color(0xFF3D2314);
  Color get inkBlack => const Color(0xFF1C1B1F);

  // Verdict Stamp Colors
  Color get guiltyRed => const Color(0xFFD32F2F);
  Color get acquittalGreen => const Color(0xFF2E7D32);
  Color get mutualOrange => const Color(0xFFE65100);
  Color get contemptPurple => const Color(0xFF6A1B9A);

  // ---------------------------------------------------------------------------
  // Canvas & Surfaces
  // ---------------------------------------------------------------------------
  Color get bg;
  Color get surface1;
  Color get surface2;
  Color get surface3;

  // ---------------------------------------------------------------------------
  // Hairlines & Borders
  // ---------------------------------------------------------------------------
  Color get hairline;
  Color get hairlineStrong;

  // ---------------------------------------------------------------------------
  // Text Tiers
  // ---------------------------------------------------------------------------
  Color get text;
  Color get text2;
  Color get text3;
  Color get textOnLight;

  // ---------------------------------------------------------------------------
  // Semantic Accents
  // ---------------------------------------------------------------------------
  Color get accent;
  Color get accentHi;
  Color get danger;
  Color get ok;
  Color get warn;
  Color get info;
}

/// Dark courtroom theme colors (Default / Night Mode).
class AppDarkColors extends AppColors {
  const AppDarkColors();

  @override
  Color get bg => const Color(0xFF111726);

  @override
  Color get surface1 => const Color(0xFF1A2238);

  @override
  Color get surface2 => const Color(0xFF263252);

  @override
  Color get surface3 => const Color(0xFF323F66);

  @override
  Color get hairline => Colors.white.withValues(alpha: 0.10);

  @override
  Color get hairlineStrong => Colors.white.withValues(alpha: 0.20);

  @override
  Color get text => const Color(0xFFFBF8F1);

  @override
  Color get text2 => const Color(0xFFB0B7C6);

  @override
  Color get text3 => const Color(0xFF6E788F);

  @override
  Color get textOnLight => const Color(0xFF1C1B1F);

  @override
  Color get accent => const Color(0xFFE6B042);

  @override
  Color get accentHi => const Color(0xFFFFD56B);

  @override
  Color get danger => const Color(0xFFD32F2F);

  @override
  Color get ok => const Color(0xFF2E7D32);

  @override
  Color get warn => const Color(0xFFE65100);

  @override
  Color get info => const Color(0xFF29B6F6);
}

/// Light courtroom theme colors (Parchment Mode).
class AppLightColors extends AppColors {
  const AppLightColors();

  @override
  Color get bg => const Color(0xFFF7F4EC);

  @override
  Color get surface1 => const Color(0xFFFFFFFF);

  @override
  Color get surface2 => const Color(0xFFFBF8F1);

  @override
  Color get surface3 => const Color(0xFFECE6D8);

  @override
  Color get hairline => const Color(0xFFE8DFD0);

  @override
  Color get hairlineStrong => const Color(0xFFD0C3AF);

  @override
  Color get text => const Color(0xFF1C1B1F);

  @override
  Color get text2 => const Color(0xFF4A494E);

  @override
  Color get text3 => const Color(0xFF7A7980);

  @override
  Color get textOnLight => const Color(0xFF1C1B1F);

  @override
  Color get accent => const Color(0xFFC4932D);

  @override
  Color get accentHi => const Color(0xFFE6B042);

  @override
  Color get danger => const Color(0xFFD32F2F);

  @override
  Color get ok => const Color(0xFF2E7D32);

  @override
  Color get warn => const Color(0xFFE65100);

  @override
  Color get info => const Color(0xFF0288D1);
}
