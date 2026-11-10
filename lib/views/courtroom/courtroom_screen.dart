import '../../mixins/courtroom_mixin.dart';
import '../../model/case.dart';
import '../../model/states/courtroom_state.dart';
import '../../provider/app_providers.dart';
import '../../ui.dart';
import '../navigation/app_routes.dart';

/// Fullscreen animated Courtroom trial experience wired with [CourtroomMixin].
class CourtroomScreen extends AppConsumerStatefulWidget {
  const CourtroomScreen({super.key, required this.caseId});

  final String caseId;

  @override
  CourtroomScreenState createState() => CourtroomScreenState();
}

class CourtroomScreenState extends AppConsumerState<CourtroomScreen>
    with CourtroomMixin {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAndInitCase();
    });
  }

  Future<void> _loadAndInitCase() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(appRepositoryProvider);
      final courtCase = await repo.caseService.getCaseById(widget.caseId);
      if (mounted) {
        initCourtroomSession(courtCase: courtCase);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _onSkipToVerdict() {
    skipCourtroomToVerdict();
  }

  void _onViewVerdict() {
    VerdictDetailsRoute(id: widget.caseId).go(context);
  }

  void _onClose() {
    resetCourtroomSession();
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      const MainNavigationRoute().go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;
    final state = courtroomState;

    return Scaffold(
      backgroundColor: const Color(0xFF201319), // Deep theatrical courtroom backdrop
      appBar: AppBar(
        title: AppText(
          state?.courtCase?.title ?? strings.appName,
          style: AppTextStyle.titleMedium,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: const Color(0xFF2B1822),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white70),
          onPressed: _onClose,
        ),
        actions: [
          if (state != null &&
              state.currentStage != CourtroomStage.verdictReveal &&
              state.currentStage != CourtroomStage.adjourned)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.base),
              child: InkWell(
                onTap: _onSkipToVerdict,
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        strings.btnSkipToVerdict,
                        style: AppTextStyle.caption,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(width: 4.0),
                      const Icon(Icons.fast_forward, size: 14.0, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(color: colors.gavelGold),
              )
            : _errorMessage != null || state == null
                ? _CourtroomErrorView(
                    message: _errorMessage ?? strings.errorCaseNotFound,
                    onRetry: _loadAndInitCase,
                  )
                : _CourtroomTrialView(
                    state: state,
                    onGavelStrike: progressCourtroomStage,
                    onViewVerdict: _onViewVerdict,
                    onSkipToVerdict: _onSkipToVerdict,
                  ),
      ),
    );
  }
}

class _CourtroomErrorView extends StatelessWidget {
  const _CourtroomErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Center(
      child: Padding(
        padding: AppSpacing.screenGutter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: colors.danger),
            const SizedBox(height: AppSpacing.base),
            AppText(
              message,
              style: AppTextStyle.bodyMedium,
              color: Colors.white,
              align: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.l),
            AppButton(
              label: strings.btnRetry,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}

class _CourtroomTrialView extends StatelessWidget {
  const _CourtroomTrialView({
    required this.state,
    required this.onGavelStrike,
    required this.onViewVerdict,
    required this.onSkipToVerdict,
  });

  final CourtroomState state;
  final VoidCallback onGavelStrike;
  final VoidCallback onViewVerdict;
  final VoidCallback onSkipToVerdict;

  @override
  Widget build(BuildContext context) {
    final bool isVerdictReady =
        state.currentStage == CourtroomStage.verdictReveal ||
            state.currentStage == CourtroomStage.adjourned;

    return Column(
      children: [
        _CourtroomStageHeader(stage: state.currentStage),
        Expanded(
          child: SingleChildScrollView(
            padding: AppSpacing.screenGutter,
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.s),
                // Courtroom Podium / Bench Stage View
                _CourtroomStageBench(
                  stage: state.currentStage,
                  dialogue: state.currentJudgeDialogue,
                ),
                const SizedBox(height: AppSpacing.base),
                if (state.courtCase != null)
                  _StageArgumentPresentation(
                    stage: state.currentStage,
                    courtCase: state.courtCase!,
                  ),
                const SizedBox(height: AppSpacing.base),
                if (!isVerdictReady)
                  GavelStrikeAction(
                    onStrike: onGavelStrike,
                  ),
                const SizedBox(height: AppSpacing.l),
              ],
            ),
          ),
        ),
        _CourtroomBottomControls(
          isVerdictReady: isVerdictReady,
          onViewVerdict: onViewVerdict,
          onSkipToVerdict: onSkipToVerdict,
        ),
      ],
    );
  }
}

class _CourtroomStageHeader extends StatelessWidget {
  const _CourtroomStageHeader({required this.stage});

  final CourtroomStage stage;

