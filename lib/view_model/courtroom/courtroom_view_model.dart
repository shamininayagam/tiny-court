import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/services/verdict_service.dart';
import '../../data/repository.dart';
import '../../model/case.dart';
import '../../model/states/courtroom_state.dart';
import '../../model/verdict.dart';
import '../../provider/app_providers.dart';
import '../../utils/app_logger.dart';
import '../base_view_model.dart';

part 'courtroom_view_model.g.dart';

/// Feature ViewModel managing the 7 dramatic trial sequence stages, auto-play timer,
/// and live verdict adjudication.
@Riverpod(keepAlive: true)
class CourtroomViewModel extends _$CourtroomViewModel implements BaseViewModel {
  CourtroomViewModel({VerdictService? verdictService})
      : _verdictServiceOverride = verdictService;

  static const String _tag = 'CourtroomViewModel';
  static final AppLogger _log = AppLogger.get(_tag);

  final VerdictService? _verdictServiceOverride;

  AppRepository get _repo => ref.read(appRepositoryProvider);

  VerdictService get _verdictService =>
      _verdictServiceOverride ?? _repo.verdictService;

  Timer? _stageTimer;

  @override
  CourtroomState? build() {
    ref.onDispose(() {
      dispose();
    });
    return null;
  }

  @override
  Future<void> init() async {}

  @override
  Future<void> dispose() async {
    _stageTimer?.cancel();
    _stageTimer = null;
  }

  void initSession(Case courtCase) {
    _log.debug('🏛️ Initializing trial session for case ${courtCase.id}');
    _stageTimer?.cancel();

    state = CourtroomState((b) => b
      ..courtCase = courtCase.toBuilder()
      ..currentStage = CourtroomStage.entrance
      ..isAutoPlaying = true
      ..isSkipped = false
      ..currentJudgeDialogue =
          'All rise! The Tiny Court is now in session for Case ${courtCase.caseNumber}.');

    _scheduleNextStage(CourtroomStage.entrance);
  }

  void _scheduleNextStage(CourtroomStage current) {
    _stageTimer?.cancel();
    final currentState = state;
    if (currentState == null || !currentState.isAutoPlaying || currentState.isSkipped) {
      return;
    }

    final duration = switch (current) {
      CourtroomStage.entrance => const Duration(milliseconds: 2200),
      CourtroomStage.judgeIntro => const Duration(milliseconds: 2400),
      CourtroomStage.plaintiffPresentation => const Duration(milliseconds: 3500),
      CourtroomStage.defendantPresentation => const Duration(milliseconds: 3500),
      CourtroomStage.deliberation => const Duration(milliseconds: 2800),
      CourtroomStage.verdictReveal => const Duration(milliseconds: 3000),
      CourtroomStage.adjourned => Duration.zero,
      _ => Duration.zero,
    };

    if (duration > Duration.zero) {
      _stageTimer = Timer(duration, progressToNextStage);
    }
  }

  void progressToNextStage() {
    _stageTimer?.cancel();
    final current = state;
    if (current == null) return;

    final Case? courtCase = current.courtCase;
    if (courtCase == null) return;

    switch (current.currentStage) {
      case CourtroomStage.entrance:
        state = current.rebuild((b) => b
          ..currentStage = CourtroomStage.judgeIntro
          ..currentJudgeDialogue =
              'Order! Order in the court! We will now hear "${courtCase.title}".');
        _scheduleNextStage(CourtroomStage.judgeIntro);
        break;

      case CourtroomStage.judgeIntro:
        state = current.rebuild((b) => b
          ..currentStage = CourtroomStage.plaintiffPresentation
          ..currentJudgeDialogue =
              'The Plaintiff, ${courtCase.plaintiffName}, will state their grievance.');
        _scheduleNextStage(CourtroomStage.plaintiffPresentation);
        break;

      case CourtroomStage.plaintiffPresentation:
        state = current.rebuild((b) => b
          ..currentStage = CourtroomStage.defendantPresentation
          ..currentJudgeDialogue =
              'The Defendant, ${courtCase.defendantName}, will present their defense.');
        _scheduleNextStage(CourtroomStage.defendantPresentation);
        break;

      case CourtroomStage.defendantPresentation:
        state = current.rebuild((b) => b
          ..currentStage = CourtroomStage.deliberation
          ..currentJudgeDialogue =
              'The Honorable Judge Barnaby will now ponder this profound silliness...');
        _adjudicateAndAdvance();
        break;

      case CourtroomStage.deliberation:
        state = current.rebuild((b) => b
          ..currentStage = CourtroomStage.verdictReveal
          ..currentJudgeDialogue =
              current.generatedVerdict?.judgeStatement ?? 'The Court has reached its final decision!');
        _scheduleNextStage(CourtroomStage.verdictReveal);
        break;

      case CourtroomStage.verdictReveal:
        state = current.rebuild((b) => b
          ..currentStage = CourtroomStage.adjourned
          ..currentJudgeDialogue = 'Court is adjourned! Case dismissed.');
        break;

      case CourtroomStage.adjourned:
        break;
      default:
        break;
    }
  }

  Future<void> _adjudicateAndAdvance() async {
    final current = state;
    if (current == null || current.courtCase == null) return;

    try {
      final Verdict verdict =
          await _verdictService.adjudicateCase(current.courtCase!);

      final updated = state;
      if (updated != null && updated.courtCase != null) {
        state = updated.rebuild((b) => b
          ..generatedVerdict = verdict.toBuilder()
          ..currentJudgeDialogue =
              'Gavel strikes! The verdict is in for ${updated.courtCase!.title}.');
        _scheduleNextStage(CourtroomStage.deliberation);
      }
    } catch (e, st) {
      _log.error('❌ _adjudicateAndAdvance error: $e', error: e, stackTrace: st);
      final updated = state;
      if (updated != null) {
        state = updated.rebuild((b) => b
          ..currentJudgeDialogue =
              'The court encountered a clerical error! Please try again.');
      }
      rethrow;
    }
  }

  Future<void> skipToVerdict() async {
    _log.debug('⏩ Skipping directly to verdict reveal...');
    _stageTimer?.cancel();
    final current = state;
    if (current == null || current.courtCase == null) return;

    try {
      final Verdict verdict =
          await _verdictService.adjudicateCase(current.courtCase!);

      state = current.rebuild((b) => b
        ..isSkipped = true
        ..isAutoPlaying = false
        ..generatedVerdict = verdict.toBuilder()
        ..currentStage = CourtroomStage.verdictReveal
        ..currentJudgeDialogue =
            verdict.judgeStatement.isNotEmpty ? verdict.judgeStatement : 'The verdict is in!');
    } catch (e, st) {
      _log.error('❌ skipToVerdict error: $e', error: e, stackTrace: st);
      rethrow;
    }
  }

  void toggleAutoPlay(bool enable) {
    final current = state;
    if (current == null) return;

    state = current.rebuild((b) => b..isAutoPlaying = enable);
    if (enable) {
      _scheduleNextStage(current.currentStage);
    } else {
      _stageTimer?.cancel();
    }
  }

  void resetSession() {
    _log.debug('🧹 Resetting courtroom session.');
    _stageTimer?.cancel();
    state = null;
  }
}
