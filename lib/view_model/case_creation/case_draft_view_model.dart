import 'package:built_collection/built_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/services/case_service.dart';
import '../../data/repository.dart';
import '../../model/case.dart';
import '../../model/enums/case_category.dart';
import '../../model/suggested_case.dart';
import '../../provider/app_providers.dart';
import '../../utils/app_logger.dart';
import '../base_view_model.dart';
import '../../model/states/case_draft_state.dart';

part 'case_draft_view_model.g.dart';

/// Feature ViewModel managing the multi-step case creation wizard, validation, and draft submission.
@Riverpod(keepAlive: true)
class CaseDraftViewModel extends _$CaseDraftViewModel implements BaseViewModel {
  CaseDraftViewModel({CaseService? caseService})
      : _caseServiceOverride = caseService;

  static const String _tag = 'CaseDraftViewModel';
  static final AppLogger _log = AppLogger.get(_tag);

  final CaseService? _caseServiceOverride;

  AppRepository get _repo => ref.read(appRepositoryProvider);

  CaseService get _caseService =>
      _caseServiceOverride ?? _repo.caseService;

  @override
  CaseDraftState build() {
    ref.onDispose(() {
      dispose();
    });
    return CaseDraftState.initial();
  }

  @override
  Future<void> init() async {}

  @override
  Future<void> dispose() async {}

  void initFromTemplate(SuggestedCase template) {
    _log.debug('📝 Seeding draft from template: ${template.title}');
    state = CaseDraftState((b) => b
      ..activeStep = DraftStep.overview
      ..title = template.title
      ..category = template.category
      ..description = template.description
      ..plaintiffName = template.defaultPlaintiff
      ..plaintiffArgument = template.defaultPlaintiffArgument
      ..defendantName = template.defaultDefendant
      ..defendantArgument = template.defaultDefendantArgument
      ..suggestedCaseId = template.id
      ..isSubmitting = false
      ..fieldErrors = MapBuilder<String, String>());
  }

  void initFromExistingDraft(Case existingCase) {
    _log.debug('📂 Resuming draft from existing case: ${existingCase.id}');
    state = CaseDraftState((b) => b
      ..draftId = existingCase.id
      ..activeStep = DraftStep.overview
      ..title = existingCase.title
      ..category = existingCase.category
      ..description = existingCase.description
      ..plaintiffName = existingCase.plaintiffName
      ..plaintiffArgument = existingCase.plaintiffArgument
      ..defendantName = existingCase.defendantName
      ..defendantArgument = existingCase.defendantArgument
      ..suggestedCaseId = existingCase.suggestedCaseId
      ..isSubmitting = false
      ..fieldErrors = MapBuilder<String, String>());
  }

  void reset() {
    _log.debug('🔄 Resetting draft state to initial.');
    state = CaseDraftState.initial();
  }

  void updateOverview({
    required String title,
    required CaseCategory category,
    String? description,
  }) {
    state = state.rebuild((b) {
      b.title = title;
      b.category = category;
      b.description = description ?? '';
      b.fieldErrors.remove('title');
    });
  }

  void updatePlaintiff({
    required String name,
    required String argument,
  }) {
    state = state.rebuild((b) {
      b.plaintiffName = name;
      b.plaintiffArgument = argument;
      b.fieldErrors.remove('plaintiffName');
      b.fieldErrors.remove('plaintiffArgument');
    });
  }

  void updateDefendant({
    required String name,
    required String argument,
  }) {
    state = state.rebuild((b) {
      b.defendantName = name;
      b.defendantArgument = argument;
      b.fieldErrors.remove('defendantName');
      b.fieldErrors.remove('defendantArgument');
    });
  }

  void goToStep(DraftStep step) {
    state = state.rebuild((b) => b.activeStep = step);
  }

  bool nextStep() {
    final errors = <String, String>{};

    switch (state.activeStep) {
      case DraftStep.overview:
        if (!state.isOverviewValid) {
          errors['title'] = 'Case title is required.';
        }
        if (errors.isEmpty) {
          state = state.rebuild((b) => b.activeStep = DraftStep.plaintiff);
          return true;
        }
        break;

      case DraftStep.plaintiff:
        if (state.plaintiffName.trim().isEmpty) {
          errors['plaintiffName'] = 'Plaintiff name is required.';
        }
        if (state.plaintiffArgument.trim().isEmpty) {
          errors['plaintiffArgument'] = 'Plaintiff argument is required.';
        }
        if (errors.isEmpty) {
          state = state.rebuild((b) => b.activeStep = DraftStep.defendant);
          return true;
        }
        break;

      case DraftStep.defendant:
        if (state.defendantName.trim().isEmpty) {
          errors['defendantName'] = 'Defendant name is required.';
        }
        if (state.defendantArgument.trim().isEmpty) {
          errors['defendantArgument'] = 'Defendant argument is required.';
        }
        if (errors.isEmpty) {
          state = state.rebuild((b) => b.activeStep = DraftStep.review);
          return true;
        }
        break;

      case DraftStep.review:
        return true;
      default:
        break;
    }

    state = state.rebuild((b) => b.fieldErrors = MapBuilder<String, String>(errors));
    return false;
  }

  void previousStep() {
    final prev = switch (state.activeStep) {
      DraftStep.review => DraftStep.defendant,
      DraftStep.defendant => DraftStep.plaintiff,
      DraftStep.plaintiff => DraftStep.overview,
      DraftStep.overview => DraftStep.overview,
      _ => DraftStep.overview,
    };
    state = state.rebuild((b) => b.activeStep = prev);
  }

  Future<Case?> submitCase() async {
    if (!state.canSubmit) return null;

    _log.debug('⚖️ Submitting case draft to CaseService...');
    state = state.rebuild((b) => b.isSubmitting = true);

    try {
      Case savedCase;
      if (state.draftId != null) {
        final existing = await _caseService.getCaseById(state.draftId!);
        final updated = existing.rebuild((b) => b
          ..title = state.title.trim()
          ..category = state.category
          ..description = state.description?.trim()
          ..plaintiffName = state.plaintiffName.trim()
          ..plaintiffArgument = state.plaintiffArgument.trim()
          ..defendantName = state.defendantName.trim()
          ..defendantArgument = state.defendantArgument.trim());
        savedCase = await _caseService.updateCase(updated);
      } else {
        savedCase = await _caseService.createCase(
          title: state.title.trim(),
          category: state.category,
          description: state.description?.trim(),
          plaintiffName: state.plaintiffName.trim(),
          plaintiffArgument: state.plaintiffArgument.trim(),
          defendantName: state.defendantName.trim(),
          defendantArgument: state.defendantArgument.trim(),
          suggestedCaseId: state.suggestedCaseId,
        );
      }

      final submitted = await _caseService.submitCase(savedCase.id);
      state = state.rebuild((b) => b.isSubmitting = false);
      _log.debug('✅ Case submitted: ${submitted.id}');
      return submitted;
    } catch (e, st) {
      _log.error('❌ submitCase error: $e', error: e, stackTrace: st);
      state = state.rebuild((b) {
        b.isSubmitting = false;
        b.fieldErrors = MapBuilder<String, String>({'general': e.toString()});
      });
      rethrow;
    }
  }
}
