/// Base application exception for domain and service errors in Tiny Court.
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic cause;

  const AppException(this.message, {this.code, this.cause});

  @override
  String toString() => 'AppException[$code]: $message';
}

/// Thrown when a requested case is not found.
class CaseNotFoundException extends AppException {
  CaseNotFoundException(String caseId)
      : super('Case with ID "$caseId" could not be found.',
            code: 'CASE_NOT_FOUND');
}

/// Thrown when attempting to edit a case that has already received a verdict.
class CaseAlreadyDecidedException extends AppException {
  CaseAlreadyDecidedException(String caseId)
      : super('Case "$caseId" has already been decided and cannot be modified.',
            code: 'CASE_ALREADY_DECIDED');
}

/// Thrown when case submission fails validation (e.g., missing argument).
class CaseValidationException extends AppException {
  final Map<String, String> fieldErrors;

  CaseValidationException(this.fieldErrors)
      : super('Case validation failed.', code: 'CASE_VALIDATION_FAILED');
}

/// Thrown when attempting to regenerate a verdict for an already decided case.
class VerdictAlreadyFinalizedException extends AppException {
  VerdictAlreadyFinalizedException(String caseId)
      : super('Verdict for case "$caseId" has already been issued and is immutable.',
            code: 'VERDICT_ALREADY_FINALIZED');
}

/// Thrown when storage I/O fails.
class StorageException extends AppException {
  StorageException(super.message, {super.cause})
      : super(code: 'STORAGE_ERROR');
}
