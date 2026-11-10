import '../../data/fixtures/suggested_cases_fixture.dart';
import '../../model/case.dart';
import '../../model/enums/case_category.dart';
import '../../model/suggested_case.dart';
import '../../ui.dart';
import '../navigation/app_routes.dart';

/// Home Tab: Hero Judge Barnaby mascot, Quick Dispute CTA, Curated Templates, and Recent Cases.
class HomeTab extends AppConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget buildApp(BuildContext context, AppRef ref) {
    final colors = context.colors;
    final strings = context.strings;
    final historyState = ref.caseHistoryState;

    return Scaffold(
      backgroundColor: colors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Hero: Red Theatrical Draped Curtain Banner with Judge Barnaby & Speech Bubble
              _HomeCourtroomHeroBanner(colors: colors),
              const SizedBox(height: AppSpacing.base),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Primary CTA: Warm Caramel "Start a New Case"
                    AppButton(
                      label: strings.btnQuickStart,
                      icon: const Icon(Icons.gavel, size: 20.0),
                      isFullWidth: true,
                      variant: AppButtonVariant.primaryGold,
                      onPressed: () {
                        const CreateCaseRoute().push(context);
                      },
                    ),
                    const SizedBox(height: AppSpacing.l),

                    // Suggested Cases (Vertical List matching mockup Screen 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          strings.homeTemplatesHeader,
                          style: AppTextStyle.titleMedium,
                          fontWeight: FontWeight.w800,
                        ),
                        AppText(
                          'See all ›',
                          style: AppTextStyle.caption,
                          color: colors.text2,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s),
                    _VerticalSuggestedCasesList(
                      templates: SuggestedCasesFixture.catalog.take(3).toList(),
                    ),
                    const SizedBox(height: AppSpacing.l),

                    // My Cases (Matching mockup Screen 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          strings.tabCases,
                          style: AppTextStyle.titleMedium,
                          fontWeight: FontWeight.w800,
                        ),
                        AppText(
                          'See all ›',
                          style: AppTextStyle.caption,
                          color: colors.text2,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s),
                    if (historyState.allCases.isEmpty)
                      const _EmptyRecentCasesView()
                    else
                      ...historyState.allCases.take(3).map(
                            (c) => _RecentCaseDocketItem(courtCase: c),
                          ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeCourtroomHeroBanner extends StatelessWidget {
  const _HomeCourtroomHeroBanner({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF6A1A24), // Rich courtroom curtain red
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32.0),
          bottomRight: Radius.circular(32.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Glowing Golden Scales at the very top
          Icon(
            Icons.balance,
            size: 32.0,
            color: colors.bookmarkYellow,
          ),
          const SizedBox(height: 6.0),

          // Chibi Judge Barnaby
          const JudgeMascotView(
            expression: JudgeExpression.laughing,
            size: 96.0,
          ),
          const SizedBox(height: 12.0),

          // Speech Bubble: "Order! Order! / Welcome to Tiny Court!"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 10.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  'Order! Order!',
                  style: AppTextStyle.titleMedium,
                  color: colors.inkBlack,
                  fontWeight: FontWeight.w900,
                  align: TextAlign.center,
                ),
                AppText(
                  'Welcome to Tiny Court!',
                  style: AppTextStyle.caption,
                  color: colors.text2,
                  fontWeight: FontWeight.w600,
                  align: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalSuggestedCasesList extends StatelessWidget {
  const _VerticalSuggestedCasesList({required this.templates});

  final List<SuggestedCase> templates;

  IconData _getCategoryIcon(CaseCategory category) {
    return switch (category) {
      CaseCategory.food => Icons.local_pizza_outlined,
      CaseCategory.friendship => Icons.event_available_outlined,
      CaseCategory.relationships => Icons.tv_outlined,
      CaseCategory.work => Icons.coffee_outlined,
      _ => Icons.lightbulb_outline,
    };
  }

  Color _getCategoryBgColor(CaseCategory category) {
    return switch (category) {
      CaseCategory.food => const Color(0xFFFFF3E0),
      CaseCategory.friendship => const Color(0xFFF3E5F5),
      CaseCategory.relationships => const Color(0xFFE1F5FE),
      CaseCategory.work => const Color(0xFFEFEBE9),
      _ => const Color(0xFFFFF8E1),
    };
  }

  Color _getCategoryIconColor(CaseCategory category) {
    return switch (category) {
      CaseCategory.food => const Color(0xFFE65100),
      CaseCategory.friendship => const Color(0xFF8E24AA),
      CaseCategory.relationships => const Color(0xFF0288D1),
      CaseCategory.work => const Color(0xFF6D4C41),
      _ => const Color(0xFFF57F17),
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: templates.map((template) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.s),
          child: ParchmentCard(
            elevation: 1.0,
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            onTap: () {
              CreateCaseRoute(templateId: template.id).push(context);
            },
            child: Row(
              children: [
                Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: _getCategoryBgColor(template.category),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Icon(
                    _getCategoryIcon(template.category),
                    size: 24.0,
                    color: _getCategoryIconColor(template.category),
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: AppText(
                    template.title,
                    style: AppTextStyle.bodyMedium,
                    color: colors.text,
                    fontWeight: FontWeight.w700,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.chevron_right, size: 20.0, color: colors.text3),
              ],
            ),
          ),
        );
      }).toList(),
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
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
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
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: colors.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Icon(
                Icons.balance,
                size: 22.0,
                color: colors.accent,
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    courtCase.title,
                    style: AppTextStyle.bodyMedium,
                    color: colors.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 2.0),
                  AppText(
                    '${courtCase.plaintiffName} vs ${courtCase.defendantName}',
                    style: AppTextStyle.caption,
                    color: colors.text2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: courtCase.status.name == 'decided'
                    ? colors.mintGreen
                    : colors.surface2,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: AppText(
                courtCase.status.name == 'decided'
                    ? 'Verdict Ready'
                    : courtCase.status.name.toUpperCase(),
                style: AppTextStyle.caption,
                color: courtCase.status.name == 'decided'
                    ? colors.mintGreenDark
                    : colors.text2,
                fontWeight: FontWeight.w700,
              ),
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
        borderRadius: BorderRadius.circular(20.0),
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
