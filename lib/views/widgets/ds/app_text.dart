import 'package:flutter/material.dart';

import '../../../ui/tokens/app_typography.dart';
import '../extensions.dart';

/// Standardized typography widget adhering to the courtroom design tokens.
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.style = AppTextStyle.bodyMedium,
    this.color,
    this.align,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.letterSpacing,
    this.italic = false,
  });

  final String text;
  final AppTextStyle style;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final bool italic;

  @override
  Widget build(BuildContext context) {
    final TextStyle base = AppTypography.resolve(style);
    final TextStyle resolved = base.copyWith(
      color: color ?? context.colors.text,
      fontWeight: fontWeight ?? base.fontWeight,
      letterSpacing: letterSpacing ?? base.letterSpacing,
      fontStyle: italic ? FontStyle.italic : base.fontStyle,
    );

    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: resolved,
    );
  }
}
