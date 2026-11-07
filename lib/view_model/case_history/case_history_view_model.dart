import 'package:built_collection/built_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/services/case_service.dart';
import '../../data/repository.dart';
import '../../model/case.dart';
import '../../model/enums/case_category.dart';
import '../../model/enums/case_status.dart';
import '../../model/states/case_history_state.dart';
import '../../provider/app_providers.dart';
import '../../utils/app_logger.dart';
import '../base_view_model.dart';

part 'case_history_view_model.g.dart';

/// Feature ViewModel managing case history loading, dynamic text search, and category/status filtering.
@Riverpod(keepAlive: true)
class CaseHistoryViewModel extends _$CaseHistoryViewModel implements BaseViewModel {
  CaseHistoryViewModel({CaseService? caseService})
      : _caseServiceOverride = caseService;

  static const String _tag = 'CaseHistoryViewModel';
  static final AppLogger _log = AppLogger.get(_tag);

  final CaseService? _caseServiceOverride;

  AppRepository get _repo => ref.read(appRepositoryProvider);

  CaseService get _caseService =>
      _caseServiceOverride ?? _repo.caseService;

  @override
  CaseHistoryState build() {
    ref.onDispose(() {
      dispose();
    });
    Future.microtask(loadCases);
    return CaseHistoryState.initial();
  }

  @override
  Future<void> init() async {
    await loadCases();
  }

  @override
  Future<void> dispose() async {}

  Future<void> loadCases() async {
    _log.debug('📜 Loading all historical cases from CaseService...');
    state = state.rebuild((b) => b..isLoading = true);
    try {
      final all = await _caseService.getAllCases();
      final filtered = _applyFilters(
        all,
        state.searchQuery,
        state.selectedStatus,
        state.selectedCategory,
      );

      state = state.rebuild((b) => b
        ..allCases = ListBuilder<Case>(all)
        ..filteredCases = ListBuilder<Case>(filtered)
        ..isLoading = false
        ..errorMessage = null);
      _log.debug('✅ Historical cases loaded. Count: ${all.length}');
    } catch (e, st) {
      _log.error('❌ loadCases error: $e', error: e, stackTrace: st);
      state = state.rebuild((b) => b
        ..isLoading = false
        ..errorMessage = e.toString());
      rethrow;
    }
  }

  void setSearchQuery(String query) {
    final filtered = _applyFilters(
      state.allCases.toList(),
      query,
      state.selectedStatus,
      state.selectedCategory,
    );
    state = state.rebuild((b) => b
      ..searchQuery = query
      ..filteredCases = ListBuilder<Case>(filtered));
  }

  void setStatusFilter(CaseStatus? status) {
    final filtered = _applyFilters(
      state.allCases.toList(),
      state.searchQuery,
      status,
      state.selectedCategory,
    );
    state = state.rebuild((b) => b
      ..selectedStatus = status
      ..filteredCases = ListBuilder<Case>(filtered));
  }

  void setCategoryFilter(CaseCategory? category) {
    final filtered = _applyFilters(
      state.allCases.toList(),
      state.searchQuery,
      state.selectedStatus,
      category,
    );
    state = state.rebuild((b) => b
      ..selectedCategory = category
      ..filteredCases = ListBuilder<Case>(filtered));
  }

  void clearFilters() {
    _log.debug('🧹 Clearing history filters.');
    final filtered = _applyFilters(
      state.allCases.toList(),
      '',
      null,
      null,
    );
    state = state.rebuild((b) => b
      ..searchQuery = ''
      ..selectedStatus = null
      ..selectedCategory = null
      ..filteredCases = ListBuilder<Case>(filtered));
  }

  Future<void> deleteCase(String id) async {
    _log.debug('🗑️ Deleting case $id...');
    state = state.rebuild((b) => b..isLoading = true);
    try {
      await _caseService.deleteCase(id);
      final remaining = state.allCases.where((c) => c.id != id).toList();
      final filtered = _applyFilters(
        remaining,
        state.searchQuery,
        state.selectedStatus,
        state.selectedCategory,
      );

      state = state.rebuild((b) => b
        ..allCases = ListBuilder<Case>(remaining)
        ..filteredCases = ListBuilder<Case>(filtered)
        ..isLoading = false);
      _log.debug('✅ Case $id deleted.');
    } catch (e, st) {
      _log.error('❌ deleteCase error: $e', error: e, stackTrace: st);
      state = state.rebuild((b) => b..isLoading = false);
      rethrow;
    }
  }

  List<Case> _applyFilters(
    List<Case> source,
    String query,
    CaseStatus? status,
    CaseCategory? category,
  ) {
    return source.where((c) {
      if (status != null && c.status != status) return false;
      if (category != null && c.category != category) return false;
      if (query.isNotEmpty) {
        final q = query.toLowerCase();
        final matchesTitle = c.title.toLowerCase().contains(q);
        final matchesPlaintiff = c.plaintiffName.toLowerCase().contains(q);
        final matchesDefendant = c.defendantName.toLowerCase().contains(q);
        final matchesNumber = c.caseNumber.toLowerCase().contains(q);
        return matchesTitle || matchesPlaintiff || matchesDefendant || matchesNumber;
      }
      return true;
    }).toList();
  }
}
