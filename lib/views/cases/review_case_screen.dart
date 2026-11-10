import '../../model/case.dart';
import '../../model/enums/case_category.dart';
import '../../provider/app_providers.dart';
import '../../ui.dart';
import '../navigation/app_routes.dart';

/// Screen presenting the final docket review before entering the courtroom trial.
class ReviewCaseScreen extends AppConsumerStatefulWidget {
  const ReviewCaseScreen({super.key, required this.caseId});

  final String caseId;

  @override
  ReviewCaseScreenState createState() => ReviewCaseScreenState();
}

class ReviewCaseScreenState extends AppConsumerState<ReviewCaseScreen> {
  Case? _courtCase;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCase();
  }

  Future<void> _loadCase() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(appRepositoryProvider);
      final courtCase = await repo.caseService.getCaseById(widget.caseId);
      if (mounted) {
        setState(() {
          _courtCase = courtCase;
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

  void _onEnterCourtroom() {
    if (_courtCase == null) return;
    CourtroomRoute(id: _courtCase!.id).go(context);
  }

  void _onBackPressed() {
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

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(
        title: AppText(
          strings.reviewDocketTitle,
          style: AppTextStyle.titleMedium,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: colors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _onBackPressed,
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(color: colors.gavelGold),
              )
            : _errorMessage != null || _courtCase == null
                ? _ReviewErrorView(
                    message: _errorMessage ?? strings.errorCaseNotFound,
                    onRetry: _loadCase,
                  )
                : _ReviewContentView(
                    courtCase: _courtCase!,
                    onEnterCourtroom: _onEnterCourtroom,
                    onBack: _onBackPressed,
                  ),
      ),
    );
  }
}

class _ReviewErrorView extends StatelessWidget {
  const _ReviewErrorView({
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

class _ReviewContentView extends StatelessWidget {
  const _ReviewContentView({
    required this.courtCase,
    required this.onEnterCourtroom,
    required this.onBack,
  });

  final Case courtCase;
  final VoidCallback onEnterCourtroom;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: AppSpacing.screenGutter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _DocketHeaderCard(courtCase: courtCase),
                const SizedBox(height: AppSpacing.base),
                ArgumentScrollCard(
                  plaintiffName: courtCase.plaintiffName,
                  plaintiffArgument: courtCase.plaintiffArgument,
                  defendantName: courtCase.defendantName,
                  defendantArgument: courtCase.defendantArgument,
                ),
                const SizedBox(height: AppSpacing.base),
                const _LegalDisclaimerCard(),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
        _ReviewBottomBar(
          onEnterCourtroom: onEnterCourtroom,
          onBack: onBack,
        ),
      ],
    );
  }
}

class _DocketHeaderCard extends StatelessWidget {
  const _DocketHeaderCard({required this.courtCase});

  final Case courtCase;

  IconData _getCategoryIcon(CaseCategory category) {
    return switch (category) {
      CaseCategory.food => Icons.local_pizza,
      CaseCategory.friendship => Icons.event_available,
      CaseCategory.relationships => Icons.tv,
      CaseCategory.work => Icons.coffee,
      _ => Icons.lightbulb,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ParchmentCard(
      bookmarkRibbonLabel: 'Case ${courtCase.caseNumber}',
      padding: const EdgeInsets.fromLTRB(AppSpacing.base, 28.0, AppSpacing.base, AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: AppSpacing.s),
          AppText(
            courtCase.title,
            style: AppTextStyle.headlineMedium,
            color: colors.text,
            align: TextAlign.center,
            fontWeight: FontWeight.w800,
          ),
          const SizedBox(height: AppSpacing.base),
          // Large dispute illustration / category emblem
          Container(
            width: 72.0,
            height: 72.0,
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getCategoryIcon(courtCase.category),
              size: 40.0,
              color: colors.accent,
            ),
          ),
          const SizedBox(height: AppSpacing.base),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                'Category: ',
                style: AppTextStyle.caption,
                color: colors.text2,
                fontWeight: FontWeight.w600,
              ),
              AppText(
                courtCase.category.displayName,
                style: AppTextStyle.caption,
                color: colors.text,
                fontWeight: FontWeight.w800,
              ),
            ],
          ),
          if (courtCase.description != null &&
              courtCase.description!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            AppText(
              courtCase.description!,
              style: AppTextStyle.caption,
              color: colors.text2,
              align: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class _LegalDisclaimerCard extends StatelessWidget {
  const _LegalDisclaimerCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Container(
      padding: AppSpacing.p12,
      decoration: BoxDecoration(
        color: colors.surface2,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: colors.hairline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.gavel_rounded,
            size: 20,
            color: colors.gavelGold,
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: AppText(
              strings.reviewNotice,
              style: AppTextStyle.caption,
              color: colors.text2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewBottomBar extends StatelessWidget {
  const _ReviewBottomBar({
    required this.onEnterCourtroom,
    required this.onBack,
  });

  final VoidCallback onEnterCourtroom;
  final VoidCallback onBack;

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            label: strings.btnStartTrial,
            isFullWidth: true,
            variant: AppButtonVariant.royalIndigo,
            onPressed: onEnterCourtroom,
          ),
          const SizedBox(height: AppSpacing.s),
          InkWell(
            onTap: onBack,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: AppText(
                'Edit',
                style: AppTextStyle.label,
                color: colors.text2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
