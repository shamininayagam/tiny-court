import '../../mixins/case_history_mixin.dart';
import '../../model/case.dart';
import '../../model/enums/case_category.dart';
import '../../model/enums/case_status.dart';
import '../../ui.dart';
import '../navigation/app_routes.dart';

/// Tab presenting the complete archive of past petty disputes and their status.
class MyCasesTab extends AppConsumerStatefulWidget {
  const MyCasesTab({super.key});

  @override
  MyCasesTabState createState() => MyCasesTabState();
}

class MyCasesTabState extends AppConsumerState<MyCasesTab>
    with CaseHistoryMixin {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadHistoricalCases();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    searchHistoricalCases(query: query);
  }

  void _onCategorySelected(CaseCategory? category) {
    filterHistoryByCategory(category: category);
  }

  void _onCaseTap(Case courtCase) {
    CaseDetailsRoute(id: courtCase.id).push(context);
  }

  Future<void> _onDeleteCase(Case courtCase) async {
    final strings = context.strings;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: context.colors.surface1,
        title: AppText(
          courtCase.title,
          style: AppTextStyle.titleMedium,
        ),
        content: AppText(
          strings.historyDeleteConfirm,
          style: AppTextStyle.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: AppText(strings.btnCancel, style: AppTextStyle.label),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: AppText(
              strings.btnDelete,
              style: AppTextStyle.label,
              color: context.colors.danger,
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await deleteHistoricalCase(caseId: courtCase.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;
    final state = historyState;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(
        title: AppText(
          strings.historyTitle,
          style: AppTextStyle.titleMedium,
        ),
        backgroundColor: colors.surface1,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _HistorySearchField(
              controller: _searchController,
              onChanged: _onSearchChanged,
            ),
            _CategoryFilterBar(
              selectedCategory: state.selectedCategory,
              onSelected: _onCategorySelected,
            ),
            Expanded(
              child: state.isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: colors.gavelGold),
                    )
                  : state.filteredCases.isEmpty
                      ? const _EmptyCasesView()
                      : ListView.separated(
                          padding: AppSpacing.screenGutter,
                          itemCount: state.filteredCases.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: AppSpacing.s),
                          itemBuilder: (context, index) {
                            final c = state.filteredCases[index];
                            return _CaseDocketListItem(
                              courtCase: c,
                              onTap: () => _onCaseTap(c),
                              onDelete: () => _onDeleteCase(c),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistorySearchField extends StatelessWidget {
  const _HistorySearchField({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.s,
      ),
      color: colors.surface1,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: strings.historySearchHint,
          prefixIcon: Icon(Icons.search, color: colors.text2),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: colors.text2),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                )
              : null,
          filled: true,
          fillColor: colors.surface2,
          border: OutlineInputBorder(
            borderRadius: AppRadius.smAll,
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.s,
          ),
        ),
      ),
    );
  }
}

class _CategoryFilterBar extends StatelessWidget {
  const _CategoryFilterBar({
    required this.selectedCategory,
    required this.onSelected,
  });

  final CaseCategory? selectedCategory;
  final ValueChanged<CaseCategory?> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = context.strings;

    return Container(
      height: 48,
      color: colors.surface1,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.s),
            child: FilterChip(
              label: AppText(
                strings.historyFilterAll,
                style: AppTextStyle.caption,
                color: selectedCategory == null
                    ? colors.bg
                    : colors.text,
              ),
              selected: selectedCategory == null,
              selectedColor: colors.gavelGold,
              backgroundColor: colors.surface2,
              onSelected: (_) => onSelected(null),
            ),
          ),
          ...CaseCategory.values.map((cat) {
            final isSelected = selectedCategory == cat;
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.s),
              child: FilterChip(
                label: AppText(
                  cat.name.toUpperCase(),
                  style: AppTextStyle.caption,
                  color: isSelected ? colors.bg : colors.text,
                ),
                selected: isSelected,
                selectedColor: colors.gavelGold,
                backgroundColor: colors.surface2,
                onSelected: (_) => onSelected(isSelected ? null : cat),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CaseDocketListItem extends StatelessWidget {
  const _CaseDocketListItem({
    required this.courtCase,
    required this.onTap,
    required this.onDelete,
  });

  final Case courtCase;
  final VoidCallback onTap;
  final VoidCallback onDelete;

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
      onTap: onTap,
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
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: colors.text2,
                    ),
                    onPressed: onDelete,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s),
          AppText(
            courtCase.title,
            style: AppTextStyle.titleMedium,
            color: colors.text,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(Icons.person_outline, size: 14, color: colors.text2),
              const SizedBox(width: AppSpacing.xs),
              AppText(
                '${courtCase.plaintiffName} v. ${courtCase.defendantName}',
                style: AppTextStyle.caption,
                color: colors.text2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyCasesView extends StatelessWidget {
  const _EmptyCasesView();

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
            Icon(
              Icons.folder_open_outlined,
              size: 56,
              color: colors.gavelGold.withValues(alpha: 0.6),
            ),
            const SizedBox(height: AppSpacing.base),
            AppText(
              strings.historyEmptyTitle,
              style: AppTextStyle.titleMedium,
              color: colors.text,
            ),
            const SizedBox(height: AppSpacing.s),
            AppText(
              strings.historyEmptySubtitle,
              style: AppTextStyle.bodyMedium,
              color: colors.text2,
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
