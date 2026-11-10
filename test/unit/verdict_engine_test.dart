import 'package:flutter_test/flutter_test.dart';
import 'package:tiny_court/core/engine/rule_based_verdict_engine.dart';
import 'package:tiny_court/model/case.dart';
import 'package:tiny_court/model/enums/case_category.dart';
import 'package:tiny_court/model/enums/case_status.dart';
import 'package:tiny_court/model/enums/verdict_type.dart';

void main() {
  const engine = RuleBasedVerdictEngine();

  Case createTestCase({
    required String id,
    required String title,
    required CaseCategory category,
    required String plaintiffName,
    required String plaintiffArgument,
    required String defendantName,
    required String defendantArgument,
  }) {
    return Case((b) => b
      ..id = id
      ..caseNumber = 'TC-2026-00001'
      ..title = title
      ..category = category
      ..plaintiffName = plaintiffName
      ..plaintiffArgument = plaintiffArgument
      ..defendantName = defendantName
      ..defendantArgument = defendantArgument
      ..status = CaseStatus.submitted
      ..createdAt = DateTime.utc(2026, 1, 1)
      ..updatedAt = DateTime.utc(2026, 1, 1));
  }

  group('RuleBasedVerdictEngine Tests', () {
    test('100% Determinism: Evaluating the same case multiple times yields identical verdicts', () {
      final testCase = createTestCase(
        id: 'case_determinism_test',
        title: 'The Great Cookie Debate',
        category: CaseCategory.food,
        plaintiffName: 'Alice',
        plaintiffArgument: 'I baked chocolate chip cookies for the party.',
        defendantName: 'Bob',
        defendantArgument: 'I thought they were for general consumption.',
      );

      final firstVerdict = engine.evaluate(testCase);

      for (var i = 0; i < 20; i++) {
        final repeatVerdict = engine.evaluate(testCase);
        expect(repeatVerdict.verdictType, equals(firstVerdict.verdictType));
        expect(repeatVerdict.judgeStatement, equals(firstVerdict.judgeStatement));
        expect(repeatVerdict.punishment, equals(firstVerdict.punishment));
        expect(repeatVerdict.ruleId, equals(firstVerdict.ruleId));
      }
    });

    test('Length Disparity Rule: 150-char essay vs 2-letter reply triggers Contempt', () {
      final essayCase = createTestCase(
        id: 'case_essay_vs_ok',
        title: 'Communication Breakdown',
        category: CaseCategory.friendship,
        plaintiffName: 'Sarah',
        plaintiffArgument:
            'I spent three hours writing out all my feelings regarding why our communication has drifted apart, including specific dates, screenshots, and emotional reflections.',
        defendantName: 'Dave',
        defendantArgument: 'k',
      );

      final verdict = engine.evaluate(essayCase);
      expect(verdict.verdictType, equals(VerdictType.guiltyDefendant));
      expect(verdict.ruleId, equals('rule_length_disparity'));
      expect(verdict.responsibleParties, contains('Dave'));
    });

    test('Food Category: Labeled food theft triggers Guilty Defendant', () {
      final labeledFoodCase = createTestCase(
        id: 'case_labeled_pizza',
        title: 'Stolen Pizza',
        category: CaseCategory.food,
        plaintiffName: 'Emma',
        plaintiffArgument: 'My name was written in bold Sharpie on the pizza box!',
        defendantName: 'Liam',
        defendantArgument: 'I got hungry late at night.',
      );

      final verdict = engine.evaluate(labeledFoodCase);
      expect(verdict.verdictType, equals(VerdictType.guiltyDefendant));
      expect(verdict.responsibleParties, contains('Liam'));
    });

    test('Food Category: Abandoned fridge food triggers Maritime Salvage (Not Guilty)', () {
      final salvageCase = createTestCase(
        id: 'case_salvage',
        title: 'Ancient Leftovers',
        category: CaseCategory.food,
        plaintiffName: 'Rachel',
        plaintiffArgument: 'Someone ate the noodles I left in the fridge.',
        defendantName: 'Ross',
        defendantArgument: 'They were abandoned in the fridge for 3 days! Maritime salvage law!',
      );

      final verdict = engine.evaluate(salvageCase);
      expect(verdict.verdictType, equals(VerdictType.notGuilty));
      expect(verdict.responsibleParties, isEmpty);
    });

    test('Work Category: Leaving mug to soak in sink triggers Guilty Defendant', () {
      final dishesCase = createTestCase(
        id: 'case_dishes',
        title: 'The Eternal Soak',
        category: CaseCategory.work,
        plaintiffName: 'Office Manager',
        plaintiffArgument: 'There is a dirty mug in the sink again.',
        defendantName: 'Coffee Guy',
        defendantArgument: 'It is just soaking in the sink to loosen the stains.',
      );

      final verdict = engine.evaluate(dishesCase);
      expect(verdict.verdictType, equals(VerdictType.guiltyDefendant));
      expect(verdict.responsibleParties, contains('Coffee Guy'));
    });

    test('Deterministic Fallback: Produces complete verdict with valid fields for any case', () {
      final genericCase = createTestCase(
        id: 'case_random_999',
        title: 'Whose Turn Is It?',
        category: CaseCategory.random,
        plaintiffName: 'Player 1',
        plaintiffArgument: 'I believe the rules clearly state it is my turn now.',
        defendantName: 'Player 2',
        defendantArgument: 'I disagree based on page 4 of the rulebook.',
      );

      final verdict = engine.evaluate(genericCase);
      expect(verdict.id, equals('v_case_random_999'));
      expect(verdict.caseId, equals('case_random_999'));
      expect(verdict.judgeStatement.isNotEmpty, isTrue);
      expect(verdict.explanation.isNotEmpty, isTrue);
      expect(verdict.punishment.isNotEmpty, isTrue);
      expect(verdict.closingRemark.isNotEmpty, isTrue);
    });
  });
}
