import 'package:state_notifier/state_notifier.dart';

abstract class AppStateNotifier<T> extends StateNotifier<T> {
  AppStateNotifier(super.state);

  T getState() => state;
}
