/// Base contract implemented by every feature ViewModel.
///
/// Keeps lifecycle handling uniform across features: the Riverpod provider
/// calls [init] when the ViewModel is first built and [dispose] when it is
/// destroyed. Concrete ViewModels live in feature subfolders such as
/// `lib/view_model/courtroom/` and follow the `*_view_model.dart` +
/// `*_state.dart` naming convention.
abstract class BaseViewModel {
  /// Called once after the ViewModel is created.
  ///
  /// Kick off initial data loading and subscriptions here.
  Future<void> init();

  /// Called when the ViewModel is no longer needed.
  ///
  /// Cancel subscriptions, timers, and streams here.
  Future<void> dispose();
}
