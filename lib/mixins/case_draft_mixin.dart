import '../model/case.dart';
import '../model/enums/case_category.dart';
import '../model/states/case_draft_state.dart';
import '../model/suggested_case.dart';
import '../ui.dart';

/// Mixin providing UI state methods and dispatch for the Case Creation Wizard.
///
/// Flow: UI -> CaseDraftMixin -> CaseDraftViewModel -> CaseService -> CaseServiceImpl
///
/// Dispatches actions to [CaseDraftViewModel] via [appRef] with structured logging,
/// mounted-guarded error presentation, and rethrow semantics adhering to the pogo_alarm standard.
mixin CaseDraftMixin<T extends AppConsumerStatefulWidget>
    on AppConsumerState<T> {
  static const String _tag = 'CaseDraftMixin';
  static final AppLogger _log = AppLogger.get(_tag);

  /// Reactive watch on the active wizard draft state.
  CaseDraftState get draftState => appRef.caseDraftState;

  /// Seeds wizard from a pre-made template prompt.
  void initDraftFromTemplate({required SuggestedCase template}) {
    _log.debug('📝 Initializing case draft from template: ${template.title}');
    try {
      appRef.caseDraftViewModel.initFromTemplate(template);
      _log.debug('✅ Template draft initialized.');
    } catch (e, st) {
      _log.error(
        '❌ initDraftFromTemplate() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Resumes an existing saved draft.
  void initDraftFromExisting({required Case existingCase}) {
    _log.debug('📂 Resuming case draft from existing case: ${existingCase.id}');
    try {
      appRef.caseDraftViewModel.initFromExistingDraft(existingCase);
      _log.debug('✅ Existing draft resumed.');
    } catch (e, st) {
      _log.error(
        '❌ initDraftFromExisting() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Clears form state and resets wizard to Step 0.
  void resetDraft() {
    _log.debug('🔄 Resetting draft wizard state...');
    try {
      appRef.caseDraftViewModel.reset();
      _log.debug('✅ Draft wizard reset.');
    } catch (e, st) {
      _log.error('❌ resetDraft() failed: $e', error: e, stackTrace: st);
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Updates Overview fields (Title, Category, Context).
  void updateDraftOverview({
    required String title,
    required CaseCategory category,
    String? description,
  }) {
    _log.debug('✏️ Updating draft overview: "$title" ($category)');
    try {
      appRef.caseDraftViewModel.updateOverview(
        title: title,
        category: category,
        description: description,
      );
    } catch (e, st) {
      _log.error('❌ updateDraftOverview() failed: $e',
          error: e, stackTrace: st);
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Updates Plaintiff fields (Name, Argument).
  void updateDraftPlaintiff({
    required String name,
    required String argument,
  }) {
    _log.debug('👤 Updating draft plaintiff: "$name"');
    try {
      appRef.caseDraftViewModel.updatePlaintiff(
        name: name,
        argument: argument,
      );
    } catch (e, st) {
      _log.error('❌ updateDraftPlaintiff() failed: $e',
          error: e, stackTrace: st);
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Updates Defendant fields (Name, Argument).
  void updateDraftDefendant({
    required String name,
    required String argument,
  }) {
    _log.debug('👤 Updating draft defendant: "$name"');
    try {
      appRef.caseDraftViewModel.updateDefendant(
        name: name,
        argument: argument,
      );
    } catch (e, st) {
      _log.error('❌ updateDraftDefendant() failed: $e',
          error: e, stackTrace: st);
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Navigates directly to a specific wizard step.
  void goToDraftStep({required DraftStep step}) {
    _log.debug('🔀 Navigating directly to step: $step');
    try {
      appRef.caseDraftViewModel.goToStep(step);
    } catch (e, st) {
      _log.error('❌ goToDraftStep() failed: $e', error: e, stackTrace: st);
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Validates the current step and advances to the next step.
  /// Returns false if current step has validation errors.
  bool nextDraftStep() {
    _log.debug('➡️ Advancing draft step...');
    try {
      final bool isValid = appRef.caseDraftViewModel.nextStep();
      if (!isValid) {
        _log.warning('⚠️ Current step validation failed.');
      } else {
        _log.debug('✅ Advanced to step: ${draftState.activeStep}');
      }
      return isValid;
    } catch (e, st) {
      _log.error('❌ nextDraftStep() failed: $e', error: e, stackTrace: st);
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Returns to the previous step in the wizard.
  void previousDraftStep() {
    _log.debug('⬅️ Returning to previous step...');
    try {
      appRef.caseDraftViewModel.previousStep();
    } catch (e, st) {
      _log.error('❌ previousDraftStep() failed: $e', error: e, stackTrace: st);
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Submits the case to court and returns the submitted Case model.
  Future<Case?> submitDraftCase() async {
    _log.debug('⚖️ Submitting case draft to court...');
    try {
      final Case? createdCase = await appRef.caseDraftViewModel.submitCase();
      _log.debug('✅ Case draft submitted successfully: ${createdCase?.id}');
      return createdCase;
    } catch (e, st) {
      _log.error('❌ submitDraftCase() failed: $e', error: e, stackTrace: st);
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }
}
