import '../../model/case.dart';
import '../../model/verdict.dart';

/// Contract for all judicial decision engines in Tiny Court.
///
/// Engines must be pure Dart, side-effect-free, and deterministic.
abstract interface class VerdictEngine {
  /// Evaluates the submitted case and produces a complete, humorous verdict.
  Verdict evaluate(Case submittedCase);
}
