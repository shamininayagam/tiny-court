import '../../model/case.dart';
import '../../model/verdict.dart';
import 'service.dart';

/// Contract for verdict retrieval, generation, and persistence.
abstract interface class VerdictService implements Service {
  /// Fetches an existing verdict by its unique ID.
  Future<Verdict?> getVerdictById(String verdictId);

  /// Fetches the verdict associated with a specific case ID.
  /// Returns null if the case has not yet completed trial.
  Future<Verdict?> getVerdictByCaseId(String caseId);

  /// Performs adjudication:
  /// 1. Checks if a verdict already exists in persistence (returns it if so).
  /// 2. If not, evaluates via the VerdictEngine.
  /// 3. Saves the verdict in local storage.
  /// 4. Updates case status to Decided.
  /// 5. Returns the finalized verdict.
  Future<Verdict> adjudicateCase(Case submittedCase);

  /// Deletes a verdict associated with a case.
  Future<void> deleteVerdictByCaseId(String caseId);
}
