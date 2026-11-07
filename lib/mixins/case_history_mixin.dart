import '../model/enums/case_category.dart';
import '../model/enums/case_status.dart';
import '../model/states/case_history_state.dart';
import '../ui.dart';

/// Mixin providing UI access to historical cases, search, and category filters.
///
/// Flow: UI -> CaseHistoryMixin -> CaseHistoryViewModel -> CaseService -> CaseServiceImpl
///
/// Dispatches actions to [CaseHistoryViewModel] via [appRef] with structured logging,
/// mounted-guarded error presentation, and rethrow semantics adhering to the pogo_alarm standard.
mixin CaseHistoryMixin<T extends AppConsumerStatefulWidget>
    on AppConsumerState<T> {
  static const String _tag = 'CaseHistoryMixin';
  static final AppLogger _log = AppLogger.get(_tag);

  /// Reactive watch on the case history state.
  CaseHistoryState get historyState => appRef.caseHistoryState;

  /// Reloads all saved cases from the repository.
  Future<void> loadHistoricalCases() async {
    _log.debug('📜 Loading historical cases...');
    try {
      await appRef.caseHistoryViewModel.loadCases();
      _log.debug(
          '✅ Historical cases loaded. Count: ${historyState.filteredCases.length}');
    } catch (e, st) {
      _log.error(
        '❌ loadHistoricalCases() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Filters historical cases by title or party name query.
  void searchHistoricalCases({required String query}) {
    _log.debug('🔍 Searching cases with query: "$query"');
    try {
      appRef.caseHistoryViewModel.setSearchQuery(query);
    } catch (e, st) {
      _log.error(
        '❌ searchHistoricalCases() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Filters cases by lifecycle status.
  void filterHistoryByStatus({CaseStatus? status}) {
    _log.debug('🏷️ Filtering cases by status: $status');
    try {
      appRef.caseHistoryViewModel.setStatusFilter(status);
    } catch (e, st) {
      _log.error(
        '❌ filterHistoryByStatus() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Filters cases by dispute category.
  void filterHistoryByCategory({CaseCategory? category}) {
    _log.debug('📁 Filtering cases by category: $category');
    try {
      appRef.caseHistoryViewModel.setCategoryFilter(category);
    } catch (e, st) {
      _log.error(
        '❌ filterHistoryByCategory() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Clears all active filters and search queries.
  void clearHistoryFilters() {
    _log.debug('🧹 Clearing all history filters...');
    try {
      appRef.caseHistoryViewModel.clearFilters();
    } catch (e, st) {
      _log.error(
        '❌ clearHistoryFilters() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Permanently deletes a case and its saved verdict.
  Future<void> deleteHistoricalCase({required String caseId}) async {
    _log.debug('🗑️ Deleting historical case: $caseId');
    try {
      await appRef.caseHistoryViewModel.deleteCase(caseId);
      _log.debug('✅ Case $caseId deleted successfully.');
    } catch (e, st) {
      _log.error(
        '❌ deleteHistoricalCase() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }
}
