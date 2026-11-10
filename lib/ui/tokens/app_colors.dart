import 'package:flutter/material.dart';

/// Semantic courtroom color tokens adhering to the whimsical, cozy cartoon design system.
///
/// Features:
/// - Warm Cream Parchment: Airy, cozy canvas for pleasant reading.
/// - Royal Indigo: High-contrast primary action pill buttons.
/// - Honey Amber / Gavel Gold: Warm CTA, gavel strikes, highlights.
/// - Character Badges: Plaintiff Rose (Pink) vs Defendant Periwinkle (Blue).
/// - Mint Green: Decided / Not Guilty celebration badges.
abstract class AppColors {
  const AppColors();

  // ---------------------------------------------------------------------------
  // Core Whimsical Courtroom Palette
  // ---------------------------------------------------------------------------
  Color get courtNavy => const Color(0xFF1A2238);
  Color get courtNavyLight => const Color(0xFF263252);
  Color get gavelGold => const Color(0xFFF5A623);
  Color get gavelGoldDark => const Color(0xFFD98200);
  Color get parchmentCream => const Color(0xFFFFFBF5);
  Color get parchmentBorder => const Color(0xFFEFE8DB);
  Color get walnutWood => const Color(0xFF3D2314);
  Color get inkBlack => const Color(0xFF28231D);

  // Royal Indigo & Honey Accents
  Color get royalIndigo => const Color(0xFF382E6B);
  Color get royalIndigoLight => const Color(0xFF4C3F8C);
  Color get honeyGold => const Color(0xFFF5A623);
  Color get bookmarkYellow => const Color(0xFFFFB830);
  Color get curtainRed => const Color(0xFF8B2522);

  // Character & Verdict Accents
  Color get plaintiffRose => const Color(0xFFFCE8E8);
  Color get plaintiffRed => const Color(0xFFE55353);
  Color get defendantPeriwinkle => const Color(0xFFE8EEFF);
  Color get defendantBlue => const Color(0xFF4C6EF5);
  Color get mintGreen => const Color(0xFFE6F9F0);
  Color get mintGreenDark => const Color(0xFF1B9E5A);

  // Verdict Stamp Colors
  Color get guiltyRed => const Color(0xFFE55353);
  Color get acquittalGreen => const Color(0xFF2ECC71);
  Color get mutualOrange => const Color(0xFFF5A623);
  Color get contemptPurple => const Color(0xFF8E44AD);

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

/// Light courtroom theme colors (Default / Cozy Parchment Mode from UI Mockup).
class AppLightColors extends AppColors {
  const AppLightColors();

  @override
  Color get bg => const Color(0xFFFFFBF5);

  @override
  Color get surface1 => const Color(0xFFFFFFFF);

  @override
  Color get surface2 => const Color(0xFFF9F5EC);

  @override
  Color get surface3 => const Color(0xFFEFE8DB);

  @override
  Color get hairline => const Color(0xFFF0E9DC);

  @override
  Color get hairlineStrong => const Color(0xFFDED4C3);

  @override
  Color get text => const Color(0xFF28231D);

  @override
  Color get text2 => const Color(0xFF6E6A75);

  @override
  Color get text3 => const Color(0xFFA8A3AF);

  @override
  Color get textOnLight => const Color(0xFF28231D);

  @override
  Color get accent => const Color(0xFFF5A623);

  @override
  Color get accentHi => const Color(0xFFFFB830);

  @override
  Color get danger => const Color(0xFFE55353);

  @override
  Color get ok => const Color(0xFF2ECC71);

  @override
  Color get warn => const Color(0xFFF5A623);

  @override
  Color get info => const Color(0xFF4C6EF5);
}

/// Dark courtroom theme colors (Stage / Dramatic Mode).
class AppDarkColors extends AppColors {
  const AppDarkColors();

  @override
  Color get bg => const Color(0xFF1B1424);

  @override
  Color get surface1 => const Color(0xFF271C33);

  @override
  Color get surface2 => const Color(0xFF332542);

  @override
  Color get surface3 => const Color(0xFF413054);

  @override
  Color get hairline => const Color(0xFF48375C);

  @override
  Color get hairlineStrong => const Color(0xFF5F4A78);

  @override
  Color get text => const Color(0xFFFFFBF5);

  @override
  Color get text2 => const Color(0xFFC7BFCF);

  @override
  Color get text3 => const Color(0xFF8E8499);

  @override
  Color get textOnLight => const Color(0xFF28231D);

  @override
  Color get accent => const Color(0xFFFFB830);

  @override
  Color get accentHi => const Color(0xFFFFD56B);

  @override
  Color get danger => const Color(0xFFE55353);

  @override
  Color get ok => const Color(0xFF2ECC71);

  @override
  Color get warn => const Color(0xFFF5A623);

  @override
  Color get info => const Color(0xFF748FFC);
}
