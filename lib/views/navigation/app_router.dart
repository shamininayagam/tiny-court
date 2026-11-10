import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

export 'app_routes.dart';

/// Central application router using generated typed route definitions.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: $appRoutes,
  debugLogDiagnostics: kDebugMode,
);
