import 'package:flutter/material.dart';

import '../../../ui/tokens/app_radius.dart';
import '../../../ui/tokens/app_spacing.dart';
import '../../../ui/tokens/app_typography.dart';
import '../extensions.dart';
import 'app_text.dart';

/// Supported facial expressions and gestures for Judge Barnaby.
enum JudgeExpression {
  neutral,
  stern,
  pondering,
  laughing,
  bangingGavel,
}

/// Cartoon Judge Barnaby mascot avatar with expressive animated faces and dialogue bubbles.
class JudgeMascotView extends StatelessWidget {
  const JudgeMascotView({
    super.key,
    this.expression = JudgeExpression.neutral,
    this.size = 120.0,
    this.dialogueBubble,
  });

  final JudgeExpression expression;
  final double size;
  final String? dialogueBubble;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (dialogueBubble != null && dialogueBubble!.isNotEmpty) ...[
          _JudgeDialogueBubble(message: dialogueBubble!),
          const SizedBox(height: AppSpacing.s),
        ],
        _JudgeAvatarDisc(
          expression: expression,
          size: size,
        ),
      ],
    );
  }
}

class _JudgeDialogueBubble extends StatelessWidget {
  const _JudgeDialogueBubble({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      constraints: const BoxConstraints(maxWidth: 320.0),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.s3,
      ),
      decoration: BoxDecoration(
        color: colors.parchmentCream,
        borderRadius: AppRadius.mdAll,
        border: Border.all(
          color: colors.parchmentBorder,
          width: AppSpacing.hairlineThickness * 1.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 8.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: AppText(
        message,
        style: AppTextStyle.bodyMedium,
        color: colors.inkBlack,
        align: TextAlign.center,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _JudgeAvatarDisc extends StatelessWidget {
  const _JudgeAvatarDisc({
    required this.expression,
    required this.size,
  });

  final JudgeExpression expression;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final IconData icon = switch (expression) {
      JudgeExpression.neutral => Icons.sentiment_satisfied_alt,
      JudgeExpression.stern => Icons.sentiment_very_dissatisfied,
      JudgeExpression.pondering => Icons.psychology_alt,
      JudgeExpression.laughing => Icons.sentiment_very_satisfied,
      JudgeExpression.bangingGavel => Icons.gavel,
    };

    final Color accentColor = switch (expression) {
      JudgeExpression.neutral => colors.gavelGold,
      JudgeExpression.stern => colors.danger,
      JudgeExpression.pondering => colors.info,
      JudgeExpression.laughing => colors.ok,
      JudgeExpression.bangingGavel => colors.accentHi,
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.walnutWood,
        border: Border.all(
          color: accentColor,
          width: 3.5,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.35),
            blurRadius: 16.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          size: size * 0.52,
          color: accentColor,
        ),
      ),
    );
  }
}
