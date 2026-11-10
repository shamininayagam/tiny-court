import '../../model/case.dart';
import '../../model/enums/case_status.dart';
import '../../model/verdict.dart';
import '../../provider/app_providers.dart';
import '../../ui.dart';
import '../navigation/app_routes.dart';

/// Read-only case dossier view displaying parties, arguments, and verdict if decided.
class CaseDetailsScreen extends AppConsumerStatefulWidget {
  const CaseDetailsScreen({super.key, required this.caseId});

  final String caseId;

  @override
  CaseDetailsScreenState createState() => CaseDetailsScreenState();
}

class CaseDetailsScreenState extends AppConsumerState<CaseDetailsScreen> {
  Case? _courtCase;
  Verdict? _verdict;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCaseDetails();
  }

  Future<void> _loadCaseDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(appRepositoryProvider);
      final courtCase = await repo.caseService.getCaseById(widget.caseId);
      Verdict? verdict;
      if (courtCase.status == CaseStatus.decided) {
        try {
          verdict = await repo.verdictService.getVerdictByCaseId(widget.caseId);
        } catch (_) {
          // Verdict might not exist yet if status was manually changed
        }
      }

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

  void _onEnterCourtroom() {
    CourtroomRoute(id: widget.caseId).push(context);
  }

  void _onViewFullVerdict() {
    VerdictDetailsRoute(id: widget.caseId).push(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(
        title: AppText(
          strings.caseDetailsTitle,
          style: AppTextStyle.titleMedium,
        ),
        backgroundColor: colors.surface1,
        elevation: 0,
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(color: colors.gavelGold),
              )
            : _errorMessage != null || _courtCase == null
                ? _CaseDetailsErrorView(
                    message: _errorMessage ?? strings.errorCaseNotFound,
                    onRetry: _loadCaseDetails,
                  )
                : _CaseDetailsContentView(
                    courtCase: _courtCase!,
                    verdict: _verdict,
                    onEnterCourtroom: _onEnterCourtroom,
                    onViewFullVerdict: _onViewFullVerdict,
                  ),
      ),
    );
  }
}

class _CaseDetailsErrorView extends StatelessWidget {
  const _CaseDetailsErrorView({
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

class _CaseDetailsContentView extends StatelessWidget {
  const _CaseDetailsContentView({
    required this.courtCase,
    required this.verdict,
    required this.onEnterCourtroom,
    required this.onViewFullVerdict,
  });

  final Case courtCase;
  final Verdict? verdict;
  final VoidCallback onEnterCourtroom;
  final VoidCallback onViewFullVerdict;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return SingleChildScrollView(
      padding: AppSpacing.screenGutter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CaseDetailsHeaderCard(courtCase: courtCase),
          const SizedBox(height: AppSpacing.base),
          ArgumentScrollCard(
            plaintiffName: courtCase.plaintiffName,
            plaintiffArgument: courtCase.plaintiffArgument,
            defendantName: courtCase.defendantName,
            defendantArgument: courtCase.defendantArgument,
          ),
          const SizedBox(height: AppSpacing.base),
          if (courtCase.status == CaseStatus.decided && verdict != null) ...[
            _DecidedVerdictPreviewCard(
              verdict: verdict!,
              onViewFull: onViewFullVerdict,
            ),
          ] else ...[
            AppButton(
              label: strings.caseDetailsEnterCourt,
              onPressed: onEnterCourtroom,
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _CaseDetailsHeaderCard extends StatelessWidget {
  const _CaseDetailsHeaderCard({required this.courtCase});

  final Case courtCase;

  Color _getStatusColor(BuildContext context, CaseStatus status) {
    final colors = context.colors;
    return switch (status) {
      CaseStatus.decided => colors.ok,
      CaseStatus.submitted => colors.accent,
      _ => colors.text2,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LegalBadge(
                label: courtCase.caseNumber,
                color: colors.info,
              ),
              Row(
                children: [
                  LegalBadge(
                    label: courtCase.status.name.toUpperCase(),
                    color: _getStatusColor(context, courtCase.status),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  LegalBadge(
                    label: courtCase.category.name.toUpperCase(),
                    color: colors.accent,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          AppText(
            courtCase.title,
            style: AppTextStyle.headlineMedium,
            color: colors.text,
          ),
          if (courtCase.description != null &&
              courtCase.description!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.s),
            AppText(
              courtCase.description!,
              style: AppTextStyle.caption,
              color: colors.text2,
            ),
          ],
        ],
      ),
    );
  }
}

class _DecidedVerdictPreviewCard extends StatelessWidget {
  const _DecidedVerdictPreviewCard({
    required this.verdict,
    required this.onViewFull,
  });

  final Verdict verdict;
  final VoidCallback onViewFull;

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
                strings.caseDetailsVerdictTitle,
                style: AppTextStyle.titleMedium,
                color: colors.gavelGold,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s),
          AppText(
            verdict.judgeStatement,
            style: AppTextStyle.bodyMedium,
            color: colors.text,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.m),
          AppButton(
            label: strings.caseDetailsViewVerdict,
            variant: AppButtonVariant.parchmentSecondary,
            onPressed: onViewFull,
          ),
        ],
      ),
    );
  }
}
