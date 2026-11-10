import 'package:flutter/material.dart';

import '../../../model/enums/verdict_type.dart';
import '../../../ui/tokens/app_radius.dart';
import '../../../ui/tokens/app_spacing.dart';
import '../../../ui/tokens/app_typography.dart';
import '../extensions.dart';
import 'app_text.dart';

/// Distressed rubber-stamp verdict decree with dramatic entrance animation.
class VerdictStamp extends StatefulWidget {
  const VerdictStamp({
    super.key,
    required this.verdictType,
    this.customLabel,
    this.isAnimated = true,
  });

  final VerdictType verdictType;
  final String? customLabel;
  final bool isAnimated;

  @override
  State<VerdictStamp> createState() => _VerdictStampState();
}

class _VerdictStampState extends State<VerdictStamp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );

    _scaleAnimation = Tween<double>(begin: widget.isAnimated ? 2.2 : 1.0, end: 1.0)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(_controller);

    _opacityAnimation = Tween<double>(begin: widget.isAnimated ? 0.0 : 1.0, end: 1.0)
        .animate(_controller);

    if (widget.isAnimated) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(VerdictStamp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.verdictType != widget.verdictType && widget.isAnimated) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final Color stampColor = switch (widget.verdictType) {
      VerdictType.guiltyDefendant || VerdictType.guiltyPlaintiff => colors.guiltyRed,
      VerdictType.notGuilty => colors.acquittalGreen,
      VerdictType.bothGuilty => colors.mutualOrange,
      VerdictType.caseDismissed || VerdictType.hungJury => colors.contemptPurple,
      _ => colors.guiltyRed,
    };

    final String stampText = widget.customLabel ?? switch (widget.verdictType) {
      VerdictType.guiltyDefendant => context.strings.verdictStampGuilty,
      VerdictType.guiltyPlaintiff => 'PLAINTIFF GUILTY',
      VerdictType.bothGuilty => context.strings.verdictStampMutualBlame,
      VerdictType.notGuilty => context.strings.verdictStampNotGuilty,
      VerdictType.caseDismissed => 'DISMISSED',
      VerdictType.hungJury => context.strings.verdictStampContempt,
      _ => context.strings.verdictStampGuilty,
    };

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: -0.09,
              child: child,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s6,
          vertical: AppSpacing.s2,
        ),
        decoration: BoxDecoration(
          borderRadius: AppRadius.smAll,
          border: Border.all(
            color: stampColor,
            width: 3.5,
          ),
          boxShadow: [
            BoxShadow(
              color: stampColor.withValues(alpha: 0.20),
              blurRadius: 12.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s3,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: stampColor.withValues(alpha: 0.65),
              width: 1.2,
            ),
          ),
          child: AppText(
            stampText,
            style: AppTextStyle.stamp,
            color: stampColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
