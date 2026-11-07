import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/case.dart';
import '../../model/suggested_case.dart';
import '../../provider/app_providers.dart';
import '../../ui.dart';
import '../navigation/app_routes.dart';

/// Home Tab: Hero Judge Barnaby mascot, Quick Dispute CTA, Curated Templates, and Recent Cases.
class HomeTab extends AppConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget buildApp(BuildContext context, AppRef ref) {
    final strings = context.strings;
    final suggestedAsync = ref.watch(suggestedCasesProvider);
    final historyState = ref.caseHistoryState;

    return Scaffold(
      backgroundColor: context.colors.bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: AppSpacing.screenGutter,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: AppSpacing.s),
                  Center(
                    child: JudgeMascotView(
                      expression: JudgeExpression.laughing,
                      size: 96.0,
                      dialogueBubble: strings.homeWelcomeSubtitle,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.base),
                  AppText(
                    strings.homeWelcomeTitle,
                    style: AppTextStyle.headlineMedium,
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.base),
                  AppButton(
                    label: strings.btnQuickStart,
                    icon: const Icon(Icons.add, size: 20.0),
                    isFullWidth: true,
                    onPressed: () {
                      const CreateCaseRoute().push(context);
                    },
                  ),
                  const SizedBox(height: AppSpacing.l),
                  AppText(
                    strings.homeTemplatesHeader,
                    style: AppTextStyle.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.m),
                ]),
              ),
            ),
            SliverToBoxAdapter(
              child: suggestedAsync.when(
                data: (templates) => _SuggestedCasesCarousel(templates: templates),
                loading: () => const Center(
                  child: Padding(
                    padding: AppSpacing.p24,
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (e, _) => Center(
                  child: AppText(
                    strings.errorGeneral,
                    style: AppTextStyle.bodyMedium,
                    color: context.colors.danger,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: AppSpacing.screenGutter,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: AppSpacing.l),
                  AppText(
                    strings.homeRecentCasesHeader,
                    style: AppTextStyle.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  if (historyState.allCases.isEmpty)
                    const _EmptyRecentCasesView()
                  else
                    ...historyState.allCases.take(5).map(
                          (c) => _RecentCaseDocketItem(courtCase: c),
                        ),
                  const SizedBox(height: AppSpacing.xl),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestedCasesCarousel extends StatelessWidget {
  const _SuggestedCasesCarousel({required this.templates});

  final List<SuggestedCase> templates;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.0,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
        scrollDirection: Axis.horizontal,
        itemCount: templates.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.m),
        itemBuilder: (context, index) {
          final template = templates[index];
          return _SuggestedCaseCard(template: template);
        },
      ),
    );
  }
}

class _SuggestedCaseCard extends StatelessWidget {
  const _SuggestedCaseCard({required this.template});

  final SuggestedCase template;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: 260.0,
      child: ParchmentCard(
        onTap: () {
          CreateCaseRoute(templateId: template.id).push(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LegalBadge(
                  label: template.category.displayName,
                  icon: Icons.label_outline,
                ),
                Icon(Icons.chevron_right, size: 18.0, color: colors.text3),
              ],
            ),
            const SizedBox(height: AppSpacing.s),
            AppText(
              template.title,
              style: AppTextStyle.titleMedium,
              color: colors.inkBlack,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: AppSpacing.xs),
            Expanded(
              child: AppText(
                template.description,
                style: AppTextStyle.caption,
                color: colors.inkBlack.withValues(alpha: 0.75),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentCaseDocketItem extends StatelessWidget {
  const _RecentCaseDocketItem({required this.courtCase});

  final Case courtCase;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      child: ParchmentCard(
        elevation: 1.0,
        padding: AppSpacing.p12,
        onTap: () {
          if (courtCase.status.name == 'decided') {
            VerdictDetailsRoute(id: courtCase.id).push(context);
          } else {
            CaseDetailsRoute(id: courtCase.id).push(context);
          }
        },
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: colors.surface2,
                borderRadius: AppRadius.smAll,
              ),
              child: Icon(Icons.gavel, size: 20.0, color: colors.gavelGold),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    courtCase.title,
                    style: AppTextStyle.titleMedium,
                    color: colors.inkBlack,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 2.0),
                  AppText(
                    '${courtCase.plaintiffName} vs ${courtCase.defendantName}',
                    style: AppTextStyle.caption,
                    color: colors.inkBlack.withValues(alpha: 0.7),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            LegalBadge(
              label: courtCase.status.name.toUpperCase(),
              color: courtCase.status.name == 'decided' ? colors.ok : colors.accent,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyRecentCasesView extends StatelessWidget {
  const _EmptyRecentCasesView();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Container(
      padding: AppSpacing.p24,
      decoration: BoxDecoration(
        color: colors.surface1,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: colors.hairline),
      ),
      child: Center(
        child: AppText(
          strings.homeEmptyRecent,
          style: AppTextStyle.bodyMedium,
          color: colors.text2,
          align: TextAlign.center,
        ),
      ),
    );
  }
}
