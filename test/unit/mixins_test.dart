import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiny_court/data/repository.dart';
import 'package:tiny_court/env/environment.dart';
import 'package:tiny_court/mixins/mixins.dart';
import 'package:tiny_court/model/case.dart';
import 'package:tiny_court/model/enums/case_category.dart';
import 'package:tiny_court/model/enums/case_status.dart';
import 'package:tiny_court/provider/app_consumer.dart';
import 'package:tiny_court/provider/app_providers.dart';

class TestEnvironment extends Environment {
  TestEnvironment() : super.public();

  @override
  EnvironmentType get type => EnvironmentType.dev;
}

class TestDraftWidget extends AppConsumerStatefulWidget {
  const TestDraftWidget({super.key});

  @override
  TestDraftWidgetState createState() => TestDraftWidgetState();
}

class TestDraftWidgetState extends AppConsumerState<TestDraftWidget>
    with CaseDraftMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Text('Step: ${draftState.activeStep.name}'),
            Text('Title: ${draftState.title}'),
            ElevatedButton(
              onPressed: () {
                updateDraftOverview(
                  title: 'Stolen Donut',
                  category: CaseCategory.food,
                  description: 'Office snack crime',
                );
              },
              child: const Text('Update Overview'),
            ),
            ElevatedButton(
              onPressed: () {
                nextDraftStep();
              },
              child: const Text('Next Step'),
            ),
            ElevatedButton(
              onPressed: () {
                resetDraft();
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestHistoryWidget extends AppConsumerStatefulWidget {
  const TestHistoryWidget({super.key});

  @override
  TestHistoryWidgetState createState() => TestHistoryWidgetState();
}

class TestHistoryWidgetState extends AppConsumerState<TestHistoryWidget>
    with CaseHistoryMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Text('Count: ${historyState.filteredCases.length}'),
            ElevatedButton(
              onPressed: () => loadHistoricalCases(),
              child: const Text('Load Cases'),
            ),
            ElevatedButton(
              onPressed: () => searchHistoricalCases(query: 'Pizza'),
              child: const Text('Search'),
            ),
            ElevatedButton(
              onPressed: () => clearHistoryFilters(),
              child: const Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestCourtroomWidget extends AppConsumerStatefulWidget {
  const TestCourtroomWidget({super.key});

  @override
  TestCourtroomWidgetState createState() => TestCourtroomWidgetState();
}

class TestCourtroomWidgetState extends AppConsumerState<TestCourtroomWidget>
    with CourtroomMixin {
  @override
  Widget build(BuildContext context) {
    final state = courtroomState;
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Text('Stage: ${state?.currentStage.name ?? "none"}'),
            ElevatedButton(
              onPressed: () {
                final c = Case((b) => b
                  ..id = 'TC-2026-TEST1'
                  ..caseNumber = 'TC-2026-00001'
                  ..title = 'Roommate Dispute'
                  ..category = CaseCategory.friendship
                  ..plaintiffName = 'Alice'
                  ..plaintiffArgument = 'Dishes piled up high'
                  ..defendantName = 'Bob'
                  ..defendantArgument = 'Soaking overnight'
                  ..status = CaseStatus.submitted
                  ..createdAt = DateTime.now()
                  ..updatedAt = DateTime.now());
                initCourtroomSession(courtCase: c);
              },
              child: const Text('Init Session'),
            ),
            ElevatedButton(
              onPressed: () => progressCourtroomStage(),
              child: const Text('Progress Stage'),
            ),
            ElevatedButton(
              onPressed: () => resetCourtroomSession(),
              child: const Text('Reset Session'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppRepository repo;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();
    repo = AppRepository(TestEnvironment(), prefs: prefs);
    await repo.init();
  });

  testWidgets('CaseDraftMixin updates overview, validates step, and resets',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appRepositoryProvider.overrideWithValue(repo),
        ],
        child: const TestDraftWidget(),
      ),
    );

    expect(find.text('Step: overview'), findsOneWidget);
    expect(find.text('Title: '), findsOneWidget);

    // Update overview via mixin
    await tester.tap(find.text('Update Overview'));
    await tester.pump();

    expect(find.text('Title: Stolen Donut'), findsOneWidget);

    // Advance step
    await tester.tap(find.text('Next Step'));
    await tester.pump();

    expect(find.text('Step: plaintiff'), findsOneWidget);

    // Reset wizard
    await tester.tap(find.text('Reset'));
    await tester.pump();

    expect(find.text('Step: overview'), findsOneWidget);
    expect(find.text('Title: '), findsOneWidget);
  });

  testWidgets('CourtroomMixin initializes session, progresses stages, and resets',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appRepositoryProvider.overrideWithValue(repo),
        ],
        child: const TestCourtroomWidget(),
      ),
    );

    expect(find.text('Stage: none'), findsOneWidget);

    // Init session via mixin
    await tester.tap(find.text('Init Session'));
    await tester.pump();

    expect(find.text('Stage: entrance'), findsOneWidget);

    // Progress stage via mixin
    await tester.tap(find.text('Progress Stage'));
    await tester.pump();

    expect(find.text('Stage: judgeIntro'), findsOneWidget);

    // Reset session via mixin
    await tester.tap(find.text('Reset Session'));
    await tester.pump();

    expect(find.text('Stage: none'), findsOneWidget);
  });

  testWidgets('CaseHistoryMixin loads cases and updates search query',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appRepositoryProvider.overrideWithValue(repo),
        ],
        child: const TestHistoryWidget(),
      ),
    );

    expect(find.text('Count: 0'), findsOneWidget);

    // Load cases via mixin
    await tester.tap(find.text('Load Cases'));
    await tester.pumpAndSettle();

    expect(find.text('Count: 0'), findsOneWidget);

    // Search via mixin
    await tester.tap(find.text('Search'));
    await tester.pump();

    // Clear filters via mixin
    await tester.tap(find.text('Clear'));
    await tester.pump();
  });
}
