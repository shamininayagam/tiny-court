import 'package:share_plus/share_plus.dart';

import '../../model/case.dart';
import '../../model/verdict.dart';
import '../../provider/app_providers.dart';
import '../../ui.dart';
import '../navigation/app_routes.dart';

/// Fullscreen Verdict decree, comedic punishments, celebratory confetti, and share sheet.
class VerdictDetailsScreen extends AppConsumerStatefulWidget {
  const VerdictDetailsScreen({super.key, required this.caseId});

  final String caseId;

  @override
  VerdictDetailsScreenState createState() => VerdictDetailsScreenState();
}

class VerdictDetailsScreenState
    extends AppConsumerState<VerdictDetailsScreen> {
  Case? _courtCase;
  Verdict? _verdict;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadVerdictDetails();
  }

  Future<void> _loadVerdictDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(appRepositoryProvider);
      final courtCase = await repo.caseService.getCaseById(widget.caseId);
      final verdict =
          await repo.verdictService.getVerdictByCaseId(widget.caseId);

      if (mounted) {
        setState(() {
          _courtCase = courtCase;
          _verdict = verdict;
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

  Future<void> _onShare() async {
    final verdict = _verdict;
    final courtCase = _courtCase;
    final strings = context.strings;
    if (verdict == null || courtCase == null) return;

    final shareText = '''
⚖️ TINY COURT VERDICT: ${courtCase.title}
Docket: ${courtCase.caseNumber}
Ruling: ${verdict.verdictType.name.toUpperCase()}

"${verdict.judgeStatement}"

Punishment:
${verdict.punishment}

${strings.verdictShareWatermark}
''';

    try {
      // ignore: deprecated_member_use
      await Share.share(
        shareText,
        subject: 'Tiny Court Verdict: ${courtCase.title}',
      );
    } catch (_) {
      await Clipboard.setData(ClipboardData(text: shareText));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppText(
              strings.verdictCopied,
              style: AppTextStyle.caption,
              color: context.colors.text,
            ),
            backgroundColor: context.colors.surface3,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _onReturnHome() {
    const MainNavigationRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1424), // Celebratory dark courtroom stage
      appBar: AppBar(
        title: AppText(
          strings.verdictJudgeRulingTitle,
          style: AppTextStyle.titleMedium,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: const Color(0xFF281C30),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white70),
          onPressed: _onReturnHome,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            onPressed: _onShare,
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(color: colors.gavelGold),
              )
            : _errorMessage != null || _verdict == null || _courtCase == null
                ? _VerdictErrorView(
                    message: _errorMessage ?? strings.errorGeneral,
                    onRetry: _loadVerdictDetails,
                  )
                : _VerdictContentView(
                    courtCase: _courtCase!,
                    verdict: _verdict!,
                    onShare: _onShare,
                    onReturnHome: _onReturnHome,
                  ),
      ),
    );
  }
}

class _VerdictErrorView extends StatelessWidget {
  const _VerdictErrorView({
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

class _VerdictContentView extends StatelessWidget {
  const _VerdictContentView({
    required this.courtCase,
    required this.verdict,
    required this.onShare,
    required this.onReturnHome,
  });

  final Case courtCase;
  final Verdict verdict;
  final VoidCallback onShare;
  final VoidCallback onReturnHome;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: AppSpacing.screenGutter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSpacing.s),
                // Confetti & Sunglasses Judge Barnaby
                const JudgeMascotView(
                  expression: JudgeExpression.celebratingWithGlasses,
                  size: 110.0,
                ),
                const SizedBox(height: AppSpacing.base),

                // Celebratory Verdict Card
                _CelebratoryVerdictCard(
                  courtCase: courtCase,
                  verdict: verdict,
                ),
                const SizedBox(height: AppSpacing.base),

                // Comedic Punishment Card
                _DecreePunishmentCard(punishment: verdict.punishment),
                const SizedBox(height: AppSpacing.base),

                // Judicial Statement & Rationale
                _DecreeStatementCard(statement: verdict.judgeStatement),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
        _VerdictBottomBar(
          onShare: onShare,
          onReturnHome: onReturnHome,
        ),
      ],
    );
  }
}

class _CelebratoryVerdictCard extends StatelessWidget {
  const _CelebratoryVerdictCard({
    required this.courtCase,
    required this.verdict,
  });

  final Case courtCase;
  final Verdict verdict;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 16.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Golden Ribbon Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: colors.bookmarkYellow,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: colors.bookmarkYellow.withValues(alpha: 0.35),
                  blurRadius: 6.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: AppText(
              'FINAL VERDICT',
              style: AppTextStyle.caption,
              color: colors.inkBlack,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.m),

          AppText(
            courtCase.title,
            style: AppTextStyle.titleMedium,
            color: colors.text,
            fontWeight: FontWeight.w800,
            align: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          AppText(
            'The Defendant is',
            style: AppTextStyle.bodyMedium,
            color: colors.text2,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: AppSpacing.m),

          // Animated Rubber Stamp Badge
          VerdictStamp(verdictType: verdict.verdictType),
          const SizedBox(height: AppSpacing.s),
        ],
      ),
    );
  }
}

class _DecreeStatementCard extends StatelessWidget {
  const _DecreeStatementCard({required this.statement});

  final String statement;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.gavel_rounded, size: 20, color: colors.gavelGold),
              const SizedBox(width: AppSpacing.s),
              AppText(
                strings.verdictJudgeRulingTitle,
                style: AppTextStyle.titleMedium,
                color: colors.gavelGold,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          AppText(
            '"$statement"',
            style: AppTextStyle.bodyLarge,
            color: colors.text,
            italic: true,
          ),
        ],
      ),
    );
  }
}

class _DecreePunishmentCard extends StatelessWidget {
  const _DecreePunishmentCard({required this.punishment});

  final String punishment;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Container(
      width: double.infinity,
      padding: AppSpacing.screenGutter,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: colors.danger.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events_outlined,
                size: 22,
                color: colors.danger,
              ),
              const SizedBox(width: AppSpacing.s),
              AppText(
                strings.verdictPunishmentTitle,
                style: AppTextStyle.titleMedium,
                color: colors.danger,
                fontWeight: FontWeight.w800,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s),
          AppText(
            punishment,
            style: AppTextStyle.bodyMedium,
            color: colors.text,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

class _VerdictBottomBar extends StatelessWidget {
  const _VerdictBottomBar({
    required this.onShare,
    required this.onReturnHome,
  });

  final VoidCallback onShare;
  final VoidCallback onReturnHome;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Container(
      padding: AppSpacing.screenGutter,
      decoration: const BoxDecoration(
        color: Color(0xFF281C30),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: AppButton(
              label: strings.btnShare,
              variant: AppButtonVariant.parchmentSecondary,
              onPressed: onShare,
            ),
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            flex: 2,
            child: AppButton(
              label: 'Woohoo!',
              variant: AppButtonVariant.primaryGold,
              onPressed: onReturnHome,
            ),
          ),
        ],
      ),
    );
  }
}
