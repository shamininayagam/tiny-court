import 'package:flutter/material.dart';

import '../../../ui/tokens/app_radius.dart';
import '../../../ui/tokens/app_spacing.dart';
import '../../../ui/tokens/app_typography.dart';
import '../extensions.dart';
import 'app_text.dart';

enum AppButtonVariant {
  primaryGold,
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
      AppButtonVariant.primaryGold => isEnabled ? colors.gavelGold : colors.gavelGold.withValues(alpha: 0.4),
      AppButtonVariant.parchmentSecondary => isEnabled ? colors.parchmentCream : colors.parchmentCream.withValues(alpha: 0.4),
      AppButtonVariant.dangerRed => isEnabled ? colors.danger : colors.danger.withValues(alpha: 0.4),
      AppButtonVariant.ghost => Colors.transparent,
    };

    final Color foregroundColor = switch (variant) {
      AppButtonVariant.primaryGold => colors.inkBlack,
      AppButtonVariant.parchmentSecondary => colors.inkBlack,
      AppButtonVariant.dangerRed => Colors.white,
      AppButtonVariant.ghost => colors.accent,
    };

    final Border? border = switch (variant) {
      AppButtonVariant.parchmentSecondary => Border.all(
          color: colors.parchmentBorder,
          width: AppSpacing.hairlineThickness * 1.5,
        ),
      _ => null,
    };

    final List<BoxShadow>? shadows = switch (variant) {
      AppButtonVariant.primaryGold when isEnabled => const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 8.0,
            offset: Offset(0, 3),
          ),
        ],
      AppButtonVariant.parchmentSecondary when isEnabled => const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 6.0,
            offset: Offset(0, 2),
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
          borderRadius: AppRadius.mdAll,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: isFullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.m,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: AppRadius.mdAll,
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