  String _getStageTitle(BuildContext context) {
    final strings = context.strings;
    return switch (stage) {
      CourtroomStage.entrance => strings.courtroomStageEntrance,
      CourtroomStage.judgeIntro => strings.courtroomStageIntro,
      CourtroomStage.plaintiffPresentation => strings.courtroomStagePlaintiff,
      CourtroomStage.defendantPresentation => strings.courtroomStageDefendant,
      CourtroomStage.deliberation => strings.courtroomStageDeliberation,
      CourtroomStage.verdictReveal => strings.courtroomStageVerdict,
      CourtroomStage.adjourned => strings.courtroomStageAdjourned,
      _ => strings.courtroomStageEntrance,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final int stepIndex = CourtroomStage.values.toList().indexOf(stage);
    const int totalSteps = 7;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.s,
      ),
      color: const Color(0xFF2B1822),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                _getStageTitle(context),
                style: AppTextStyle.caption,
                color: colors.accent,
                fontWeight: FontWeight.w800,
              ),
              AppText(
                '${stepIndex + 1} / $totalSteps',
                style: AppTextStyle.caption,
                color: Colors.white70,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: LinearProgressIndicator(
              value: (stepIndex + 1) / totalSteps,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation<Color>(colors.accent),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class _CourtroomStageBench extends StatelessWidget {
  const _CourtroomStageBench({
    required this.stage,
    required this.dialogue,
  });

  final CourtroomStage stage;
  final String dialogue;

  JudgeExpression _getExpression() {
    return switch (stage) {
      CourtroomStage.entrance ||
      CourtroomStage.judgeIntro =>
        JudgeExpression.neutral,
      CourtroomStage.plaintiffPresentation ||
      CourtroomStage.defendantPresentation =>
        JudgeExpression.stern,
      CourtroomStage.deliberation => JudgeExpression.pondering,
      CourtroomStage.verdictReveal ||
      CourtroomStage.adjourned =>
        JudgeExpression.bangingGavel,
      _ => JudgeExpression.neutral,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.l),
          decoration: BoxDecoration(
            color: const Color(0xFF2C191E),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: colors.curtainRed.withValues(alpha: 0.5),
              width: 2.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 16.0,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              // Speech Bubble
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 8.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: AppText(
                  dialogue,
                  style: AppTextStyle.bodyMedium,
                  color: const Color(0xFF28231D),
                  align: TextAlign.center,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.base),

              // Cartoon Judge Mascot behind wooden podium
              JudgeMascotView(
                expression: _getExpression(),
                size: 110.0,
              ),
              const SizedBox(height: AppSpacing.s),

              // Golden Scales on Wooden Bench Front
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF3E2219), // Wooden podium
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: colors.accent, width: 2.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: colors.accent.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.balance, size: 18.0, color: colors.accent),
                    ),
                    const SizedBox(width: 8.0),
                    AppText(
                      'TINY COURT',
                      style: AppTextStyle.caption,
                      color: colors.accent,
                      fontWeight: FontWeight.w900,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.m),

              // Audience Silhouette Heads at the bottom (Screen 5)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  final double headSize = (index == 2) ? 34.0 : (index.isOdd ? 28.0 : 30.0);
                  final double shoulderWidth = headSize * 1.5;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: headSize,
                        height: headSize,
                        decoration: const BoxDecoration(
                          color: Color(0xFF14080D),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: shoulderWidth,
                        height: 10.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF14080D),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),

        // Left Red Velvet Draped Curtain Accent
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: 20.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.curtainRed,
                  colors.curtainRed.withValues(alpha: 0.1),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(24.0)),
            ),
          ),
        ),

        // Right Red Velvet Draped Curtain Accent
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: 20.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.curtainRed.withValues(alpha: 0.1),
                  colors.curtainRed,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(24.0)),
            ),
          ),
        ),
      ],
    );
  }
}

class _StageArgumentPresentation extends StatelessWidget {
  const _StageArgumentPresentation({
    required this.stage,
    required this.courtCase,
  });

  final CourtroomStage stage;
  final Case courtCase;

  @override
  Widget build(BuildContext context) {
    if (stage == CourtroomStage.plaintiffPresentation ||
        stage == CourtroomStage.defendantPresentation) {
      return ArgumentScrollCard(
        plaintiffName: courtCase.plaintiffName,
        plaintiffArgument: courtCase.plaintiffArgument,
        defendantName: courtCase.defendantName,
        defendantArgument: courtCase.defendantArgument,
      );
    }

    return const SizedBox.shrink();
  }
}

class _CourtroomBottomControls extends StatelessWidget {
  const _CourtroomBottomControls({
    required this.isVerdictReady,
    required this.onViewVerdict,
    required this.onSkipToVerdict,
  });

  final bool isVerdictReady;
  final VoidCallback onViewVerdict;
  final VoidCallback onSkipToVerdict;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Container(
      padding: AppSpacing.screenGutter,
      decoration: const BoxDecoration(
        color: Color(0xFF2B1822),
      ),
      child: isVerdictReady
          ? AppButton(
              label: strings.courtroomViewVerdict,
              isFullWidth: true,
              variant: AppButtonVariant.primaryGold,
              onPressed: onViewVerdict,
            )
          : AppButton(
              label: strings.btnSkipToVerdict,
              isFullWidth: true,
              variant: AppButtonVariant.royalIndigo,
              onPressed: onSkipToVerdict,
            ),
    );
  }
}
