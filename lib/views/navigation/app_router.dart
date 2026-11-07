import 'package:go_router/go_router.dart';

import '../cases/case_details_screen.dart';
import '../cases/create_case_screen.dart';
import '../cases/review_case_screen.dart';
import '../courtroom/courtroom_screen.dart';
import '../verdict/verdict_details_screen.dart';
import 'main_navigation_screen.dart';

/// Central application router configuration using nested child routes under `/`.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainNavigationScreen(),
      routes: [
        GoRoute(
          path: 'cases/create',
          builder: (context, state) {
            final templateId = state.uri.queryParameters['templateId'];
            return CreateCaseScreen(templateId: templateId);
          },
        ),
        GoRoute(
          path: 'cases/:id/review',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ReviewCaseScreen(caseId: id);
          },
        ),
        GoRoute(
          path: 'courtroom/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return CourtroomScreen(caseId: id);
          },
        ),
        GoRoute(
          path: 'verdict/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return VerdictDetailsScreen(caseId: id);
          },
        ),
        GoRoute(
          path: 'cases/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return CaseDetailsScreen(caseId: id);
          },
        ),
      ],
    ),
  ],
);
