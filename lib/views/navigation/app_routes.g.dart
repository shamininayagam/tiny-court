// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$mainNavigationRoute];

RouteBase get $mainNavigationRoute => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $MainNavigationRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'cases/create',
      hasOverriddenOnExit: false,
      factory: $CreateCaseRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'cases/:id/review',
      hasOverriddenOnExit: false,
      factory: $ReviewCaseRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'courtroom/:id',
      hasOverriddenOnExit: false,
      factory: $CourtroomRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'verdict/:id',
      hasOverriddenOnExit: false,
      factory: $VerdictDetailsRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'cases/:id',
      hasOverriddenOnExit: false,
      factory: $CaseDetailsRoute._fromState,
    ),
  ],
);

mixin $MainNavigationRoute on GoRouteData {
  static MainNavigationRoute _fromState(GoRouterState state) =>
      const MainNavigationRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CreateCaseRoute on GoRouteData {
  static CreateCaseRoute _fromState(GoRouterState state) =>
      CreateCaseRoute(templateId: state.uri.queryParameters['template-id']);

  CreateCaseRoute get _self => this as CreateCaseRoute;

  @override
  String get location => GoRouteData.$location(
    '/cases/create',
    queryParams: {
      if (_self.templateId != null) 'template-id': _self.templateId,
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ReviewCaseRoute on GoRouteData {
  static ReviewCaseRoute _fromState(GoRouterState state) =>
      ReviewCaseRoute(id: state.pathParameters['id']!);

  ReviewCaseRoute get _self => this as ReviewCaseRoute;

  @override
  String get location =>
      GoRouteData.$location('/cases/${Uri.encodeComponent(_self.id)}/review');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CourtroomRoute on GoRouteData {
  static CourtroomRoute _fromState(GoRouterState state) =>
      CourtroomRoute(id: state.pathParameters['id']!);

  CourtroomRoute get _self => this as CourtroomRoute;

  @override
  String get location =>
      GoRouteData.$location('/courtroom/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $VerdictDetailsRoute on GoRouteData {
  static VerdictDetailsRoute _fromState(GoRouterState state) =>
      VerdictDetailsRoute(id: state.pathParameters['id']!);

  VerdictDetailsRoute get _self => this as VerdictDetailsRoute;

  @override
  String get location =>
      GoRouteData.$location('/verdict/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CaseDetailsRoute on GoRouteData {
  static CaseDetailsRoute _fromState(GoRouterState state) =>
      CaseDetailsRoute(id: state.pathParameters['id']!);

  CaseDetailsRoute get _self => this as CaseDetailsRoute;

  @override
  String get location =>
      GoRouteData.$location('/cases/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
