import '../../data/fixtures/suggested_cases_fixture.dart';
import '../../mixins/mixins.dart';
import '../../model/enums/case_category.dart';
import '../../model/states/case_draft_state.dart';
import '../../ui.dart';
import '../navigation/app_routes.dart';

/// Multi-step Case Creation Wizard Screen wired with [CaseDraftMixin].
class CreateCaseScreen extends AppConsumerStatefulWidget {
  const CreateCaseScreen({super.key, this.templateId});

  final String? templateId;

  @override
  CreateCaseScreenState createState() => CreateCaseScreenState();
}

class CreateCaseScreenState extends AppConsumerState<CreateCaseScreen>
    with CaseDraftMixin {
  late final TextEditingController _titleController;
  late final TextEditingController _contextController;
  late final TextEditingController _plaintiffNameController;
  late final TextEditingController _plaintiffArgController;
  late final TextEditingController _defendantNameController;
  late final TextEditingController _defendantArgController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contextController = TextEditingController();
    _plaintiffNameController = TextEditingController();
    _plaintiffArgController = TextEditingController();
    _defendantNameController = TextEditingController();
    _defendantArgController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.templateId != null) {
        final template = SuggestedCasesFixture.catalog.firstWhere(
          (t) => t.id == widget.templateId,
          orElse: () => SuggestedCasesFixture.catalog.first,
        );
        initDraftFromTemplate(template: template);
        _syncControllersWithDraft();
      } else {
        resetDraft();
      }
    });
  }

  void _syncControllersWithDraft() {
    _titleController.text = draftState.title;
    _contextController.text = draftState.description ?? '';
    _plaintiffNameController.text = draftState.plaintiffName;
    _plaintiffArgController.text = draftState.plaintiffArgument;
    _defendantNameController.text = draftState.defendantName;
    _defendantArgController.text = draftState.defendantArgument;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contextController.dispose();
    _plaintiffNameController.dispose();
    _plaintiffArgController.dispose();
    _defendantNameController.dispose();
    _defendantArgController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    // Sync current step inputs into draft
    switch (draftState.activeStep) {
      case DraftStep.overview:
        updateDraftOverview(
          title: _titleController.text.trim(),
          category: draftState.category,
          description: _contextController.text.trim(),
        );
        break;
      case DraftStep.plaintiff:
        updateDraftPlaintiff(
          name: _plaintiffNameController.text.trim(),
          argument: _plaintiffArgController.text.trim(),
        );
        break;
      case DraftStep.defendant:
        updateDraftDefendant(
          name: _defendantNameController.text.trim(),
          argument: _defendantArgController.text.trim(),
        );
        break;
      default:
        break;
    }

    final bool advanced = nextDraftStep();
    if (advanced && draftState.activeStep == DraftStep.review) {
      _onSubmitToCourt();
    }
  }

  Future<void> _onSubmitToCourt() async {
    final createdCase = await submitDraftCase();
    if (createdCase != null && mounted) {
      ReviewCaseRoute(id: createdCase.id).go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;
    final step = draftState.activeStep;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(
        title: AppText(
          switch (step) {
            DraftStep.overview => strings.wizardStepOverview,
            DraftStep.plaintiff => strings.wizardStepPlaintiff,
            DraftStep.defendant => strings.wizardStepDefendant,
            DraftStep.review => strings.wizardStepReview,
            _ => strings.wizardStepOverview,
          },
          style: AppTextStyle.titleMedium,
        ),
        backgroundColor: colors.surface1,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (step.index > 0) {
              previousDraftStep();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _StepProgressBar(currentStepIndex: step.index),
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.screenGutter,
                child: switch (step) {
                  DraftStep.overview => _OverviewStepView(
                      titleController: _titleController,
                      contextController: _contextController,
                      selectedCategory: draftState.category,
                      fieldErrors: draftState.fieldErrors.asMap(),
                      plaintiffName: draftState.plaintiffName,
                      defendantName: draftState.defendantName,
                      onCategoryChanged: (cat) => updateDraftOverview(
                        title: _titleController.text.trim(),
                        category: cat,
                        description: _contextController.text.trim(),
                      ),
                      onNavigateToPlaintiff: () {
                        updateDraftOverview(
                          title: _titleController.text.trim(),
                          category: draftState.category,
                          description: _contextController.text.trim(),
                        );
                        goToDraftStep(step: DraftStep.plaintiff);
                      },
                      onNavigateToDefendant: () {
                        updateDraftOverview(
                          title: _titleController.text.trim(),
                          category: draftState.category,
                          description: _contextController.text.trim(),
                        );
                        goToDraftStep(step: DraftStep.defendant);
                      },
                    ),
                  DraftStep.plaintiff => _PlaintiffStepView(
                      nameController: _plaintiffNameController,
                      argController: _plaintiffArgController,
                      fieldErrors: draftState.fieldErrors.asMap(),
                    ),
                  DraftStep.defendant => _DefendantStepView(
                      nameController: _defendantNameController,
                      argController: _defendantArgController,
                      fieldErrors: draftState.fieldErrors.asMap(),
                    ),
                  DraftStep.review => Center(
                      child: Padding(
                        padding: AppSpacing.p24,
                        child: CircularProgressIndicator(color: colors.gavelGold),
                      ),
                    ),
                  _ => const SizedBox.shrink(),
                },
              ),
            ),
            _WizardBottomActionBar(
              isSubmitting: draftState.isSubmitting,
              step: step,
              onNext: _onNextPressed,
              onBack: () {
                if (step.index > 0) {
                  previousDraftStep();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StepProgressBar extends StatelessWidget {
  const _StepProgressBar({required this.currentStepIndex});

  final int currentStepIndex;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      color: colors.surface1,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter, vertical: AppSpacing.s),
      child: Row(
        children: List.generate(3, (index) {
          final isCompleted = index < currentStepIndex;
          final isCurrent = index == currentStepIndex;

          final Color barColor = isCurrent
              ? colors.gavelGold
              : isCompleted
                  ? colors.ok
                  : colors.hairlineStrong;

          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              height: 4.0,
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: AppRadius.pillAll,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _OverviewStepView extends StatelessWidget {
  const _OverviewStepView({
    required this.titleController,
    required this.contextController,
    required this.selectedCategory,
    required this.fieldErrors,
    required this.plaintiffName,
    required this.defendantName,
    required this.onCategoryChanged,
    required this.onNavigateToPlaintiff,
    required this.onNavigateToDefendant,
  });

  final TextEditingController titleController;
  final TextEditingController contextController;
  final CaseCategory selectedCategory;
  final Map<String, String> fieldErrors;
  final String plaintiffName;
  final String defendantName;
  final ValueChanged<CaseCategory> onCategoryChanged;
  final VoidCallback onNavigateToPlaintiff;
  final VoidCallback onNavigateToDefendant;

  String _getCategoryEmoji(CaseCategory cat) {
    return switch (cat) {
      CaseCategory.food => '🍕',
      CaseCategory.friendship => '📅',
      CaseCategory.relationships => '❤️',
      CaseCategory.work => '💼',
      CaseCategory.random => '📺',
      _ => '⚖️',
    };
  }

  void _showCategoryPicker(BuildContext context) {
    final colors = context.colors;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: colors.surface1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.base),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: colors.hairlineStrong,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                const SizedBox(height: AppSpacing.m),
                AppText(
                  'Select Category',
                  style: AppTextStyle.titleMedium,
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(height: AppSpacing.s),
                ...CaseCategory.values.map((cat) {
                  final isSelected = cat == selectedCategory;
                  return ListTile(
                    leading: Text(_getCategoryEmoji(cat), style: const TextStyle(fontSize: 24.0)),
                    title: AppText(
                      cat.displayName,
                      style: AppTextStyle.bodyMedium,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                      color: isSelected ? colors.accent : colors.text,
                    ),
                    trailing: isSelected ? Icon(Icons.check_circle, color: colors.accent) : null,
                    onTap: () {
                      onCategoryChanged(cat);
                      Navigator.of(ctx).pop();
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Container(
                width: 58.0,
                height: 58.0,
                decoration: BoxDecoration(
                  color: colors.accent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.balance, size: 30.0, color: colors.accent),
              ),
              const SizedBox(height: AppSpacing.s),
              AppText(
                'Tell us about your case!',
                style: AppTextStyle.titleMedium,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(height: AppSpacing.base),
            ],
          ),
        ),

        // Case Title
        AppText(strings.wizardTitleLabel, style: AppTextStyle.label, fontWeight: FontWeight.w700),
        const SizedBox(height: AppSpacing.s),
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            hintText: strings.wizardTitleHint,
            filled: true,
            fillColor: colors.surface1,
            errorText: fieldErrors['title'],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: colors.hairline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: colors.hairline),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.base),

        // Category Dropdown Card
        AppText(strings.wizardCategoryLabel, style: AppTextStyle.label, fontWeight: FontWeight.w700),
        const SizedBox(height: AppSpacing.s),
        InkWell(
          onTap: () => _showCategoryPicker(context),
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: 14.0),
            decoration: BoxDecoration(
              color: colors.surface1,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: colors.hairline),
            ),
            child: Row(
              children: [
                Text(_getCategoryEmoji(selectedCategory), style: const TextStyle(fontSize: 18.0)),
                const SizedBox(width: AppSpacing.s),
                Expanded(
                  child: AppText(
                    selectedCategory.displayName,
                    style: AppTextStyle.bodyMedium,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: colors.text2),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.base),

        // Description (Optional)
        AppText('Description (Optional)', style: AppTextStyle.label, fontWeight: FontWeight.w700),
        const SizedBox(height: AppSpacing.s),
        TextField(
          controller: contextController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: strings.wizardContextHint,
            filled: true,
            fillColor: colors.surface1,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: colors.hairline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: colors.hairline),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.l),

        // The Parties Section matching Screen 3
        AppText(
          'The Parties',
          style: AppTextStyle.label,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(height: AppSpacing.s),

        // Plaintiff Card
        InkWell(
          onTap: onNavigateToPlaintiff,
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.base),
            decoration: BoxDecoration(
              color: colors.surface1,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: colors.hairline),
            ),
            child: Row(
              children: [
                Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: colors.plaintiffRose,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, color: Color(0xFFE05A65), size: 24.0),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Plaintiff',
                        style: AppTextStyle.bodyMedium,
                        fontWeight: FontWeight.w800,
                      ),
                      const SizedBox(height: 2.0),
                      AppText(
                        plaintiffName.isNotEmpty ? plaintiffName : 'Name & Argument',
                        style: AppTextStyle.caption,
                        color: colors.text2,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: colors.text2),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s),

        // Defendant Card
        InkWell(
          onTap: onNavigateToDefendant,
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.base),
            decoration: BoxDecoration(
              color: colors.surface1,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: colors.hairline),
            ),
            child: Row(
              children: [
                Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: colors.defendantPeriwinkle,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, color: Color(0xFF4C6EF5), size: 24.0),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Defendant',
                        style: AppTextStyle.bodyMedium,
                        fontWeight: FontWeight.w800,
                      ),
                      const SizedBox(height: 2.0),
                      AppText(
                        defendantName.isNotEmpty ? defendantName : 'Name & Argument',
                        style: AppTextStyle.caption,
                        color: colors.text2,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: colors.text2),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.l),
      ],
    );
  }
}

class _PlaintiffStepView extends StatelessWidget {
  const _PlaintiffStepView({
    required this.nameController,
    required this.argController,
    required this.fieldErrors,
  });

  final TextEditingController nameController;
  final TextEditingController argController;
  final Map<String, String> fieldErrors;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(strings.wizardPlaintiffNameLabel, style: AppTextStyle.label),
        const SizedBox(height: AppSpacing.s),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: strings.wizardPlaintiffNameHint,
            filled: true,
            fillColor: colors.surface1,
            errorText: fieldErrors['plaintiffName'],
            border: OutlineInputBorder(borderRadius: AppRadius.smAll),
          ),
        ),
        const SizedBox(height: AppSpacing.base),
        AppText(strings.wizardPlaintiffArgLabel, style: AppTextStyle.label),
        const SizedBox(height: AppSpacing.s),
        TextField(
          controller: argController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: strings.wizardPlaintiffArgHint,
            filled: true,
            fillColor: colors.surface1,
            errorText: fieldErrors['plaintiffArgument'],
            border: OutlineInputBorder(borderRadius: AppRadius.smAll),
          ),
        ),
      ],
    );
  }
}

