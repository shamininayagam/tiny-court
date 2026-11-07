import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/case_service.dart';
import '../core/services/settings_service.dart';
import '../core/services/verdict_service.dart';
import '../data/repository.dart';
import '../model/case.dart';
import '../model/suggested_case.dart';
import '../model/verdict.dart';

/// Provider for the initialized AppRepository singleton.
final appRepositoryProvider = Provider<AppRepository>((ref) {
  throw UnimplementedError('appRepositoryProvider must be initialized in main');
});

/// Provider for CaseService.
final caseServiceProvider = Provider<CaseService>((ref) {
  return ref.watch(appRepositoryProvider).caseService;
});

/// Provider for VerdictService.
final verdictServiceProvider = Provider<VerdictService>((ref) {
  return ref.watch(appRepositoryProvider).verdictService;
});

/// Provider for SettingsService.
final settingsServiceProvider = Provider<SettingsService>((ref) {
  return ref.watch(appRepositoryProvider).settingsService;
});

/// Provider for curated suggested cases.
final suggestedCasesProvider = FutureProvider<List<SuggestedCase>>((ref) async {
  return ref.watch(caseServiceProvider).getSuggestedCases();
});

/// Provider for a single case by its ID.
final caseByIdProvider = FutureProvider.family<Case, String>((ref, id) async {
  return ref.watch(caseServiceProvider).getCaseById(id);
});

/// Provider for a verdict by case ID.
final verdictByCaseIdProvider =
    FutureProvider.family<Verdict?, String>((ref, caseId) async {
  return ref.watch(verdictServiceProvider).getVerdictByCaseId(caseId);
});
