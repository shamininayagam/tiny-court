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

  void _onStatusSelected(CaseStatus? status) {
    filterHistoryByStatus(status: status);
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
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: colors.bg,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _HistorySearchField(
              controller: _searchController,
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: AppSpacing.s),
            _StatusFilterPillBar(
              selectedStatus: state.selectedStatus,
              onSelected: _onStatusSelected,
            ),
            const SizedBox(height: AppSpacing.s),
            _CategoryFilterBar(
              selectedCategory: state.selectedCategory,
              onSelected: _onCategorySelected,
            ),
            const SizedBox(height: AppSpacing.s),
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
        vertical: AppSpacing.xs,
      ),
      color: colors.bg,
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
          fillColor: colors.surface1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: colors.hairline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: colors.hairline),
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

class _StatusFilterPillBar extends StatelessWidget {
  const _StatusFilterPillBar({
    required this.selectedStatus,
    required this.onSelected,
  });

  final CaseStatus? selectedStatus;
  final ValueChanged<CaseStatus?> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: colors.surface2,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatusPillItem(
              label: 'All',
              isSelected: selectedStatus == null,
              onTap: () => onSelected(null),
            ),
          ),
          Expanded(
            child: _StatusPillItem(
              label: 'Submitted',
              isSelected: selectedStatus == CaseStatus.submitted,
              onTap: () => onSelected(CaseStatus.submitted),
            ),
          ),
          Expanded(
            child: _StatusPillItem(
              label: 'Decided',
              isSelected: selectedStatus == CaseStatus.decided,
              onTap: () => onSelected(CaseStatus.decided),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPillItem extends StatelessWidget {
  const _StatusPillItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? colors.surface1 : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colors.text.withValues(alpha: 0.05),
                    blurRadius: 4.0,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: AppText(
            label,
            style: AppTextStyle.caption,
            color: isSelected ? colors.text : colors.text2,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
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

    return SizedBox(
      height: 38,
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
                    ? colors.inkBlack
                    : colors.text,
                fontWeight: selectedCategory == null ? FontWeight.w800 : FontWeight.w600,
              ),
              selected: selectedCategory == null,
              selectedColor: colors.accent,
              backgroundColor: colors.surface1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: colors.hairline),
              ),
              onSelected: (_) => onSelected(null),
            ),
          ),
          ...CaseCategory.values.map((cat) {
            final isSelected = selectedCategory == cat;
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.s),
              child: FilterChip(
                label: AppText(
                  cat.displayName,
                  style: AppTextStyle.caption,
                  color: isSelected ? colors.inkBlack : colors.text,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                ),
                selected: isSelected,
                selectedColor: colors.accent,
                backgroundColor: colors.surface1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: colors.hairline),
                ),
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

  IconData _getCategoryIcon(CaseCategory category) {
    return switch (category) {
      CaseCategory.food => Icons.local_pizza_outlined,
      CaseCategory.friendship => Icons.event_available_outlined,
      CaseCategory.relationships => Icons.tv_outlined,
      CaseCategory.work => Icons.coffee_outlined,
      _ => Icons.balance,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ParchmentCard(
      onTap: onTap,
      padding: AppSpacing.p12,
      child: Row(
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: colors.surface2,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Icon(
              _getCategoryIcon(courtCase.category),
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
                  fontWeight: FontWeight.w700,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2.0),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: courtCase.status == CaseStatus.decided
                            ? colors.mintGreen
                            : colors.plaintiffRose,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: AppText(
                        courtCase.status == CaseStatus.decided
                            ? 'Not Guilty'
                            : 'Submitted',
                        style: AppTextStyle.caption,
                        color: courtCase.status == CaseStatus.decided
                            ? colors.mintGreenDark
                            : colors.plaintiffRed,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s),
                    AppText(
                      courtCase.caseNumber,
                      style: AppTextStyle.caption,
                      color: colors.text3,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              size: 20,
              color: colors.text3,
            ),
            onPressed: onDelete,
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
              fontWeight: FontWeight.w700,
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
