import '../../model/case.dart';
import '../../model/enums/case_category.dart';
import '../../model/verdict.dart';
import 'verdict_catalog.dart';
import 'verdict_engine.dart';

/// Pure-Dart deterministic rule-based verdict engine.
///
/// Evaluates disputes through:
/// 1. Argument length disparity heuristics (e.g. essays vs one-word replies)
/// 2. Category-specific semantic keyword matching
/// 3. Seeded deterministic fallback based on case ID hash
class RuleBasedVerdictEngine implements VerdictEngine {
  const RuleBasedVerdictEngine();

  @override
  Verdict evaluate(Case submittedCase) {
    final pArg = submittedCase.plaintiffArgument.trim().toLowerCase();
    final dArg = submittedCase.defendantArgument.trim().toLowerCase();
    final combinedText = '$pArg $dArg ${submittedCase.title.toLowerCase()}';

    // 1. Extreme Length Disparity Rule:
    // Plaintiff writes essays (>= 120 chars) and Defendant gives cold 1-word answer (<= 15 chars)
    if (pArg.length >= 120 && dArg.length <= 15) {
      return VerdictCatalog.extremeIndifference
          .toVerdict(submittedCase, customRuleId: 'rule_length_disparity');
    }

    // 2. Frivolous Accusation Rule:
    // Plaintiff gave virtually no argument (<= 5 chars)
    if (pArg.length <= 5 && dArg.length >= 25) {
      return VerdictCatalog.frivolousOverreaction
          .toVerdict(submittedCase, customRuleId: 'rule_frivolous_claim');
    }

    // 3. Category-Specific Keyword Heuristics
    final matchedTemplate = _evaluateCategoryRules(
      submittedCase.category,
      pArg,
      dArg,
      combinedText,
    );

    if (matchedTemplate != null) {
      return matchedTemplate.toVerdict(submittedCase);
    }

    // 4. Seeded Deterministic Fallback:
    // Guarantees 100% reproducible results for identical case IDs without random jitter
    return _evaluateDeterministicFallback(submittedCase);
  }

  VerdictTemplate? _evaluateCategoryRules(
    CaseCategory category,
    String pArg,
    String dArg,
    String text,
  ) {
    return switch (category) {
      CaseCategory.food => _evaluateFoodRules(text),
      CaseCategory.friendship => _evaluateFriendshipRules(text),
      CaseCategory.relationships => _evaluateRelationshipRules(text),
      CaseCategory.work => _evaluateWorkRules(text),
      CaseCategory.random => _evaluateRandomRules(text),
      _ => null,
    };
  }

  VerdictTemplate? _evaluateFoodRules(String text) {
    // If maritime salvage or unclaimed fridge time
    if (text.contains('salvage') ||
        text.contains('abandon') ||
        (text.contains('fridge') &&
            (text.contains('hours') || text.contains('days')))) {
      return VerdictCatalog.foodMaritimeSalvage;
    }
    // If blatant theft of labeled or owned food
    if (text.contains('label') ||
        text.contains('name') ||
        text.contains('stole') ||
        text.contains('last slice') ||
        text.contains('fries')) {
      return VerdictCatalog.foodDefendantGuilty;
    }
    return VerdictCatalog.foodBothGuilty;
  }

  VerdictTemplate? _evaluateFriendshipRules(String text) {
    if (text.contains('cancel') ||
        text.contains('flak') ||
        text.contains('late') ||
        text.contains('shoes') ||
        text.contains('dressed')) {
      return VerdictCatalog.friendshipDefendantGuilty;
    }
    if (text.contains('misunderstand') ||
        text.contains('accident') ||
        text.contains('sorry')) {
      return VerdictCatalog.friendshipDismissed;
    }
    return null; // Delegate to category pool
  }

  VerdictTemplate? _evaluateRelationshipRules(String text) {
    if (text.contains('read') ||
        text.contains('episode') ||
        text.contains('binge') ||
        text.contains('phone') ||
        text.contains('tv')) {
      return VerdictCatalog.relationshipDefendantGuilty;
    }
    if (text.contains('telepath') ||
        text.contains('mind') ||
        text.contains('guess')) {
      return VerdictCatalog.relationshipBothGuilty;
    }
    return null; // Delegate to category pool
  }

  VerdictTemplate? _evaluateWorkRules(String text) {
    if (text.contains('soak') ||
        text.contains('sink') ||
        text.contains('mug') ||
        text.contains('dishes') ||
        text.contains('thermostat')) {
      return VerdictCatalog.workDefendantGuilty;
    }
    if (text.contains('clean freak') ||
        text.contains('inspect') ||
        text.contains('relax')) {
      return VerdictCatalog.workNotGuilty;
    }
    return null; // Delegate to category pool
  }

  VerdictTemplate? _evaluateRandomRules(String text) {
    if (text.contains('hmm') || text.contains('whatever')) {
      return VerdictCatalog.extremeIndifference;
    }
    return null; // Delegate to category pool
  }

  Verdict _evaluateDeterministicFallback(Case submittedCase) {
    final pool = VerdictCatalog.getTemplatesForCategory(submittedCase.category);
    final hash = submittedCase.id.codeUnits.fold(0, (a, b) => (a * 31 + b) & 0x7FFFFFFF);
    final selectedTemplate = pool[hash % pool.length];
    return selectedTemplate.toVerdict(
      submittedCase,
      customRuleId: 'fallback_${selectedTemplate.ruleId}',
    );
  }
}
