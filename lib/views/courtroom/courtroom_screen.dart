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
      backgroundColor: colors.bg,
      appBar: AppBar(
        title: AppText(
          state?.courtCase?.title ?? strings.appName,
          style: AppTextStyle.titleMedium,
        ),
        backgroundColor: colors.surface1,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _onClose,
        ),
        actions: [
          if (state != null &&
              state.currentStage != CourtroomStage.verdictReveal &&
              state.currentStage != CourtroomStage.adjourned)
            TextButton(
              onPressed: _onSkipToVerdict,
              child: AppText(
                strings.btnSkipToVerdict,
                style: AppTextStyle.label,
                color: colors.gavelGold,
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
                const SizedBox(height: AppSpacing.m),
                _JudgeBenchSection(stage: state.currentStage),
                const SizedBox(height: AppSpacing.base),
                _JudgeDialogueBubble(dialogue: state.currentJudgeDialogue),
                const SizedBox(height: AppSpacing.l),
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
      decoration: BoxDecoration(
        color: colors.surface1,
        border: Border(bottom: BorderSide(color: colors.hairline)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                _getStageTitle(context),
                style: AppTextStyle.label,
                color: colors.gavelGold,
              ),
              AppText(
                '${stepIndex + 1} / $totalSteps',
                style: AppTextStyle.caption,
                color: colors.text2,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: AppRadius.smAll,
            child: LinearProgressIndicator(
              value: (stepIndex + 1) / totalSteps,
              backgroundColor: colors.surface3,
              valueColor: AlwaysStoppedAnimation<Color>(colors.gavelGold),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class _JudgeBenchSection extends StatelessWidget {
  const _JudgeBenchSection({required this.stage});

  final CourtroomStage stage;

  JudgeExpression _getExpressionForStage() {
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
    return JudgeMascotView(
      expression: _getExpressionForStage(),
      size: 130,
    );
  }
}

class _JudgeDialogueBubble extends StatelessWidget {
  const _JudgeDialogueBubble({required this.dialogue});

  final String dialogue;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ParchmentCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.format_quote_rounded, size: 24, color: colors.gavelGold),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: AppText(
              dialogue,
              style: AppTextStyle.bodyLarge,
              color: colors.text,
            ),
          ),
        ],
      ),
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
    final colors = context.colors;
    final strings = context.strings;

    return Container(
      padding: AppSpacing.screenGutter,
      decoration: BoxDecoration(
        color: colors.surface1,
        border: Border(top: BorderSide(color: colors.hairline)),
      ),
      child: isVerdictReady
          ? AppButton(
              label: strings.courtroomViewVerdict,
              variant: AppButtonVariant.primaryGold,
              onPressed: onViewVerdict,
            )
          : AppButton(
              label: strings.btnSkipToVerdict,
              variant: AppButtonVariant.parchmentSecondary,
              onPressed: onSkipToVerdict,
            ),
    );
  }
}
