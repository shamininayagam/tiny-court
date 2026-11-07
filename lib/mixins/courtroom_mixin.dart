import '../model/case.dart';
import '../model/states/courtroom_state.dart';
import '../ui.dart';

/// Mixin providing UI state access and sequence controls for the Courtroom Experience.
///
/// Flow: UI -> CourtroomMixin -> CourtroomViewModel -> VerdictService -> VerdictServiceImpl
///
/// Dispatches actions to [CourtroomViewModel] via [appRef] with structured logging,
/// mounted-guarded error presentation, and rethrow semantics adhering to the pogo_alarm standard.
mixin CourtroomMixin<T extends AppConsumerStatefulWidget>
    on AppConsumerState<T> {
  static const String _tag = 'CourtroomMixin';
  static final AppLogger _log = AppLogger.get(_tag);

  /// Reactive watch on the active courtroom session state.
  CourtroomState? get courtroomState => appRef.courtroomState;

  /// Initializes and begins a new trial session for [courtCase].
  void initCourtroomSession({required Case courtCase}) {
    _log.debug('🏛️ Initializing courtroom session for case: ${courtCase.id}');
    try {
      appRef.courtroomViewModel.initSession(courtCase);
      _log.debug('✅ Courtroom session initialized.');
    } catch (e, st) {
      _log.error(
        '❌ initCourtroomSession() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Advances to the next dramatic sequence stage.
  void progressCourtroomStage() {
    _log.debug('⏭️ Progressing courtroom stage...');
    try {
      appRef.courtroomViewModel.progressToNextStage();
      _log.debug('✅ Courtroom stage advanced.');
    } catch (e, st) {
      _log.error(
        '❌ progressCourtroomStage() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Skips directly to verdict deliberation and reveal.
  Future<void> skipCourtroomToVerdict() async {
    _log.debug('⏩ Skipping courtroom trial straight to verdict...');
    try {
      await appRef.courtroomViewModel.skipToVerdict();
      _log.debug('✅ Skipped to verdict deliberation.');
    } catch (e, st) {
      _log.error(
        '❌ skipCourtroomToVerdict() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Toggles automatic timeline progression.
  void toggleCourtroomAutoPlay({required bool enable}) {
    _log.debug('⏯️ Toggling courtroom auto-play: $enable');
    try {
      appRef.courtroomViewModel.toggleAutoPlay(enable);
    } catch (e, st) {
      _log.error(
        '❌ toggleCourtroomAutoPlay() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }

  /// Clears active courtroom trial session upon exit.
  void resetCourtroomSession() {
    _log.debug('🧹 Resetting courtroom session...');
    try {
      appRef.courtroomViewModel.resetSession();
      _log.debug('✅ Courtroom session reset.');
    } catch (e, st) {
      _log.error(
        '❌ resetCourtroomSession() failed: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) context.showError(e, stackTrace: st);
      rethrow;
    }
  }
}
