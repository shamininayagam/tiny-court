import '../../model/case.dart';
import '../../model/enums/case_category.dart';
import '../../model/enums/case_status.dart';
import '../../model/suggested_case.dart';
import 'service.dart';

/// Contract for all Case CRUD and lifecycle operations.
abstract interface class CaseService implements Service {
  // ==================== CREATE ====================

  /// Creates a new draft case with generated UUID and formatted case number.
  Future<Case> createCase({
    required String title,
    required CaseCategory category,
    String? description,
    String? plaintiffName,
    String? plaintiffArgument,
    String? defendantName,
    String? defendantArgument,
    String? suggestedCaseId,
  });

  // ==================== READ ====================

  /// Retrieves a case by its unique ID.
  /// Throws [CaseNotFoundException] if not found.
  Future<Case> getCaseById(String id);

  /// Lists all cases with optional filtering and search.
  /// Results are sorted by createdAt descending.
  Future<List<Case>> getAllCases({
    CaseStatus? status,
    CaseCategory? category,
    String? searchQuery,
  });

  /// Counts cases grouped by their status.
  Future<Map<CaseStatus, int>> getCaseCounts();

  // ==================== UPDATE ====================

  /// Updates an existing case.
  /// Throws [CaseAlreadyDecidedException] if case is already decided.
  Future<Case> updateCase(Case updatedCase);

  // ==================== DELETE ====================

  /// Deletes a case and any associated verdict from persistence.
  Future<void> deleteCase(String id);

  // ==================== LIFECYCLE TRANSITIONS ====================

  /// Validates and marks a case as Submitted to court.
  /// Throws [CaseValidationException] if arguments or names are empty.
  Future<Case> submitCase(String id);

  /// Links a finalized verdict to the case and marks status as Decided.
  Future<Case> markCaseDecided(String id, String verdictId);

  // ==================== TEMPLATES ====================

  /// Returns the static curated list of suggested case templates.
  Future<List<SuggestedCase>> getSuggestedCases();
}
