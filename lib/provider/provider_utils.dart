import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/app_state.dart';
import '../model/states/case_draft_state.dart';
import '../model/states/case_history_state.dart';
import '../model/states/courtroom_state.dart';
import '../ui.dart';
import '../view_model/app_view_model.dart';
import '../view_model/case_creation/case_draft_view_model.dart';
import '../view_model/case_history/case_history_view_model.dart';
import '../view_model/courtroom/courtroom_view_model.dart';

export 'app_consumer.dart';

/// Legacy BuildContext extension for template counter demo
extension ProviderUtils on BuildContext {
  AppViewModel get appViewModel => read<AppViewModel>();
  AppState get appState => watch<AppState>();
}

/// Legacy AppProviderMixin for template counter demo
mixin AppProviderMixin<S extends StatefulWidget> on State<S> {
  AppState get appState => context.watch<AppState>();
}

/// Typed ViewModel and State accessors on [AppRef] (pogo_alarm standard).
extension AppRefBridge on AppRef {
  // ── ViewModel Notifiers (Actions & Mutations) ─────────────────────────────

  /// Accessor for Case Creation Wizard ViewModel.
  CaseDraftViewModel get caseDraftViewModel =>
      read(caseDraftViewModelProvider.notifier);

  /// Accessor for Courtroom Orchestrator ViewModel.
  CourtroomViewModel get courtroomViewModel =>
      read(courtroomViewModelProvider.notifier);

  /// Accessor for Case History & Search ViewModel.
  CaseHistoryViewModel get caseHistoryViewModel =>
      read(caseHistoryViewModelProvider.notifier);

  // ── Reactive State Watchers (UI Subscriptions) ────────────────────────────

  /// Reactive watch on Case Creation Wizard state.
  CaseDraftState get caseDraftState => watch(caseDraftViewModelProvider);

  /// Reactive watch on active Courtroom trial state.
  CourtroomState? get courtroomState => watch(courtroomViewModelProvider);

  /// Reactive watch on Case History list & search state.
  CaseHistoryState get caseHistoryState => watch(caseHistoryViewModelProvider);
}

/// Typed ViewModel and State accessors directly on Riverpod's [WidgetRef].
extension WidgetRefBridge on WidgetRef {
  CaseDraftViewModel get caseDraftViewModel =>
      read(caseDraftViewModelProvider.notifier);

  CourtroomViewModel get courtroomViewModel =>
      read(courtroomViewModelProvider.notifier);

  CaseHistoryViewModel get caseHistoryViewModel =>
      read(caseHistoryViewModelProvider.notifier);

  CaseDraftState get caseDraftState => watch(caseDraftViewModelProvider);

  CourtroomState? get courtroomState => watch(courtroomViewModelProvider);

  CaseHistoryState get caseHistoryState => watch(caseHistoryViewModelProvider);
}
