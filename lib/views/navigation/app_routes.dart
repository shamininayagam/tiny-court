import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../cases/case_details_screen.dart';
import '../cases/create_case_screen.dart';
import '../cases/review_case_screen.dart';
import '../courtroom/courtroom_screen.dart';
import '../verdict/verdict_details_screen.dart';
import 'main_navigation_screen.dart';

part 'app_routes.g.dart';

RouterConfig<Object> appRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
  );
}

/// Base class for all route data in Tiny Court.
abstract class AppRouterData extends GoRouteData {
  const AppRouterData();

  Widget buildWidget(BuildContext context, GoRouterState state);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildWidget(context, state);
}

/// Root route hosting the bottom navigation IndexedStack tabs.
@TypedGoRoute<MainNavigationRoute>(
  path: '/',
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<CreateCaseRoute>(path: 'cases/create'),
    TypedGoRoute<ReviewCaseRoute>(path: 'cases/:id/review'),
    TypedGoRoute<CourtroomRoute>(path: 'courtroom/:id'),
    TypedGoRoute<VerdictDetailsRoute>(path: 'verdict/:id'),
    TypedGoRoute<CaseDetailsRoute>(path: 'cases/:id'),
  ],
)
class MainNavigationRoute extends AppRouterData with $MainNavigationRoute {
  const MainNavigationRoute();

  @override
  Widget buildWidget(BuildContext context, GoRouterState state) =>
      const MainNavigationScreen();
}

/// Wizard screen for creating a new petty dispute case.
class CreateCaseRoute extends AppRouterData with $CreateCaseRoute {
  const CreateCaseRoute({this.templateId});

  final String? templateId;

  @override
  Widget buildWidget(BuildContext context, GoRouterState state) =>
      CreateCaseScreen(templateId: templateId);
}

/// Docket review screen before submitting to courtroom.
class ReviewCaseRoute extends AppRouterData with $ReviewCaseRoute {
  const ReviewCaseRoute({required this.id});

  final String id;

  @override
  Widget buildWidget(BuildContext context, GoRouterState state) =>
      ReviewCaseScreen(caseId: id);
}

/// Fullscreen animated Courtroom trial experience.
class CourtroomRoute extends AppRouterData with $CourtroomRoute {
  const CourtroomRoute({required this.id});

  final String id;

  @override
  Widget buildWidget(BuildContext context, GoRouterState state) =>
      CourtroomScreen(caseId: id);
}

/// Fullscreen Verdict decree, comedic punishments, and share sheet.
class VerdictDetailsRoute extends AppRouterData with $VerdictDetailsRoute {
  const VerdictDetailsRoute({required this.id});

  final String id;

  @override
  Widget buildWidget(BuildContext context, GoRouterState state) =>
      VerdictDetailsScreen(caseId: id);
}

/// Read-only case details view.
class CaseDetailsRoute extends AppRouterData with $CaseDetailsRoute {
  const CaseDetailsRoute({required this.id});

  final String id;

  @override
  Widget buildWidget(BuildContext context, GoRouterState state) =>
      CaseDetailsScreen(caseId: id);
}
