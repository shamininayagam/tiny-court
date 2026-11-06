import '../model/app_state.dart';
import '../ui.dart';
import '../view_model/app_view_model.dart';

extension ProviderUtils on BuildContext {
  AppViewModel get appViewModel => read<AppViewModel>();
  AppState get appState => watch<AppState>();
}

mixin AppProviderMixin<S extends StatefulWidget> on State<S> {
  AppState get appState => context.watch<AppState>();
}
