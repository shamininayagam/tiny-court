import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../ui/tokens/app_radius.dart';
import '../../../ui/tokens/app_spacing.dart';
import '../../../ui/tokens/app_typography.dart';
import '../extensions.dart';
import 'app_text.dart';

/// Animated interactive gavel strike widget triggering tactile haptic feedback.
class GavelStrikeAction extends StatefulWidget {
  const GavelStrikeAction({
    super.key,
    this.onStrike,
    this.size = 80.0,
    this.label,
  });

  final VoidCallback? onStrike;
  final double size;
  final String? label;

  @override
  State<GavelStrikeAction> createState() => _GavelStrikeActionState();
}

class _GavelStrikeActionState extends State<GavelStrikeAction>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );

    _rotationAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: -0.45)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.45, end: 0.15)
            .chain(CurveTween(curve: Curves.easeInQuad)),
        weight: 35.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.15, end: 0.0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 25.0,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerStrike() {
    HapticFeedback.heavyImpact();
    _controller.forward(from: 0.0).then((_) {
      widget.onStrike?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _triggerStrike,
          child: AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * math.pi,
                alignment: Alignment.bottomRight,
                child: child,
              );
            },
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.walnutWood,
                border: Border.all(
                  color: colors.gavelGold,
                  width: 2.5,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.gavel,
                  size: widget.size * 0.55,
                  color: colors.gavelGold,
                ),
              ),
            ),
          ),
        ),
        if (widget.label != null) ...[
          const SizedBox(height: AppSpacing.s),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s3,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: colors.surface2,
              borderRadius: AppRadius.pillAll,
            ),
            child: AppText(
              widget.label!,
              style: AppTextStyle.caption,
              color: colors.gavelGold,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}
