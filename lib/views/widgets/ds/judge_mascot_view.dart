import 'package:flutter/material.dart';

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
  celebratingWithGlasses,
}

/// Cartoon Judge Barnaby mascot avatar with expressive faces, barrister wig, and speech bubble.
class JudgeMascotView extends StatelessWidget {
  const JudgeMascotView({
    super.key,
    this.expression = JudgeExpression.neutral,
    this.size = 110.0,
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
        _ChibiJudgeBarnaby(
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
      constraints: const BoxConstraints(maxWidth: 300.0),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.s3,
      ),
      decoration: BoxDecoration(
        color: colors.surface1,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: colors.hairline,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.text.withValues(alpha: 0.06),
            blurRadius: 10.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: AppText(
        message,
        style: AppTextStyle.bodyMedium,
        color: colors.text,
        align: TextAlign.center,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ChibiJudgeBarnaby extends StatelessWidget {
  const _ChibiJudgeBarnaby({
    required this.expression,
    required this.size,
  });

  final JudgeExpression expression;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: size * 1.2,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Sparkles behind head
          Positioned(
            top: 2,
            right: 8,
            child: Icon(
              Icons.auto_awesome,
              color: colors.accent.withValues(alpha: 0.7),
              size: size * 0.2,
            ),
          ),
          Positioned(
            top: 10,
            left: 4,
            child: Icon(
              Icons.star,
              color: colors.accent.withValues(alpha: 0.5),
              size: size * 0.16,
            ),
          ),

          // Barrister Powdered Wig (White rolls behind face)
          Container(
            width: size * 0.95,
            height: size * 0.9,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F5F0),
              borderRadius: BorderRadius.circular(size * 0.45),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),

          // Face Circle
          Positioned(
            bottom: size * 0.08,
            child: Container(
              width: size * 0.7,
              height: size * 0.65,
              decoration: BoxDecoration(
                color: const Color(0xFFFFDFC4), // Warm cute peach face
                borderRadius: BorderRadius.circular(size * 0.35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Cute Rosy Cheeks
                  Positioned(
                    bottom: size * 0.18,
                    left: size * 0.08,
                    child: Container(
                      width: size * 0.14,
                      height: size * 0.07,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF8A80).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(size * 0.07),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: size * 0.18,
                    right: size * 0.08,
                    child: Container(
                      width: size * 0.14,
                      height: size * 0.07,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF8A80).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(size * 0.07),
                      ),
                    ),
                  ),

                  // Expression (Eyes & Mouth / Glasses)
                  if (expression == JudgeExpression.celebratingWithGlasses) ...[
                    // Cool Sunglasses 😎
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size * 0.05,
                        vertical: size * 0.02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size * 0.22,
                            height: size * 0.14,
                            decoration: BoxDecoration(
                              color: const Color(0xFF212121),
                              borderRadius: BorderRadius.circular(size * 0.04),
                            ),
                          ),
                          Container(
                            width: size * 0.06,
                            height: 2.0,
                            color: const Color(0xFF212121),
                          ),
                          Container(
                            width: size * 0.22,
                            height: size * 0.14,
                            decoration: BoxDecoration(
                              color: const Color(0xFF212121),
                              borderRadius: BorderRadius.circular(size * 0.04),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: size * 0.12,
                      child: Container(
                        width: size * 0.14,
                        height: size * 0.06,
                        decoration: const BoxDecoration(
                          color: Color(0xFF28231D),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    // Big round cute eyes & eyebrows
                    Positioned(
                      top: size * 0.2,
                      child: Row(
                        children: [
                          _EyeWidget(
                            isStern: expression == JudgeExpression.stern,
                            isHappy: expression == JudgeExpression.laughing ||
                                expression == JudgeExpression.neutral,
                            size: size,
                          ),
                          SizedBox(width: size * 0.12),
                          _EyeWidget(
                            isStern: expression == JudgeExpression.stern,
                            isHappy: expression == JudgeExpression.laughing ||
                                expression == JudgeExpression.neutral,
                            size: size,
                          ),
                        ],
                      ),
                    ),
                    // Smile / Mouth
                    Positioned(
                      bottom: size * 0.14,
                      child: Icon(
                        expression == JudgeExpression.laughing
                            ? Icons.sentiment_very_satisfied
                            : expression == JudgeExpression.stern
                                ? Icons.sentiment_very_dissatisfied
                                : Icons.sentiment_satisfied_alt,
                        size: size * 0.18,
                        color: const Color(0xFF3E2723),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Wig Top Front Fringe
          Positioned(
            top: size * 0.12,
            child: Container(
              width: size * 0.6,
              height: size * 0.22,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(size * 0.11),
                border: Border.all(
                  color: const Color(0xFFEFE8DB),
                  width: 1.5,
                ),
              ),
            ),
          ),

          // Tiny Gavel in hand
          Positioned(
            bottom: size * 0.05,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: colors.walnutWood,
                shape: BoxShape.circle,
                border: Border.all(color: colors.accent, width: 2.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.gavel,
                size: size * 0.22,
                color: colors.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EyeWidget extends StatelessWidget {
  const _EyeWidget({
    required this.isStern,
    required this.isHappy,
    required this.size,
  });

  final bool isStern;
  final bool isHappy;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (isHappy) {
      return Container(
        width: size * 0.11,
        height: size * 0.11,
        decoration: const BoxDecoration(
          color: Color(0xFF28231D),
          shape: BoxShape.circle,
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: size * 0.04,
            height: size * 0.04,
            margin: const EdgeInsets.all(1.5),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    return Container(
      width: size * 0.12,
      height: 3.0,
      color: const Color(0xFF28231D),
    );
  }
}
