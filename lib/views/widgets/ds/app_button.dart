import 'package:flutter/material.dart';

import '../../../ui/tokens/app_radius.dart';
import '../../../ui/tokens/app_spacing.dart';
import '../../../ui/tokens/app_typography.dart';
import '../extensions.dart';
import 'app_text.dart';

enum AppButtonVariant {
  primaryGold,
  royalIndigo,
  parchmentSecondary,
  dangerRed,
  ghost,
}

/// Tactile courtroom button widget adhering to the design tokens and narrow props rules.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primaryGold,
    this.icon,
    this.isFullWidth = false,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? icon;
  final bool isFullWidth;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bool isEnabled = onPressed != null && !isLoading;

    final Color backgroundColor = switch (variant) {
      AppButtonVariant.royalIndigo => isEnabled
          ? colors.royalIndigo
          : colors.royalIndigo.withValues(alpha: 0.4),
      AppButtonVariant.primaryGold => isEnabled
          ? colors.honeyGold
          : colors.honeyGold.withValues(alpha: 0.4),
      AppButtonVariant.parchmentSecondary => isEnabled
          ? colors.surface2
          : colors.surface2.withValues(alpha: 0.4),
      AppButtonVariant.dangerRed => isEnabled
          ? colors.danger
          : colors.danger.withValues(alpha: 0.4),
      AppButtonVariant.ghost => Colors.transparent,
    };

    final Color foregroundColor = switch (variant) {
      AppButtonVariant.royalIndigo => Colors.white,
      AppButtonVariant.primaryGold => colors.inkBlack,
      AppButtonVariant.parchmentSecondary => colors.text,
      AppButtonVariant.dangerRed => Colors.white,
      AppButtonVariant.ghost => colors.accent,
    };

    final Border? border = switch (variant) {
      AppButtonVariant.parchmentSecondary => Border.all(
          color: colors.hairline,
          width: 1.5,
        ),
      _ => null,
    };

    final BorderRadius borderRadius = switch (variant) {
      AppButtonVariant.royalIndigo ||
      AppButtonVariant.primaryGold =>
        AppRadius.pillAll,
      _ => AppRadius.mdAll,
    };

    final List<BoxShadow>? shadows = switch (variant) {
      AppButtonVariant.royalIndigo when isEnabled => [
          BoxShadow(
            color: colors.royalIndigo.withValues(alpha: 0.25),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      AppButtonVariant.primaryGold when isEnabled => [
          BoxShadow(
            color: colors.honeyGold.withValues(alpha: 0.3),
            blurRadius: 8.0,
            offset: const Offset(0, 3),
          ),
        ],
      _ => null,
    };

    final Widget content = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 16.0,
            height: 16.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          ),
          const SizedBox(width: AppSpacing.s),
        ] else if (icon != null) ...[
          icon!,
          const SizedBox(width: AppSpacing.s),
        ],
        AppText(
          label,
          style: AppTextStyle.label,
          color: foregroundColor,
          fontWeight: FontWeight.w700,
        ),
      ],
    );

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: borderRadius,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: isFullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.m,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
              border: border,
              boxShadow: shadows,
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
