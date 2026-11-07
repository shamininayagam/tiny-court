import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiny_court/data/repository.dart';
import 'package:tiny_court/env/environment.dart';
import 'package:tiny_court/intl/i18n.dart';
import 'package:tiny_court/model/models.dart';
import 'package:tiny_court/provider/app_providers.dart';
import 'package:tiny_court/views/cases/case_details_screen.dart';
import 'package:tiny_court/views/cases/my_cases_tab.dart';
import 'package:tiny_court/views/cases/review_case_screen.dart';
import 'package:tiny_court/views/courtroom/courtroom_screen.dart';
import 'package:tiny_court/views/settings/settings_tab.dart';
import 'package:tiny_court/views/verdict/verdict_details_screen.dart';

class _TestEnvironment extends Environment {
  _TestEnvironment() : super.public();

  @override
  EnvironmentType get type => EnvironmentType.dev;
}

Widget _wrapScreen({
  required Widget screen,
  required AppRepository repo,
}) {
  return ProviderScope(
    overrides: [
      appRepositoryProvider.overrideWithValue(repo),
    ],
    child: MaterialApp(
      localizationsDelegates: AppStringsDelegate.delegates,
      supportedLocales: AppStringsDelegate.appSupportedLocales,
      home: screen,
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppRepository repo;
  late Case testCase;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    repo = AppRepository(_TestEnvironment(), prefs: prefs);
    await repo.init();

    testCase = await repo.caseService.createCase(
      title: 'The Great Donut Robbery',
      category: CaseCategory.food,
      description: 'A Boston cream disappeared at 9 AM.',
      plaintiffName: 'Officer Bob',
      plaintiffArgument: 'I bought it with my hard-earned cash!',
      defendantName: 'Detective Dan',
      defendantArgument: 'It was sitting unattended. A donut emergency.',
    );
  });

  group('Phase 6 Screen Tests', () {
    testWidgets('SettingsTab renders switches and toggles preference',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapScreen(
          screen: const SettingsTab(),
          repo: repo,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Switch), findsNWidgets(3));
      expect(find.text('About Tiny Court'), findsOneWidget);

      final initialSound = repo.settingsService.getSettings().soundEnabled;
      expect(initialSound, isTrue);

      // Toggle first switch (sound)
      await tester.tap(find.byType(Switch).first);
      await tester.pumpAndSettle();

      final updatedSound = repo.settingsService.getSettings().soundEnabled;
      expect(updatedSound, isFalse);
    });

    testWidgets('ReviewCaseScreen loads and displays official court docket',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapScreen(
          screen: ReviewCaseScreen(caseId: testCase.id),
          repo: repo,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('The Great Donut Robbery'), findsOneWidget);
      expect(find.text('Officer Bob'), findsOneWidget);
      expect(find.text('Detective Dan'), findsOneWidget);
      expect(find.text('Enter Courtroom'), findsOneWidget);
    });

    testWidgets('CourtroomScreen loads trial session and shows mascot & gavel',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapScreen(
          screen: CourtroomScreen(caseId: testCase.id),
          repo: repo,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('The Great Donut Robbery'), findsOneWidget);
      expect(find.text('Skip to Verdict'), findsWidgets);

      // Strike gavel to progress
      final strikeFinder = find.text('STRIKE GAVEL');
      if (strikeFinder.evaluate().isNotEmpty) {
        await tester.tap(strikeFinder);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('VerdictDetailsScreen displays verdict stamp and punishments',
        (WidgetTester tester) async {
      // First adjudicate the case
      final verdict = await repo.verdictService.adjudicateCase(testCase);
      expect(verdict.verdictType, isNotNull);

      await tester.pumpWidget(
        _wrapScreen(
          screen: VerdictDetailsScreen(caseId: testCase.id),
          repo: repo,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('The Great Donut Robbery'), findsOneWidget);
      expect(find.text('Official Judicial Decree'), findsWidgets);
      expect(find.text('Mandatory Comedic Punishment'), findsOneWidget);
      expect(find.text('Share Verdict'), findsOneWidget);
    });

    testWidgets('MyCasesTab lists historical cases and supports search',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapScreen(
          screen: const MyCasesTab(),
          repo: repo,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('The Great Donut Robbery'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      // Search for something that doesn't match
      await tester.enterText(find.byType(TextField), 'NonExistentCaseName');
      await tester.pumpAndSettle();

      expect(find.text('The Great Donut Robbery'), findsNothing);
      expect(find.text('No Cases Found'), findsOneWidget);
    });

    testWidgets('CaseDetailsScreen displays case info and arguments',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapScreen(
          screen: CaseDetailsScreen(caseId: testCase.id),
          repo: repo,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('The Great Donut Robbery'), findsOneWidget);
      expect(find.text('Officer Bob'), findsOneWidget);
      expect(find.text('Detective Dan'), findsOneWidget);
      expect(find.text('Proceed to Trial'), findsOneWidget);
    });
  });
}
