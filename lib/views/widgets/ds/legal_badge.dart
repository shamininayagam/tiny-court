import 'package:flutter/material.dart';

import '../../../ui/tokens/app_radius.dart';
import '../../../ui/tokens/app_spacing.dart';
import '../../../ui/tokens/app_typography.dart';
import '../extensions.dart';
import 'app_text.dart';

/// Small pill badge displaying dispute categories, lifecycle status, or courtroom roles.
class LegalBadge extends StatelessWidget {
  const LegalBadge({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.backgroundColor,
  });

  final String label;
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final Color textColor = color ?? colors.accent;
    final Color bg = backgroundColor ?? textColor.withValues(alpha: 0.12);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s2,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.pillAll,
        border: Border.all(
          color: textColor.withValues(alpha: 0.25),
          width: AppSpacing.hairlineThickness,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 13.0,
              color: textColor,
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          AppText(
            label,
            style: AppTextStyle.caption,
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
