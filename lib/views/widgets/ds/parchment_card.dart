import 'package:flutter/material.dart';

import '../../../ui/tokens/app_radius.dart';
import '../../../ui/tokens/app_spacing.dart';
import '../extensions.dart';

/// Antique scroll/parchment container for docket sections, arguments, and cards.
class ParchmentCard extends StatelessWidget {
  const ParchmentCard({
    super.key,
    required this.child,
    this.padding = AppSpacing.p16,
    this.margin,
    this.onTap,
    this.hasBorder = true,
    this.elevation = 2.0,
  });

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final bool hasBorder;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final cardDecoration = BoxDecoration(
      color: colors.parchmentCream,
      borderRadius: AppRadius.mdAll,
      border: hasBorder
          ? Border.all(
              color: colors.parchmentBorder,
              width: AppSpacing.hairlineThickness * 1.5,
            )
          : null,
      boxShadow: elevation > 0
          ? [
              BoxShadow(
                color: const Color(0x1E1A2238),
                blurRadius: elevation * 3.0,
                offset: Offset(0, elevation),
              ),
            ]
          : null,
    );

    final cardContent = Container(
      margin: margin,
      padding: padding,
      decoration: cardDecoration,
      child: child,
    );

    if (onTap == null) {
      return cardContent;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.mdAll,
        child: cardContent,
      ),
    );
  }
}
