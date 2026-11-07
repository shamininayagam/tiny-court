import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

export 'provider_utils.dart';

/// App-owned abstraction over Riverpod's [WidgetRef] adhering to DIP (Dependency Inversion Principle).
///
/// Domain-specific ViewModel extensions and state accessors are defined
/// in `provider_utils.dart`.
class AppRef {
  const AppRef(this._ref);

  final WidgetRef _ref;

  /// Underlying raw WidgetRef.
  WidgetRef get ref => _ref;

  /// Watches [listenable] and rebuilds the calling widget when value updates.
  T watch<T>(ProviderListenable<T> listenable) => _ref.watch(listenable);

  /// Performs a one-shot read of [listenable] without subscribing to changes.
  T read<T>(ProviderListenable<T> listenable) => _ref.read(listenable);

  /// Subscribes to [listenable] for external side effects.
  void listen<T>(
    ProviderListenable<T> listenable,
    void Function(T? previous, T next) listener,
  ) =>
      _ref.listen(listenable, listener);
}

/// Stateless base widget for reactive UI screens.
///
/// Subclasses implement [buildApp] receiving [AppRef] rather than Riverpod's [WidgetRef].
abstract class AppConsumerWidget extends ConsumerWidget {
  const AppConsumerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      buildApp(context, AppRef(ref));

  /// Builds the widget with app-scoped provider access.
  Widget buildApp(BuildContext context, AppRef ref);
}

/// Stateful base widget for reactive UI screens.
abstract class AppConsumerStatefulWidget extends ConsumerStatefulWidget {
  const AppConsumerStatefulWidget({super.key});
}

/// Base state paired with [AppConsumerStatefulWidget].
///
/// Exposes [appRef] for reactive state inspection and ViewModel dispatch.
abstract class AppConsumerState<T extends AppConsumerStatefulWidget>
    extends ConsumerState<T> {
  /// App-scoped provider access for this state.
  AppRef get appRef => AppRef(ref);
}
