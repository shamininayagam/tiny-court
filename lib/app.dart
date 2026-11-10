import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiny_court/utils/error_utils.dart';

import 'data/repository.dart';
import 'env/environment.dart';
import 'provider/app_providers.dart';
import 'ui.dart';
import 'views/navigation/app_routes.dart';
import 'views/widgets/app_theme.dart';

/// Boots the application for a given [Environment] (pogo_alarm standard).
Future<void> bootstrapApp({required Environment environment}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await runZonedGuarded<Future<void>>(
    () async {
      final AppRepository repo = AppRepository(environment);
      await repo.init();

      runApp(
        ProviderScope(
          overrides: [
            appRepositoryProvider.overrideWithValue(repo),
          ],
          child: const TinyCourtApp(),
        ),
      );
    },
    (Object error, StackTrace stack) async {
      AppErrorUtils.handleError(error, stack);
    },
  );
}

/// Backwards-compatible `app(env)` runner.
Future<void> app(Environment env) => bootstrapApp(environment: env);

/// Root application widget configuring theme, localization, and GoRouter.
class TinyCourtApp extends ConsumerStatefulWidget {
  const TinyCourtApp({super.key});

  @override
  ConsumerState<TinyCourtApp> createState() => _TinyCourtAppState();
}

class _TinyCourtAppState extends ConsumerState<TinyCourtApp> {
  late final RouterConfig<Object> _router;

  @override
  void initState() {
    super.initState();
    _router = appRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tiny Court',
      debugShowCheckedModeBanner: false,
      darkTheme: getTheme(isDarkMode: true),
      theme: getTheme(),
      routerConfig: _router,
      locale: AppStringsDelegate.english,
      supportedLocales: AppStringsDelegate.appSupportedLocales,
      localizationsDelegates: AppStringsDelegate.delegates,
    );
  }
}
