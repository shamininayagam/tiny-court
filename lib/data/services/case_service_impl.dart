import 'package:uuid/uuid.dart';

import '../../core/exceptions/app_exception.dart';
import '../../core/services/case_service.dart';
import '../../model/case.dart';
import '../../model/enums/case_category.dart';
import '../../model/enums/case_status.dart';
import '../../model/suggested_case.dart';
import '../fixtures/suggested_cases_fixture.dart';
import '../storage/app_storage.dart';

class CaseServiceImpl implements CaseService {
  final AppStorage _storage;
  final Uuid _uuid;

  CaseServiceImpl(this._storage, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  @override
  Future<void> init() async {}

  @override
  void dispose() {}

  @override
  Future<Case> createCase({
    required String title,
    required CaseCategory category,
    String? description,
    String? plaintiffName,
    String? plaintiffArgument,
    String? defendantName,
    String? defendantArgument,
    String? suggestedCaseId,
  }) async {
    final now = DateTime.now().toUtc();
    final seq = await _storage.getNextCaseNumberSequence();
    final paddedSeq = seq.toString().padLeft(5, '0');
    final caseNumber = 'TC-${now.year}-$paddedSeq';

    final newCase = Case((b) => b
      ..id = _uuid.v4()
      ..caseNumber = caseNumber
      ..title = title.trim()
      ..description = description?.trim()
      ..category = category
      ..plaintiffName = (plaintiffName ?? '').trim()
      ..plaintiffArgument = (plaintiffArgument ?? '').trim()
      ..defendantName = (defendantName ?? '').trim()
      ..defendantArgument = (defendantArgument ?? '').trim()
      ..status = CaseStatus.draft
      ..suggestedCaseId = suggestedCaseId
      ..createdAt = now
      ..updatedAt = now);

    await _storage.saveCase(newCase);
    return newCase;
  }

  @override
  Future<Case> getCaseById(String id) async {
    final c = _storage.getCase(id);
    if (c == null) {
      throw CaseNotFoundException(id);
    }
    return c;
  }

  @override
  Future<List<Case>> getAllCases({
    CaseStatus? status,
    CaseCategory? category,
    String? searchQuery,
  }) async {
    final ids = _storage.getCaseIds();
    final List<Case> result = [];
    final query = searchQuery?.trim().toLowerCase();

    for (final id in ids) {
      final c = _storage.getCase(id);
      if (c == null) continue;

      if (status != null && c.status != status) continue;
      if (category != null && c.category != category) continue;
      if (query != null && query.isNotEmpty) {
        final matchesTitle = c.title.toLowerCase().contains(query);
        final matchesPlaintiff = c.plaintiffName.toLowerCase().contains(query);
        final matchesDefendant = c.defendantName.toLowerCase().contains(query);
        if (!matchesTitle && !matchesPlaintiff && !matchesDefendant) {
          continue;
        }
      }

      result.add(c);
    }
    return result;
  }

  @override
  Future<Map<CaseStatus, int>> getCaseCounts() async {
    final ids = _storage.getCaseIds();
    final counts = <CaseStatus, int>{
      CaseStatus.draft: 0,
      CaseStatus.submitted: 0,
      CaseStatus.decided: 0,
    };

    for (final id in ids) {
      final c = _storage.getCase(id);
      if (c != null && counts.containsKey(c.status)) {
        counts[c.status] = (counts[c.status] ?? 0) + 1;
      }
    }
    return counts;
  }

  @override
  Future<Case> updateCase(Case updatedCase) async {
    final existing = await getCaseById(updatedCase.id);
    if (existing.status == CaseStatus.decided) {
      throw CaseAlreadyDecidedException(updatedCase.id);
    }

    final modified = updatedCase.rebuild((b) => b
      ..updatedAt = DateTime.now().toUtc());

    await _storage.saveCase(modified);
    return modified;
  }

  @override
  Future<void> deleteCase(String id) async {
    await _storage.deleteCase(id);
  }

  @override
  Future<Case> submitCase(String id) async {
    final existing = await getCaseById(id);
    if (existing.status == CaseStatus.decided) {
      throw CaseAlreadyDecidedException(id);
    }

    final errors = <String, String>{};
    if (existing.title.trim().isEmpty) {
      errors['title'] = 'Case title cannot be empty.';
    }
    if (existing.plaintiffName.trim().isEmpty) {
      errors['plaintiffName'] = 'Plaintiff name cannot be empty.';
    }
    if (existing.plaintiffArgument.trim().isEmpty) {
      errors['plaintiffArgument'] = 'Plaintiff argument cannot be empty.';
    }
    if (existing.defendantName.trim().isEmpty) {
      errors['defendantName'] = 'Defendant name cannot be empty.';
    }
    if (existing.defendantArgument.trim().isEmpty) {
      errors['defendantArgument'] = 'Defendant argument cannot be empty.';
    }

    if (errors.isNotEmpty) {
      throw CaseValidationException(errors);
    }

    final submitted = existing.rebuild((b) => b
      ..status = CaseStatus.submitted
      ..updatedAt = DateTime.now().toUtc());

    await _storage.saveCase(submitted);
    return submitted;
  }

  @override
  Future<Case> markCaseDecided(String id, String verdictId) async {
    final existing = await getCaseById(id);
    final decided = existing.rebuild((b) => b
      ..status = CaseStatus.decided
      ..verdictId = verdictId
      ..updatedAt = DateTime.now().toUtc());

    await _storage.saveCase(decided);
    return decided;
  }

  @override
  Future<List<SuggestedCase>> getSuggestedCases() async {
    return SuggestedCasesFixture.catalog;
  }
}
