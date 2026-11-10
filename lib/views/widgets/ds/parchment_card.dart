import 'package:flutter/material.dart';

import '../../../ui/tokens/app_spacing.dart';
import '../../../ui/tokens/app_typography.dart';
import '../extensions.dart';
import 'app_text.dart';

/// Warm, tactile scroll/parchment container for docket sections, arguments, and cards.
///
/// Supports an optional yellow bookmark ribbon pinned to the top corner (matching the UI mockup).
class ParchmentCard extends StatelessWidget {
  const ParchmentCard({
    super.key,
    required this.child,
    this.padding = AppSpacing.p16,
    this.margin,
    this.onTap,
    this.hasBorder = true,
    this.elevation = 2.0,
    this.bookmarkRibbonLabel,
  });

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final bool hasBorder;
  final double elevation;
  final String? bookmarkRibbonLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final cardDecoration = BoxDecoration(
      color: colors.surface1,
      borderRadius: BorderRadius.circular(20.0),
      border: hasBorder
          ? Border.all(
              color: colors.hairline,
              width: 1.5,
            )
          : null,
      boxShadow: elevation > 0
          ? [
              BoxShadow(
                color: colors.text.withValues(alpha: 0.05),
                blurRadius: elevation * 4.0,
                offset: Offset(0, elevation * 1.5),
              ),
            ]
          : null,
    );

    Widget inner = Container(
      margin: margin,
      padding: padding,
      decoration: cardDecoration,
      child: child,
    );

    if (bookmarkRibbonLabel != null) {
      inner = Stack(
        clipBehavior: Clip.none,
        children: [
          inner,
          Positioned(
            top: -2,
            left: 20,
            child: _BookmarkRibbon(label: bookmarkRibbonLabel!),
          ),
        ],
      );
    }

    if (onTap == null) {
      return inner;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0),
        child: inner,
      ),
    );
  }
}

class _BookmarkRibbon extends StatelessWidget {
  const _BookmarkRibbon({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: colors.bookmarkYellow,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(6.0),
          bottomRight: Radius.circular(6.0),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.bookmarkYellow.withValues(alpha: 0.4),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppText(
        label,
        style: AppTextStyle.caption,
        color: colors.inkBlack,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
