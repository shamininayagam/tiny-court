import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiny_court/core/exceptions/app_exception.dart';
import 'package:tiny_court/data/repository.dart';
import 'package:tiny_court/env/environment.dart';
import 'package:tiny_court/model/enums/case_category.dart';
import 'package:tiny_court/model/enums/case_status.dart';

class TestEnvironment extends Environment {
  TestEnvironment() : super.public();

  @override
  EnvironmentType get type => EnvironmentType.dev;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppRepository repo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    repo = AppRepository(TestEnvironment(), prefs: prefs);
    await repo.init();
  });

  group('Storage & CaseService Integration Tests', () {
    test('Create case assigns sequential caseNumber and draft status', () async {
      final case1 = await repo.caseService.createCase(
        title: 'The Great Pizza Dispute',
        category: CaseCategory.food,
        plaintiffName: 'Alice',
        plaintiffArgument: 'He ate my slice.',
        defendantName: 'Bob',
        defendantArgument: 'It was delicious.',
      );

      expect(case1.id.isNotEmpty, isTrue);
      expect(case1.caseNumber, startsWith('TC-'));
      expect(case1.caseNumber, endsWith('-00001'));
      expect(case1.status, equals(CaseStatus.draft));

      final case2 = await repo.caseService.createCase(
        title: 'Second Dispute',
        category: CaseCategory.friendship,
      );

      expect(case2.caseNumber, endsWith('-00002'));
    });

    test('Submit case validates fields and transitions status', () async {
      final emptyCase = await repo.caseService.createCase(
        title: 'Empty Case',
        category: CaseCategory.random,
      );

      expect(
        () => repo.caseService.submitCase(emptyCase.id),
        throwsA(isA<CaseValidationException>()),
      );

      // Now fill required fields
      final updated = emptyCase.rebuild((b) => b
        ..plaintiffName = 'John'
        ..plaintiffArgument = 'Valid complaint'
        ..defendantName = 'Jane'
        ..defendantArgument = 'Valid defense');

      await repo.caseService.updateCase(updated);
      final submitted = await repo.caseService.submitCase(emptyCase.id);

      expect(submitted.status, equals(CaseStatus.submitted));
    });

    test('Query and search filtering works across titles and names', () async {
      await repo.caseService.createCase(
        title: 'Missing French Fries',
        category: CaseCategory.food,
        plaintiffName: 'Charlie',
      );
      await repo.caseService.createCase(
        title: 'Late to the Movie',
        category: CaseCategory.friendship,
        plaintiffName: 'Diana',
      );

      final foodCases = await repo.caseService.getAllCases(
        category: CaseCategory.food,
      );
      expect(foodCases.length, equals(1));
      expect(foodCases.first.title, contains('Fries'));

      final searchResults = await repo.caseService.getAllCases(
        searchQuery: 'diana',
      );
      expect(searchResults.length, equals(1));
      expect(searchResults.first.plaintiffName, equals('Diana'));
    });
  });

  group('VerdictService & Idempotency Tests', () {
    test('Adjudication generates verdict, marks case decided, and is strictly idempotent', () async {
      final created = await repo.caseService.createCase(
        title: 'Stolen Leftovers',
        category: CaseCategory.food,
        plaintiffName: 'Ross',
        plaintiffArgument: 'Someone ate my sandwich!',
        defendantName: 'Boss',
        defendantArgument: 'It was in the breakroom trash.',
      );

      final submitted = await repo.caseService.submitCase(created.id);
      expect(submitted.status, equals(CaseStatus.submitted));

      // 1. First adjudication: generates and saves verdict
      final verdict1 = await repo.verdictService.adjudicateCase(submitted);
      expect(verdict1.caseId, equals(submitted.id));
      expect(verdict1.judgeStatement.isNotEmpty, isTrue);

      final decidedCase = await repo.caseService.getCaseById(submitted.id);
      expect(decidedCase.status, equals(CaseStatus.decided));
      expect(decidedCase.verdictId, equals(verdict1.id));

      // 2. Second adjudication: MUST return identical verdict without recalculation
      final verdict2 = await repo.verdictService.adjudicateCase(decidedCase);
      expect(verdict2.id, equals(verdict1.id));
      expect(verdict2.judgeStatement, equals(verdict1.judgeStatement));

      // 3. Attempting to update a decided case must throw
      expect(
        () => repo.caseService.updateCase(decidedCase),
        throwsA(isA<CaseAlreadyDecidedException>()),
      );
    });

    test('Deleting a case deletes both the case and its saved verdict', () async {
      final created = await repo.caseService.createCase(
        title: 'Temporary Case',
        category: CaseCategory.random,
        plaintiffName: 'P',
        plaintiffArgument: 'Claim',
        defendantName: 'D',
        defendantArgument: 'Defense',
      );
      final submitted = await repo.caseService.submitCase(created.id);
      await repo.verdictService.adjudicateCase(submitted);

      expect(await repo.verdictService.getVerdictByCaseId(created.id), isNotNull);

      await repo.caseService.deleteCase(created.id);

      expect(
        () => repo.caseService.getCaseById(created.id),
        throwsA(isA<CaseNotFoundException>()),
      );
      expect(await repo.verdictService.getVerdictByCaseId(created.id), isNull);
    });
  });

  group('SettingsService Tests', () {
    test('Preferences persist and toggle correctly', () async {
      expect(repo.settingsService.getSettings().soundEnabled, isTrue);

      await repo.settingsService.setSoundEnabled(false);
      expect(repo.settingsService.getSettings().soundEnabled, isFalse);

      await repo.settingsService.setThemePreference('dark');
      expect(repo.settingsService.getSettings().themePreference, equals('dark'));

      await repo.settingsService.resetToDefaults();
      expect(repo.settingsService.getSettings().soundEnabled, isTrue);
      expect(repo.settingsService.getSettings().themePreference, equals('system'));
    });
  });
}
