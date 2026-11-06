import 'package:flutter_state_notifier/flutter_state_notifier.dart';

import '../core/view_model/view_model.dart';
import '../data/repository.dart';
import '../model/app_state.dart';
import '../provider/app_state_notifier.dart';
import '../ui.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, this.child, required this.repo});

  final Widget? child;
  final AppRepository repo;

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<AppViewModel, AppState>(
      create: (_) => AppViewModel(repo),
      child: child,
    );
  }
}

class AppViewModel extends AppStateNotifier<AppState>
    implements AppBaseViewModel {
  AppViewModel(this._repo) : super(AppState());

  final AppRepository _repo;

  @override
  Future<void> init() async {
    await _repo.init();
  }

  void decrement() {
    state = state.rebuild((AppStateBuilder b) => b.count = b.count! - 1);
  }

  void increment() {
    state = state.rebuild((AppStateBuilder b) => b.count = b.count! + 1);
  }
}
