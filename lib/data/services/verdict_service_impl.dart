import '../../core/engine/verdict_engine.dart';
import '../../core/services/case_service.dart';
import '../../core/services/verdict_service.dart';
import '../../model/case.dart';
import '../../model/verdict.dart';
import '../storage/app_storage.dart';

class VerdictServiceImpl implements VerdictService {
  final AppStorage _storage;
  final VerdictEngine _engine;
  final CaseService _caseService;

  VerdictServiceImpl(this._storage, this._engine, this._caseService);

  @override
  Future<void> init() async {}

  @override
  void dispose() {}

  @override
  Future<Verdict?> getVerdictById(String verdictId) async {
    // Verdicts are keyed by caseId in storage
    final ids = _storage.getCaseIds();
    for (final caseId in ids) {
      final v = _storage.getVerdict(caseId);
      if (v != null && v.id == verdictId) {
        return v;
      }
    }
    return null;
  }

  @override
  Future<Verdict?> getVerdictByCaseId(String caseId) async {
    return _storage.getVerdict(caseId);
  }

  @override
  Future<Verdict> adjudicateCase(Case submittedCase) async {
    // 1. Enforce Idempotency: Return existing verdict if already decided
    final existing = _storage.getVerdict(submittedCase.id);
    if (existing != null) {
      return existing;
    }

    // 2. Evaluate through the pure-Dart rule engine
    final newVerdict = _engine.evaluate(submittedCase);

    // 3. Persist the new verdict
    await _storage.saveVerdict(newVerdict);

    // 4. Mark case status as Decided and attach verdictId
    await _caseService.markCaseDecided(submittedCase.id, newVerdict.id);

    return newVerdict;
  }

  @override
  Future<void> deleteVerdictByCaseId(String caseId) async {
    await _storage.deleteVerdict(caseId);
  }
}
