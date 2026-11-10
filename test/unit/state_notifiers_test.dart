import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiny_court/data/repository.dart';
import 'package:tiny_court/env/environment.dart';
import 'package:tiny_court/model/models.dart';
import 'package:tiny_court/provider/app_providers.dart';
import 'package:tiny_court/view_model/case_creation/case_draft_view_model.dart';
import 'package:tiny_court/view_model/case_history/case_history_view_model.dart';
import 'package:tiny_court/view_model/courtroom/courtroom_view_model.dart';

class TestEnvironment extends Environment {
  TestEnvironment() : super.public();

  @override
  EnvironmentType get type => EnvironmentType.dev;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppRepository repo;
  late ProviderContainer container;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    repo = AppRepository(TestEnvironment(), prefs: prefs);
    await repo.init();

    container = ProviderContainer(
      overrides: [
        appRepositoryProvider.overrideWithValue(repo),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('CaseDraftViewModel Tests', () {
    test('Initial state is at Overview step with empty fields', () {
      final state = container.read(caseDraftViewModelProvider);
      expect(state.activeStep, equals(DraftStep.overview));
      expect(state.title, isEmpty);
      expect(state.isOverviewValid, isFalse);
    });

    test('initFromTemplate populates all fields', () {
      final template = SuggestedCase((b) => b
        ..id = 'sc_pizza'
        ..title = 'Missing Pizza'
        ..description = 'Someone ate it'
        ..category = CaseCategory.food
        ..defaultPlaintiff = 'Alice'
        ..defaultDefendant = 'Bob'
        ..defaultPlaintiffArgument = 'My slice!'
        ..defaultDefendantArgument = 'I was hungry');

      container.read(caseDraftViewModelProvider.notifier).initFromTemplate(template);
      final state = container.read(caseDraftViewModelProvider);

      expect(state.title, equals('Missing Pizza'));
      expect(state.plaintiffName, equals('Alice'));
      expect(state.defendantName, equals('Bob'));
      expect(state.suggestedCaseId, equals('sc_pizza'));
      expect(state.canSubmit, isTrue);
    });

    test('Step validation blocks advancement until fields are valid', () {
      final vm = container.read(caseDraftViewModelProvider.notifier);

      expect(vm.nextStep(), isFalse);
      expect(container.read(caseDraftViewModelProvider).activeStep, equals(DraftStep.overview));

      vm.updateOverview(title: 'Valid Title', category: CaseCategory.work);
      expect(vm.nextStep(), isTrue);
      expect(container.read(caseDraftViewModelProvider).activeStep, equals(DraftStep.plaintiff));

      expect(vm.nextStep(), isFalse);
      vm.updatePlaintiff(name: 'Boss', argument: 'You were late');
      expect(vm.nextStep(), isTrue);
      expect(container.read(caseDraftViewModelProvider).activeStep, equals(DraftStep.defendant));

      vm.updateDefendant(name: 'Worker', argument: 'Traffic jam');
      expect(vm.nextStep(), isTrue);
      expect(container.read(caseDraftViewModelProvider).activeStep, equals(DraftStep.review));
    });

    test('submitCase creates and submits case successfully', () async {
      final vm = container.read(caseDraftViewModelProvider.notifier);
      vm.updateOverview(title: 'Dispute 1', category: CaseCategory.random);
      vm.updatePlaintiff(name: 'A', argument: 'Arg A');
      vm.updateDefendant(name: 'B', argument: 'Arg B');

      final submitted = await vm.submitCase();
      expect(submitted, isNotNull);
      expect(submitted!.title, equals('Dispute 1'));
      expect(submitted.status, equals(CaseStatus.submitted));
    });
  });

  group('CourtroomViewModel Tests', () {
    test('Progresses through dramatic stages and adjudicates at deliberation', () async {
      final created = await repo.caseService.createCase(
        title: 'Courtroom Trial Test',
        category: CaseCategory.food,
        plaintiffName: 'Alice',
        plaintiffArgument: 'He stole my sandwich!',
        defendantName: 'Bob',
        defendantArgument: 'It was in the breakroom trash!',
      );
      final submitted = await repo.caseService.submitCase(created.id);

      final vm = container.read(courtroomViewModelProvider.notifier);
      vm.initSession(submitted);

      expect(container.read(courtroomViewModelProvider)?.currentStage,
          equals(CourtroomStage.entrance));

      vm.progressToNextStage(); // judgeIntro
      expect(container.read(courtroomViewModelProvider)?.currentStage,
          equals(CourtroomStage.judgeIntro));

      vm.progressToNextStage(); // plaintiffPresentation
      expect(container.read(courtroomViewModelProvider)?.currentStage,
          equals(CourtroomStage.plaintiffPresentation));

      vm.progressToNextStage(); // defendantPresentation
      expect(container.read(courtroomViewModelProvider)?.currentStage,
          equals(CourtroomStage.defendantPresentation));

      vm.progressToNextStage(); // deliberation
      expect(container.read(courtroomViewModelProvider)?.currentStage,
          equals(CourtroomStage.deliberation));

      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(container.read(courtroomViewModelProvider)?.generatedVerdict, isNotNull);

      vm.progressToNextStage(); // verdictReveal
      expect(container.read(courtroomViewModelProvider)?.currentStage,
          equals(CourtroomStage.verdictReveal));
    });

    test('skipToVerdict immediately triggers adjudication and jumps to reveal', () async {
      final created = await repo.caseService.createCase(
        title: 'Fast Case',
        category: CaseCategory.friendship,
        plaintiffName: 'P',
        plaintiffArgument: 'Arg P',
        defendantName: 'D',
        defendantArgument: 'Arg D',
      );
      final submitted = await repo.caseService.submitCase(created.id);

      final vm = container.read(courtroomViewModelProvider.notifier);
      vm.initSession(submitted);
      await vm.skipToVerdict();

      final state = container.read(courtroomViewModelProvider);
      expect(state?.isSkipped, isTrue);
      expect(state?.currentStage, equals(CourtroomStage.verdictReveal));
      expect(state?.generatedVerdict, isNotNull);
    });
  });

  group('CaseHistoryViewModel Tests', () {
    test('Filtering and searching update filteredCases accurately', () async {
      await repo.caseService.createCase(
        title: 'Snack Heist',
        category: CaseCategory.food,
        plaintiffName: 'Sam',
      );
      await repo.caseService.createCase(
        title: 'Tardy Friend',
        category: CaseCategory.friendship,
        plaintiffName: 'Taylor',
      );

      final vm = container.read(caseHistoryViewModelProvider.notifier);
      await vm.loadCases();

      var state = container.read(caseHistoryViewModelProvider);
      expect(state.allCases.length, equals(2));

      vm.setCategoryFilter(CaseCategory.food);
      state = container.read(caseHistoryViewModelProvider);
      expect(state.filteredCases.length, equals(1));
      expect(state.filteredCases.first.title, contains('Snack'));

      vm.clearFilters();
      vm.setSearchQuery('taylor');
      state = container.read(caseHistoryViewModelProvider);
      expect(state.filteredCases.length, equals(1));
      expect(state.filteredCases.first.plaintiffName, equals('Taylor'));
    });
  });
}