class _DefendantStepView extends StatelessWidget {
  const _DefendantStepView({
    required this.nameController,
    required this.argController,
    required this.fieldErrors,
  });

  final TextEditingController nameController;
  final TextEditingController argController;
  final Map<String, String> fieldErrors;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(strings.wizardDefendantNameLabel, style: AppTextStyle.label),
        const SizedBox(height: AppSpacing.s),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: strings.wizardDefendantNameHint,
            filled: true,
            fillColor: colors.surface1,
            errorText: fieldErrors['defendantName'],
            border: OutlineInputBorder(borderRadius: AppRadius.smAll),
          ),
        ),
        const SizedBox(height: AppSpacing.base),
        AppText(strings.wizardDefendantArgLabel, style: AppTextStyle.label),
        const SizedBox(height: AppSpacing.s),
        TextField(
          controller: argController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: strings.wizardDefendantArgHint,
            filled: true,
            fillColor: colors.surface1,
            errorText: fieldErrors['defendantArgument'],
            border: OutlineInputBorder(borderRadius: AppRadius.smAll),
          ),
        ),
      ],
    );
  }
}

class _WizardBottomActionBar extends StatelessWidget {
  const _WizardBottomActionBar({
    required this.isSubmitting,
    required this.step,
    required this.onNext,
    required this.onBack,
  });

  final bool isSubmitting;
  final DraftStep step;
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;
    final bool isLastStep = step == DraftStep.defendant;

    return Container(
      padding: AppSpacing.screenGutter,
      decoration: BoxDecoration(
        color: colors.surface1,
        border: Border(top: BorderSide(color: colors.hairline)),
      ),
      child: step == DraftStep.overview
          ? AppButton(
              label: strings.btnNext,
              isFullWidth: true,
              variant: AppButtonVariant.royalIndigo,
              onPressed: onNext,
            )
          : Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AppButton(
                    label: strings.btnBack,
                    variant: AppButtonVariant.parchmentSecondary,
                    onPressed: isSubmitting ? null : onBack,
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  flex: 2,
                  child: AppButton(
                    label: isLastStep ? strings.btnSubmit : strings.btnNext,
                    isLoading: isSubmitting,
                    variant: AppButtonVariant.royalIndigo,
                    onPressed: onNext,
                  ),
                ),
              ],
            ),
    );
  }
}
