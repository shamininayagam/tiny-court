import 'package:flutter/material.dart';

import '../../../ui/tokens/app_spacing.dart';
import '../extensions.dart';

/// Decorative judicial divider with optional gavel accent.
class CourtDivider extends StatelessWidget {
  const CourtDivider({
    super.key,
    this.height = AppSpacing.base,
    this.color,
    this.hasGavelIcon = false,
  });

  final double height;
  final Color? color;
  final bool hasGavelIcon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dividerColor = color ?? colors.hairlineStrong;

    if (!hasGavelIcon) {
      return SizedBox(
        height: height,
        child: Center(
          child: Divider(
            height: AppSpacing.hairlineThickness,
            thickness: AppSpacing.hairlineThickness,
            color: dividerColor,
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              height: AppSpacing.hairlineThickness,
              thickness: AppSpacing.hairlineThickness,
              color: dividerColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
            child: Icon(
              Icons.gavel,
              size: 14.0,
              color: colors.accent.withValues(alpha: 0.6),
            ),
          ),
          Expanded(
            child: Divider(
              height: AppSpacing.hairlineThickness,
              thickness: AppSpacing.hairlineThickness,
              color: dividerColor,
            ),
          ),
        ],
      ),
    );
  }
}
